package cn.itcast.sys.service;

import java.io.InputStream;

import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.vo.WorkFlowVo;

public interface WorkFlowService {

	/**
     * 查询所有部署
     * @param workFlowVo
     * @return
     */
	DataGrid queryAllDeployment(WorkFlowVo workFlowVo);

	 /**
     * 查询所有流程定义
     * @return
     */
	DataGrid queryAllProcessDef(WorkFlowVo workFlowVo);

	/**
     * 添加流程部署
     * @return
     */
	void addWorkFlow(InputStream inputStream, WorkFlowVo workFlowVo);

	 /** 
     * 删除流程部署   暴力删除 ,有流程实例，也删除   级联删除
     * @return
     */
	void deleteWorkFlow(String id);

	 /**
     * 批量删除
     * @return
     */
	void deleteBatchWorkFlow(String[] ids);

	
	 /**
     * 查看流程图
     * @param workFlowVo
     */
	InputStream viewProcessImage(String id);

	/**
     * 启动流程
     * @return
     */
	void startProcess(Integer leaveBillId);

	/**
	 * 查询当前用户的代办任务
	 * @param workFlowVo 
	 * @return
	 */
	DataGrid queryCurrentUserTask(WorkFlowVo workFlowVo);

	 /**
		     * 根据任务id查询请假单
		*/
	DataGrid queryLeavebillByTaskId(String taskId);

	 /**
	     * 查询出来的线根据任务id
		* @return
		*/
	DataGrid queryOutComeByTaskId(String taskId);

	/**
	     * 查询批注信息根据任务id
	* @return
	*/
	DataGrid queryCommentByTaskId(String taskId);

	/**
	     * 完成任务
	 * @return
	 */
	void completeTask(WorkFlowVo workFlowVo);

	 /**
     * 根据taskid查询流程部署id;
     * @return
     */
	DataGrid queryDeployIdByTaskId(String taskId);

	  
    /**
          * 根据任務id查询任務图的坐标
     * @return
     */
	DataGrid queryCoordinateByTaskId(String taskId);

	/**
	     * 查询审批批注根据请假单id
	 * @return
	 */
	DataGrid queryCommentByLeaveBillId(Integer leaveBillId);

	

}
