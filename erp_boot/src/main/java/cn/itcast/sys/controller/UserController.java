package cn.itcast.sys.controller;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.hutool.core.util.IdUtil;
import cn.itcast.bus.utils.AppFileUtils;
import cn.itcast.sys.common.Constant;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;
import cn.itcast.sys.pojo.Dept;
import cn.itcast.sys.pojo.Role;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.service.DeptService;
import cn.itcast.sys.service.RoleService;
import cn.itcast.sys.service.TechnologyService;
import cn.itcast.sys.service.UserService;
import cn.itcast.sys.util.PinyinUtils;
import cn.itcast.sys.util.WebUtils;
import cn.itcast.sys.vo.UserVo;

/**
 * <p>
 *  用户controller
 * </p>
 *
 * @author 超极本
 * @since 2019-10-07
 */
@RestController
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private TechnologyService technologyService;
	
	/**
	 * 查询全部用户
	 * @param userVo
	 * @return
	 */
	@RequestMapping("queryAllUser")
	public DataGrid queryAllUser(UserVo userVo) {
		
		IPage<User> page = new Page<>(userVo.getPage(), userVo.getLimit());
		QueryWrapper<User> queryWrapper = new QueryWrapper<>();
		
		
		//条件查询		
		queryWrapper.like(StringUtils.isNotBlank(userVo.getName()), "name", userVo.getName());
		queryWrapper.like(StringUtils.isNotBlank(userVo.getLoginname()), "loginname",userVo.getLoginname()); 
		queryWrapper.like(StringUtils.isNotBlank(userVo.getAddress()),"address", userVo.getAddress()); //这个是下拉树的部门
		queryWrapper.eq(userVo.getDeptid()!=null, "deptid", userVo.getDeptid());
		 
		
		//查询出普通用户的
		queryWrapper.eq("type", Constant.USER_TYPE_NORMAL);
		
		userService.page(page, queryWrapper);
		
		//拿到数据接着来查询部门名字和领导名字设置进去
		List<User> list = page.getRecords();
		for (User user : list) {
			//部门名字
			Integer deptid = user.getDeptid();
			if (deptid!=null) {
				Dept dept = deptService.getById(deptid);
				user.setDeptname(dept.getTitle());
			}
			
			//领导名字
			Integer mgr = user.getMgr();
			if (mgr!=null) {
			    User leader =userService.getById(mgr);
			    user.setLeadername(leader.getName());
			}
		}
		
		
		return new DataGrid(page.getTotal(),list);
		
	}
	
	/**
	 * 获取最大的排序码
	 * @return
	 */
	@RequestMapping("getMaxOrderNum")
	public Map<String, Object> getMaxOrderNum() {
		
		//按排序码倒叙
		QueryWrapper<User> queryWrapper = new QueryWrapper<>();
		queryWrapper.orderByDesc("ordernum");
		//查询集合
		List<User> list = userService.list(queryWrapper);
		
		Map<String, Object> map = new HashMap<>();
		//放最大的排序码回去
		map.put("value", list.get(0).getOrdernum()+1);
		return map;		
	}
	
	/**
	 * 查询用户根据部门id 即查询这个部门的人
	 * @param userVo
	 * @return
	 */
	@RequestMapping("loadUserByDeptId")
	public DataGrid loadUserByDeptId(UserVo userVo) {
		
		QueryWrapper<User> queryWrapper = new QueryWrapper<>();
		//查询可用的，类型是普通用户的,这个部门的人
		queryWrapper.eq("type", Constant.USER_TYPE_NORMAL);
		queryWrapper.eq("available", Constant.AVAILABLE);
		queryWrapper.eq(userVo.getDeptid()!=null, "deptid", userVo.getDeptid());
		
		List<User> list = userService.list(queryWrapper );
		
		return new DataGrid(list);
	}
	
	/**
	 * 把中文转拼音
	 * @param roleVo
	 * @return
	 */
	@RequestMapping("changeChineseToPinYin")
	public Map<String, Object> changeChineseToPinYin(UserVo userVo) {
		
		//把中文转为拼音
		String loginname = PinyinUtils.getPingYin(userVo.getName());
		Map<String, Object> map = new HashMap<>();
		map.put("value",loginname);
		return map;		
	}
	
	/**
	 * 添加用户
	 * @param userVo
	 * @return
	 */
	@RequestMapping("addUser")
	public ResultObj addUser(UserVo userVo) {
		
		try {
			
			//设置雇佣日期
			userVo.setHiredate(new Date());
			//类型是普通用户
			userVo.setType(Constant.USER_TYPE_NORMAL);
			//生成一个盐
			String salt = IdUtil.simpleUUID().toUpperCase().toString();			
			userVo.setSalt(salt);
			//设置默认密码			
			String pwd = new Md5Hash(Constant.DEFAULT_PASSWORD, salt , Constant.HASH_ITERATIONS_TWO).toString();			
			userVo.setPwd(pwd);
			
			//设置默认头像
			userVo.setUserimgpath(Constant.DEFULT_USER_IMG);
			
			userService.save(userVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return ResultObj.ADD_ERROR;
		}
		
	}
	
	/**
	 * 用户id查用户
	 */
	@RequestMapping("loadUserById")
	public DataGrid loadUserById(UserVo userVo) {
		
		User user = userService.getById(userVo.getId());
		
		return new DataGrid(user);
	}
	
	/**
	 * 更新用户
	 * @param userVo
	 * @return
	 */
	@RequestMapping("updateUser")
	public ResultObj updateUser(UserVo userVo) {
	    try {
			userService.updateById(userVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();			
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	/**
	 * 删除用户
	 * @param userVo
	 * @return
	 */
	@RequestMapping("deleteUser")
	public ResultObj deleteUser(UserVo userVo) {
		try {
			userService.removeById(userVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 批量删除用户
	 * @param userVo
	 * @return
	 */
	@RequestMapping("deleteBatchUser")
	public ResultObj deleteBatchUser(UserVo userVo) {
		
		
		
		try {
			//这里组装id集合
			Integer[] ids = userVo.getIds();	
			Collection<Serializable> idList = new ArrayList<>();		
			for (Integer id : ids) {
				idList.add(id);
			}
			userService.removeByIds(idList);			
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
		
	}
	
	/**
	 * 重置密码
	 * @param userVo
	 * @return
	 */
	@RequestMapping("resetPwd")
	public ResultObj resetPwd(UserVo userVo) {
		try {
			//重新设置密码和盐
			String salt = IdUtil.simpleUUID().toUpperCase().toString();
			String pwd = new Md5Hash(Constant.DEFAULT_PASSWORD, salt, Constant.HASH_ITERATIONS_TWO).toString();		
			userVo.setSalt(salt);
			userVo.setPwd(pwd);
			
			userService.updateById(userVo);
			
			return ResultObj.RESET_SUCCESS;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			return ResultObj.RESET_ERROR;
		}
	}
	
	/**
	 * 加载用户角色，根据用户id
	 * @param userVo
	 * @return
	 */
	@RequestMapping("loadUserRoleByUserId")
	public DataGrid loadUserRoleByUserId(UserVo userVo) {
		
		QueryWrapper<Role> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		//这个方法就是把集合里面的每个对象变为map
		//查询可用的全部角色
		List<Map<String, Object>> maps = roleService.listMaps(queryWrapper );
				
		//接着查询用户所拥有的角色ids
		List<Integer> ids = roleService.queryUserRoleIdsByUid(userVo.getId());
				
		//组装数据，用于回选，选中的角色
		for (Map<String, Object> map : maps) {
			Integer roleId = (Integer) map.get("id");		
			Boolean LAY_CHECKED  = false;
			
			//遍历用户角色id集合
			for (Integer id : ids) {
				if (roleId == id) {
					LAY_CHECKED = true;
					break;
				}
			}
			
			map.put("LAY_CHECKED", LAY_CHECKED);
		}
		
		return new DataGrid((long) maps.size(), maps);
				
	}
	
	/**
	 * 分配用户角色
	 * @param userVo
	 * @return
	 */
	@RequestMapping("dispatchUserRole")
	public ResultObj dispatchUserRole(UserVo userVo) {
		
		try {
			roleService.addUserRole(userVo.getId(),userVo.getIds());
			
			return ResultObj.DISPATCH_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();			
			return ResultObj.DISPATCH_ERROR;
		}
	}
	
	
	/**
	 * 修改密码
	 * @return
	 */
	@RequestMapping("changePwd")
	public ResultObj changePwd(UserVo userVo) {
		 
		try {
			
				 
			User user = userService.getById(userVo.getId());
			
			//密码加密后再比较
			String oldPwd = new Md5Hash(userVo.getOldPwd(), user.getSalt(), Constant.HASH_ITERATIONS_TWO).toString();
			
			System.out.println(oldPwd);
			System.out.println(user.getPwd());
			if (!StringUtils.equals(oldPwd, user.getPwd())) {
				return ResultObj.OLD_PWD_ERROR;
			}
			
			//htool获取一个uuid作为盐
			 String salt = IdUtil.simpleUUID();	
			 //shiro的MD5加密密码
			 String newPwd = new Md5Hash(userVo.getPwd(), salt, Constant.HASH_ITERATIONS_TWO).toString();		 
			
			 //把新密码和盐设置进去
			 userVo.setPwd(newPwd);		
			 userVo.setSalt(salt);
			 
			 userService.updateById(userVo);			 
			 return ResultObj.MODIFY_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();			
			return ResultObj.MODIFY_ERROR;
		}
	}
	
	/**
	 * 查询当前登录的用户
	 * @return
	 */
	@RequestMapping("queryCurrUser")
	public DataGrid quertCurrUser() {		
		User user = (User) WebUtils.getHttpSession().getAttribute("user");		
		//重新查用户
		user = userService.getById(user.getId());
		return new DataGrid(user);
	}
	
	/**
	 * 查询用户信息
	 * @return
	 */
	@RequestMapping("queryUserInfo")
	public DataGrid queryUserInfo(UserVo userVo) {
		//拿到当前用户数据
		User user = userService.getById(userVo.getId());
		
		//接着拿用户id去用户技术中间表查技术id
		List<Integer> tids = technologyService.queryUserTechnologyByUid(user.getId());	
		
		//把技术id查询回来
		user.setTids(tids);
		
		//部门名字
		Integer deptid = user.getDeptid();
		System.err.println("部门id"+deptid);
		if (deptid!=null) {
			Dept dept = deptService.getById(deptid);
			user.setDeptname(dept.getTitle());
		}
		
		return new DataGrid(user);
				
	}
	
	/**
	 * 修改用户信息
	 * @param userVo
	 * @return
	 */
	@RequestMapping("updateUserInfo")
	public ResultObj updateUserInfo(UserVo userVo) {
		System.err.println("进来了");
		
		try {		
			//1.先根据id查询用户,判断之前图片是不是默认的  旧删除图片
			User user = userService.getById(userVo.getId());	
			if (!user.getUserimgpath().equals(Constant.DEFULT_USER_IMG)) {	
				
				//且提交的图片地址不是原来的图片,即如果我们更新，如果我们没有修改图片
				//即圆盘还是原来的我们就不删除原来的
				//否则删除
				if (!user.getUserimgpath().equals(userVo.getUserimgpath())) {
					AppFileUtils.removeFile(user.getUserimgpath());
				}
				
			}
			
			//2.接着改后缀，是临时图片改后缀
			//改后缀重新设置进去
			if (userVo.getUserimgpath().endsWith(Constant.FILE_UPLOAD_TEMP_SUFFIX)) {
				String newUserImgPath=AppFileUtils.updateFileName(userVo.getUserimgpath(), Constant.FILE_UPLOAD_TEMP_SUFFIX);			    
				userVo.setUserimgpath(newUserImgPath);
			}
						
			//更新用户信息
			userService.updateById(userVo);		
			
			//向中间表插入用户技术点
			technologyService.dispatchUserTechnology(userVo.getId(),userVo.getTids());
			
			return ResultObj.MODIFY_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			 return ResultObj.MODIFY_ERROR;
		}
	}
	
	/**
	 * 查询用户名，根据用户名字
	 * @return
	 */
	@RequestMapping("queryUserImgByLoginname")
	public Map<String, Object> queryUserImgByLoginname(UserVo userVo) {
		QueryWrapper<User> queryWrapper = new QueryWrapper<>();
		
		queryWrapper.eq(StringUtils.isNotBlank(userVo.getLoginname()), "loginname", userVo.getLoginname());
		List<User> list = userService.list(queryWrapper);
		
		//查询用户，然后返回用户图片
		Map<String, Object> map = new HashMap<>();
		map.put("value", list.get(0).getUserimgpath());
		
		return map;
		
	}

}

