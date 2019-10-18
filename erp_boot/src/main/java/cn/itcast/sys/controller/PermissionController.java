package cn.itcast.sys.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import cn.itcast.sys.service.PermissionService;
import cn.itcast.sys.vo.PermissionVo;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author leijun
 * @since 2019-10-07
 */
@RestController
@RequestMapping("permission")
public class PermissionController {
	
	@Autowired
	private PermissionService permissionService;
	
	/**
	 * 加载左边的菜单树
	 * @return
	 */
	@RequestMapping("loadLeftPermissionJson")
	public DataGrid loadLeftMenuTreeJson() {
		
		//组装条件,只查询菜单的
		QueryWrapper<Permission> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("type", Constant.TYPE_MENU);
		
		List<Permission> list = permissionService.list(queryWrapper );
		List<TreeNode> treeNodes = new ArrayList<>();
		//遍历菜单，组装节点
		for (Permission permission : list) {
		    Integer id = permission.getId();
			Integer pid = permission.getPid();
			String title = permission.getTitle();
			Boolean spread = permission.getOpen()==1?Constant.SPREAD_TRUE:Constant.SPREAD_FALSE;		
			treeNodes.add(new TreeNode(id, pid, title, spread));
		}
		
		return new DataGrid(treeNodes);	
	}
	
	/**
	 * 添加权限
	 * @param permissionVo
	 * @return
	 */
	@RequestMapping("addPermission")
	public ResultObj addPermission(PermissionVo permissionVo) {
		try {
			//添加的是权限类型
			permissionVo.setType(Constant.TYPE_PERMISSION);
			permissionService.save(permissionVo);
			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
		
	}
	
	/**
	 * 删除权限
	 * @param permissionVo
	 * @return
	 */
	@RequestMapping("deletePermission")
	public ResultObj deletePermission(PermissionVo permissionVo) {
		try {
			permissionService.removeById(permissionVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {
		
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 更新权限
	 * @param permissionVo
	 * @return
	 */
	@RequestMapping("updatePermission")
	public ResultObj updatePermission(PermissionVo permissionVo) {
		try {
			permissionService.updateById(permissionVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {
		
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	/**
	 * 查询所有权限
	 * @param permissionVo
	 * @return
	 */
	@RequestMapping("queryAllPermission")
	public DataGrid queryAllPermission(PermissionVo permissionVo) {
		
		IPage<Permission> page = new Page<>(permissionVo.getPage(), permissionVo.getLimit());
		QueryWrapper<Permission> queryWrapper = new QueryWrapper<>();
		//只查权限
		queryWrapper.eq("type", Constant.TYPE_PERMISSION);
		//条件查询的
		queryWrapper.like(StringUtils.isNotBlank(permissionVo.getPercode()), "percode", permissionVo.getPercode());
		queryWrapper.like(StringUtils.isNotBlank(permissionVo.getTitle()), "title", permissionVo.getTitle());
		//点击菜单，查询当前菜单的权限 
		queryWrapper.eq(permissionVo.getId()!=null, "pid", permissionVo.getId());
		
		
		permissionService.page(page, queryWrapper);
		
		return new DataGrid(page.getTotal(), page.getRecords());
	}
	
	/**
	 * 查询最大排序码
	 * @return
	 */
	@RequestMapping("getMaxOrderNum")
	public Map<String, Object> getMaxOrderNum() {
		
		//构造查询条件，倒叙排序		
		QueryWrapper<Permission> queryWrapper = new QueryWrapper<>();		
		queryWrapper.orderByDesc("ordernum");
		List<Permission> list = permissionService.list(queryWrapper );
		//拿最大的排序码
		Map<String, Object> map = new HashMap<>();	
		map.put("value", list.get(0).getOrdernum()+1);
		
		return map;
	}

}

