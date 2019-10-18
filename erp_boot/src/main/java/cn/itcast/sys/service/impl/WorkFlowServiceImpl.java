package cn.itcast.sys.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipInputStream;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.itcast.sys.common.Constant;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.mapper.LeavebillMapper;
import cn.itcast.sys.pojo.Leavebill;
import cn.itcast.sys.service.WorkFlowService;
import cn.itcast.sys.util.WebUtils;
import cn.itcast.sys.vo.WorkFlowVo;
import cn.itcast.sys.vo.act.ActCommentEntity;
import cn.itcast.sys.vo.act.ActDeployEntity;
import cn.itcast.sys.vo.act.ActProcessDefEntity;
import cn.itcast.sys.vo.act.ActTaskEntity;

@Service
@Transactional
public class WorkFlowServiceImpl implements WorkFlowService {

	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private HistoryService historyService;

	@Autowired
	private LeavebillMapper leavebillMapper;

	/**
	 * 查询所有流程部署
	 * 
	 * @return
	 */
	public DataGrid queryAllDeployment(WorkFlowVo workFlowVo) {

		// 0.先判断部署名称是否为空
		// 为空设置为空字符串
		if (StringUtils.isBlank(workFlowVo.getDeploymentName())) {
			workFlowVo.setDeploymentName("");
		}

		// 1.查询总条数
		String deploymentName = workFlowVo.getDeploymentName();
		Long count = repositoryService.createDeploymentQuery().deploymentNameLike("%" + deploymentName + "%").count();
		// 2.查询数据
		// 这个还是按照原来的公式
		int firstResult = (workFlowVo.getPage() - 1) * workFlowVo.getLimit();
		// 每页条数
		int maxResults = workFlowVo.getLimit();
		List<Deployment> dlist = repositoryService.createDeploymentQuery()
				.deploymentNameLike("%" + deploymentName + "%").listPage(firstResult, maxResults);

		// 3.封装数据
		ArrayList<ActDeployEntity> alist = new ArrayList<>();
		// 遍历查出来的数据，装到新bean返回页面
		for (Deployment deployment : dlist) {
			ActDeployEntity actDeployEntity = new ActDeployEntity();
			// 赋值属性
			BeanUtils.copyProperties(deployment, actDeployEntity);
			alist.add(actDeployEntity);
		}

		return new DataGrid(count, alist);
	}

	/**
	 * 查询所有流程定义
	 * 
	 * @return
	 */
	public DataGrid queryAllProcessDef(WorkFlowVo workFlowVo) {

		// 0.先判断部署名称是否为空
		// 为空设置为空字符串
		if (StringUtils.isBlank(workFlowVo.getDeploymentName())) {
			workFlowVo.setDeploymentName("");
		}

		// 1.根据部署名称模糊查询所有的部署
		String deploymentName = workFlowVo.getDeploymentName();

		List<Deployment> dlist = repositoryService.createDeploymentQuery()
				.deploymentNameLike("%" + deploymentName + "%").list();

		// 2.接着遍历组装成 didsSet
		Set<String> didSet = new HashSet<>();
		for (Deployment deployment : dlist) {
			didSet.add(deployment.getId());
		}

		// 3.接着判断是否这个didSet是否为空 且有集合的size大于0
		long count = 0; // 默认没有数据,流程定义的集合不为空才查询数据
		List<ActProcessDefEntity> plist = new ArrayList<>();

		if (didSet != null && didSet.size() > 0) {
			// 3.1不为空才查询到数据 查总条数
			count = repositoryService.createProcessDefinitionQuery().deploymentIds(didSet).count();

			// 3.2查全部数据
			int firstResult = (workFlowVo.getPage() - 1) * workFlowVo.getLimit();
			int maxResults = workFlowVo.getLimit();
			List<ProcessDefinition> processDefs = repositoryService.createProcessDefinitionQuery().deploymentIds(didSet)
					.listPage(firstResult, maxResults);

			// 3.3因为因为是不能转为json,所以也要自己搞一个类来赋值属性

			for (ProcessDefinition processDefinition : processDefs) {
				ActProcessDefEntity processDefEntity = new ActProcessDefEntity();
				// 复制属性
				BeanUtils.copyProperties(processDefinition, processDefEntity);

				// 这个存放可以返回页面封装号的bean
				plist.add(processDefEntity);
			}

		}

		return new DataGrid(count, plist);
	}

