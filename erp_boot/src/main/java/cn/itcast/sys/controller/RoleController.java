package cn.itcast.sys.controller;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.itcast.sys.common.Constant;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;
import cn.itcast.sys.common.TreeNode;
import cn.itcast.sys.pojo.Permission;
import cn.itcast.sys.pojo.Role;
import cn.itcast.sys.service.PermissionService;
import cn.itcast.sys.service.RoleService;
import cn.itcast.sys.vo.RoleVo;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 超极本
 * @since 2019-10-09
 */
@RestController
@RequestMapping("role")
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private PermissionService permissionService;
	
	/**
	 * 添加角色
	 * @param roleVo
	 * @return
	 */
	@RequestMapping("addRole")
	public ResultObj addRole(RoleVo roleVo) {
		try {
			
			//设置创建日期
			roleVo.setCreatetime(new Date());
			
			roleService.save(roleVo);
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	/**
	 * 删除角色
	 */
	@RequestMapping("deleteRole")
	public ResultObj deleteRole(RoleVo roleVo) {
		try {
			roleService.removeById(roleVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 更新角色
	 * @param roleVo
	 * @return
	 */
	@RequestMapping("updateRole")
	public ResultObj updateRole(RoleVo roleVo) {
		try {
			roleService.updateById(roleVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	/**
	 * 查询带分页带条件
	 * @param roleVo
	 * @return
	 */
	@RequestMapping("queryAllRole")
	public DataGrid queryAllRole(RoleVo roleVo) {
		IPage<Role> page = new Page<>(roleVo.getPage(), roleVo.getLimit());
		QueryWrapper<Role> queryWrapper = new QueryWrapper<>();
		
		//构造查询条件
		queryWrapper.like(StringUtils.isNotBlank(roleVo.getName()), "name",roleVo.getName());
		queryWrapper.like(StringUtils.isNotBlank(roleVo.getRemark()),"remark", roleVo.getRemark());
		roleService.page(page, queryWrapper);
		
		return new DataGrid(page.getTotal(), page.getRecords());
	}
	
	/**
	 * 加载权限通过角色id
	 * @return
	 */
	@RequestMapping("initPermissionByRid")
	public DataGrid initPermissionByRid(RoleVo roleVo) {
		//1.先查询全部权限和菜单  查询可用的
		QueryWrapper<Permission> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("available", Constant.AVAILABLE);
		List<Permission> allPermission = permissionService.list(queryWrapper);
		
		
		//2.接着查询角色自己有的权限
		//2.1用单表解决问题 ,先查询sys_role_permission的pids出来
		List<Integer> pids = roleService.queryRolePermissionId(roleVo.getId());
		
		
		//2.2用权限ids查询权限
		List<Permission> rolePermission = null;
		if (pids != null && pids.size()>0) {   //如果中间表有数据再去in来查			
			queryWrapper.in("id", pids);
			rolePermission =permissionService.list(queryWrapper);
		}else {  //中间表没有查出数据，这样角色权限就为空，直接new 一个即可
			rolePermission = new ArrayList<>();
		}
	
		//3.组装树节点
		List<TreeNode> treeNodes = new ArrayList<>();
		//3.1遍历全部  如果id相同，说明有权限，所以checkAttr设置为 "1"
		for (Permission p1 : allPermission) {
			String checkArr = "0";
			for (Permission p2 : rolePermission) {
				if (p1.getId() == p2.getId()) {
					checkArr = "1";
					break; //跳出循环
				}
			}
			//是否展开  因为权限的展开字段是null的，所以为null也设置为SPREAD_TRUE
			Boolean spread = (p1.getOpen()==null||p1.getOpen()==1)?Constant.SPREAD_TRUE:Constant.SPREAD_FALSE;
			
			//添加进节点集合
			treeNodes.add(new TreeNode(p1.getId(), p1.getPid(), p1.getTitle(), spread, checkArr));
		}
		
		return new DataGrid(treeNodes);	    
	}
	
	/**
	 * 角色分配权限
	 * @param permissionVo
	 * @return
	 */
	@RequestMapping("dispatchRolePermission")
	public ResultObj dispatchRolePermission(RoleVo roleVo) {
		try {
			roleService.dispatchRolePermission(roleVo.getId(),roleVo.getIds());
			return ResultObj.DISPATCH_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResultObj.DISPATCH_ERROR;
		}
	}

}

