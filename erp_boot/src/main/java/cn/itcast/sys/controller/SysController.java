package cn.itcast.sys.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("sys")
public class SysController {
	
	/**
	 * 去登录页面
	 * @return
	 */
	@RequestMapping("toLogin")
	public String toLogin() {
		return "sys/main/login";
	
	}
	
	/**
	 * 去主页面
	 * @return
	 */
	@RequestMapping("toIndex")
	public String toIndex() {
		return "sys/main/index";
		
	}
	
	/**
	 * 去工作台
	 * @return
	 */
	@RequestMapping("toDeskManager")
	public String toDeskManager() {
		return "sys/main/deskManager";
		
	}
	
	/**
	 * 去日志管理
	 * @return
	 */
	@RequestMapping("toLoginInfoManager")
	public String toLoginInfoManager() {
		return "sys/loginfo/loginInfoManager";
		
	}
	
	/**
	 * 去公告管理
	 * @return
	 */
	@RequestMapping("toNoticeManager")
	public String toNoticeManager() {
		return "sys/notice/noticeManager";
		
	}
	
	/**
	 * 去部门管理
	 * @return
	 */
	@RequestMapping("toDeptManager")
	public String toDeptManager() {
		return "sys/dept/deptManager";
		
	}
	/**
	 * 去部门管理  -- left
	 * @return
	 */
	@RequestMapping("toDeptLeft")
	public String toDeptLeft() {
		return "sys/dept/deptLeft";
		
	}
	/**
	 * 去部门管理 -- right
	 * @return
	 */
	@RequestMapping("toDeptRight")
	public String toDeptRight() {
		return "sys/dept/deptRight";
		
	}
	
	
	/**
	 * 去菜单管理
	 * @return
	 */
	@RequestMapping("toMenuManager")
	public String toMenuManager() {
		return "sys/menu/menuManager";
		
	}
	/**
	 * 去菜单管理  -- left
	 * @return
	 */
	@RequestMapping("toMenuLeft")
	public String toMenuLeft() {
		return "sys/menu/menuLeft";
		
	}
	/**
	 * 去菜单管理 -- right
	 * @return
	 */
	@RequestMapping("toMenuRight")
	public String toMenuRight() {
		return "sys/menu/menuRight";
		
	}
	
	/**
	 * 去权限管理
	 * @return
	 */
	@RequestMapping("toPermissionManager")
	public String toPermissionManager() {
		return "sys/permission/permissionManager";
		
	}
	/**
	 * 去权限管理  -- left
	 * @return
	 */
	@RequestMapping("toPermissionLeft")
	public String toPermissionLeft() {
		return "sys/permission/permissionLeft";
		
	}
	/**
	 * 去权限管理 -- right
	 * @return
	 */
	@RequestMapping("toPermissionRight")
	public String toPermissionRight() {
		return "sys/permission/permissionRight";
		
	}
	
	/**
	 * 去角色管理
	 * @return
	 */
	@RequestMapping("toRoleManager")
	public String toRoleManager() {
		return "sys/role/roleManager";
		
	}
	
	
	/**
	 * 去用户管理
	 * @return
	 */
	@RequestMapping("toUserManager")
	public String toUserManager() {
		return "sys/user/userManager";
		
	}
	
	/**
	 * 去缓存管理
	 * @return
	 */
	@RequestMapping("toCacheManager")
	public String toCacheManager() {
		return "sys/cache/cacheManager";
		
	}
	
	/**
	 * 去修改密码
	 * @return
	 */
	@RequestMapping("toChangePwd")
	public String toChangePwd() {
		return "sys/user/changePwd";		
	}
	
	/**
	 * 去技术管理
	 * @return
	 */
	@RequestMapping("toTechnologyManager")
	public String toTechnologyManager() {
		return "sys/technology/technologyManager";		
	}
	
	
	/**
	 * 去用户信息管理
	 * @return
	 */
	@RequestMapping("toMyUserInfo")
	public String toMyUserInfo() {
		return "sys/user/myUserInfo";		
	}
	
	
	/**
	 * 去请假单管理
	 * @return
	 */
	@RequestMapping("toLeaveBillManager")
	public String toLeaveBillManager() {
		return "sys/leaveBill/leaveBillManager";		
	}
	
	/**
	 * 去工作流管理
	 * @return
	 */
	@RequestMapping("toWorkFlowManager")
	public String toWorkFlowManager() {
		return "sys/workflow/workFlowManager";		
	}
	
	/**
	 * 去任务管理
	 * @return
	 */
	@RequestMapping("toTaskManager")
	public String toTaskManager() {
		return "sys/workflow/task/taskManager";		
	}
	
	
	
	

	

}