	/**
	 * 添加流程部署
	 * 
	 * @return
	 */
	public void addWorkFlow(InputStream inputStream, WorkFlowVo workFlowVo) {

		ZipInputStream zipInputStream = new ZipInputStream(inputStream);
		// 部署
		repositoryService.createDeployment().name(workFlowVo.getDeploymentName()).addZipInputStream(zipInputStream)
				.deploy();

		// 关闭流
		try {
			zipInputStream.close();
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 删除流程部署 暴力删除 ,有流程实例，也删除 级联删除
	 * 
	 * @return
	 */
	@Override
	public void deleteWorkFlow(String id) {
		repositoryService.deleteDeployment(id, true);

	}

	/**
	 * 批量删除
	 * 
	 * @return
	 */
	@Override
	public void deleteBatchWorkFlow(String[] ids) {
		for (String id : ids) {
			deleteWorkFlow(id);
		}
	}

	/**
	 * 查看流程图
	 * 
	 * @param workFlowVo
	 */
	public InputStream viewProcessImage(String id) {

		// 1.根据部署id查询流程定义
		ProcessDefinition processDef = repositoryService.createProcessDefinitionQuery().deploymentId(id).singleResult();

		// 2.拿到流程定义图片的名字

		// 2.拿到流程定义的图名字和 部署id拿图片
		String deploymentId = id;
		String resourceName = processDef.getDiagramResourceName();

		// repositoryService.getProcessDiagram(processDef.getId());

		return repositoryService.getResourceAsStream(deploymentId, resourceName);
	}

	/**
	 * 启动流程
	 * 
	 * @return
	 */
	@Override
	public void startProcess(Integer leaveBillId) {

		// 1.我们定义的流程图的key用类的名字
		String processDefinitionKey = Leavebill.class.getSimpleName();
		// 2.业务id用 [key:id]
		String businessKey = processDefinitionKey + ":" + leaveBillId;
		Map<String, Object> variables = new HashMap<>();
		// 3.设置下一个任务的代理人
		// 启动流程我们只有第一个需要手动设置,接下来都是监听器
		variables.put("username", WebUtils.getCurrentUserName());

		// 4.三个参数的启动流程
		runtimeService.startProcessInstanceByKey(processDefinitionKey, businessKey, variables);

		// 5.启动完成刷新请假单的状态
		Leavebill leavebill = new Leavebill();
		leavebill.setId(leaveBillId);
		leavebill.setState(Constant.STATE_LEAVEBILL_ONE);

		// 更新请假条的状态
		leavebillMapper.updateById(leavebill);

	}

	/**
	 * 查询当前代办用户的任务
	 */
	public DataGrid queryCurrentUserTask(WorkFlowVo workFlowVo) {
		// 1.获取当前登录用户
		String username = WebUtils.getCurrentUserName();
		// 2.先查询条数
		Long count = taskService.createTaskQuery().taskAssignee(username).count();
		// 3.查询数据带分页
		int firstResult = (workFlowVo.getPage() - 1) * workFlowVo.getLimit();
		int maxResults = workFlowVo.getLimit();
		List<Task> list = taskService.createTaskQuery().taskAssignee(username).orderByTaskCreateTime().desc() // 降序
				.listPage(firstResult, maxResults);

		// 4.复制bean数据
		List<ActTaskEntity> tlist = new ArrayList<>();
		for (Task task : list) {
			ActTaskEntity actTaskEntity = new ActTaskEntity();
			BeanUtils.copyProperties(task, actTaskEntity);

			// 放进集合
			tlist.add(actTaskEntity);
		}

		return new DataGrid(count, tlist);
	}

	/**
	 * 根據任务id查询请假单
	 */
	@Override
	public DataGrid queryLeavebillByTaskId(String taskId) {

		// 1.根据任务id查询任务
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		// 2.拿到流程实例id
		String processInstanceId = task.getProcessInstanceId();

		// 3.根据流程实例id查询流程实例
		ProcessInstance instance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
				.singleResult();

		// 4.拿到流程实例的key
		String businessKey = instance.getBusinessKey();
		// 5.切割拿到请假单id
		String leaveBillId = businessKey.split(":")[1];

		// 6.根据请假单查询请假单
		Leavebill leaveBill = leavebillMapper.selectById(leaveBillId);

		return new DataGrid(leaveBill);
	}

	/**
	 * 根据任务id 查询出来的线
	 * 
	 * @return
	 */
	@Override
	public DataGrid queryOutComeByTaskId(String taskId) {

		// 1.根据任务id拿到任务
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();

		// 2.根据任务id拿到实例id 和流程定义id
		String processInstanceId = task.getProcessInstanceId();
		String processDefinitionId = task.getProcessDefinitionId();

		// 3.分别查询实例和流程定义的xml对象
		ProcessInstance instance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
				.singleResult();
		// 这个entity是流程定义的实现类
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) repositoryService
				.getProcessDefinition(processDefinitionId);

		// 4.获取流程实例的当前活动节点
		String activityId = instance.getActivityId();

		// 5.根据活动节点拿流程定义xml 当前活动节点的信息
		ActivityImpl activityImpl = processDefinition.findActivity(activityId);

		// 6.拿两条出来的线的信息
		List<PvmTransition> transitions = activityImpl.getOutgoingTransitions();

		// 7.遍历放进集合
		List<String> names = new ArrayList<>();
		if (transitions != null && transitions.size() > 0) {
			for (PvmTransition pvmTransition : transitions) {

				// 获取properties的属性 name属性就是我们要的连线名字
				String name = (String) pvmTransition.getProperty("name");
				names.add(name);
			}
		}

		return new DataGrid(names);
	}

	/**
	 * 查询批注信息根据任务id
	 * 
	 * @return
	 */
	@Override
	public DataGrid queryCommentByTaskId(String taskId) {

		// 1.根据任务id查询任务实例
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();

		// 2.拿到实例id
		String processInstanceId = task.getProcessInstanceId();

		// 3.用任务id拿出当前实例的全部批注
		List<Comment> comments = taskService.getProcessInstanceComments(processInstanceId);

		// 4.遍历复制bean
		List<ActCommentEntity> list = new ArrayList<>();
		for (Comment comment : comments) {
			ActCommentEntity actCommentEntity = new ActCommentEntity();
			BeanUtils.copyProperties(comment, actCommentEntity);

			list.add(actCommentEntity);
		}

		return new DataGrid((long) list.size(), list);

	}

	/**
	 * 完成任务
	 */
	public void completeTask(WorkFlowVo workFlowVo) {

		// 1.获取四个参数
		String taskId = workFlowVo.getTaskId();
		Integer leaveBillId = workFlowVo.getLeaveBillId();
		String outcome = workFlowVo.getOutcome();
		String comment = workFlowVo.getComment();

		// 2.接着根据任务id，获取任务实例
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		// 3.获取实例id
		String processInstanceId = task.getProcessInstanceId();

		// 4.设置批注人名
		String userame = WebUtils.getCurrentUserName();

		// 设置批注人名
		Authentication.setAuthenticatedUserId(userame);

		// 6.设置批注内容
		taskService.addComment(taskId, processInstanceId, "[" + outcome + "]" + comment);

		// 7.完成任务 把outcome传过来，outcome设置进流程变量，outcome决定流程走向
		Map<String, Object> variables = new HashMap<>();
		variables.put("outcome", outcome);
		taskService.complete(taskId, variables);

		// 8.看流程实例是否已经结束，结束就设置状态
		ProcessInstance instance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
				.singleResult();

		// 8.1如果任务流程实例为空 说明流程已经结束
		if (instance == null) {

			Leavebill leavebill = new Leavebill();
			leavebill.setId(leaveBillId);

			// 如果是同意，说明上上级领导同意，请假已经批准
			if (StringUtils.equals(outcome, Constant.OUTCOME_AGREE)) {
				// 审批完成
				leavebill.setState(Constant.STATE_LEAVEBILL_TOW);
			} else { // 不然就是自己直接放弃的
				leavebill.setState(Constant.STATE_LEAVEBILL_THREE);
			}

			// 8.2更新请假单状态
			leavebillMapper.updateById(leavebill);
		}

	}

	 /**
     * 根据taskid查询流程部署id;
     * @return
     */
	@Override
	public DataGrid queryDeployIdByTaskId(String taskId) {
		// 1,根据任务ID查询任务实例
		Task task = taskService.createTaskQuery()
				         .taskId(taskId)
				         .singleResult();
		// 2,取出流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		// 3,根据流程实例ID查询流程实例对象
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
				.processInstanceId(processInstanceId)
				.singleResult();
		
		//4.获取部署id
		String deploymentId = processInstance.getDeploymentId();
				
		return new DataGrid(deploymentId);
	}

	  
    /**
     * 根据任務id查询任務图的坐标
     * @return
     */
	@Override
	public DataGrid queryCoordinateByTaskId(String taskId) {
		  
		Map<String, Object> coordinate = new HashMap<>();
		// 1,根据任务ID查询任务实例
		Task task = this.taskService.createTaskQuery().taskId(taskId).singleResult();
		// 2,取出流程定义ID
		String processDefinitionId = task.getProcessDefinitionId();
		// 3,取出流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		// 4,根据流程实例ID查询流程实例
		ProcessInstance processInstance = this.runtimeService.createProcessInstanceQuery()
				.processInstanceId(processInstanceId).singleResult();
		// 5,根据流程定义ID查询流程定义的XML信息
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) this.repositoryService
				.getProcessDefinition(processDefinitionId);
		// 6,从流程实例对象里面取出当前活动节点ID
		String activityId = processInstance.getActivityId();// usertask1	
		// 7,使用活动ID取出xml和当前活动ID相关节点数据
		ActivityImpl activityImpl = processDefinition.findActivity(activityId);
		
		// 8,从activityImpl取出坐标信息
		coordinate.put("x", activityImpl.getX());
		coordinate.put("y", activityImpl.getY());
		coordinate.put("width", activityImpl.getWidth());
		coordinate.put("height", activityImpl.getHeight());
		
		return new DataGrid(coordinate);
	
	}

	/**
	     * 查询审批批注根据请假单id
	 * @return
	 */
	@Override
	public DataGrid queryCommentByLeaveBillId(Integer leaveBillId) {
		// 组装businesskey
		String businessKey = Leavebill.class.getSimpleName() + ":" + leaveBillId;
		// 根据业务ID查询历史流程实例
		HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
				.processInstanceBusinessKey(businessKey).singleResult();
		// 使用taskService+流程实例ID查询批注
		List<Comment> comments = taskService.getProcessInstanceComments(historicProcessInstance.getId());
		List<ActCommentEntity> data = new ArrayList<>();
		if (null != comments && comments.size() > 0) {
			for (Comment comment : comments) {
				ActCommentEntity entity = new ActCommentEntity();
				BeanUtils.copyProperties(comment, entity);
				data.add(entity);
			}
		}
		return new DataGrid(Long.valueOf(data.size()), data);
	}

	
}
