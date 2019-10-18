package cn.itcast.sys.listener;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;

import cn.itcast.sys.mapper.UserMapper;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.util.SpringUtil;
import cn.itcast.sys.util.WebUtils;

//任务的监听器
public class TaskListenerImpl implements TaskListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void notify(DelegateTask delegateTask) {
		
		//1.设置任务代理人		
		//获取当前登录用户
		User user = WebUtils.getCurrentUser();		
		//2.获取领导id
		Integer leaderid = user.getMgr();		
		//3.解耦方式拿到usermapper
		UserMapper userMapper = SpringUtil.getBean(UserMapper.class);		
		User leader = userMapper.selectById(leaderid);
		
		//4.设置下一个任务办理人
		delegateTask.setAssignee(leader.getName());
		
	}

}
