package cn.itcast.sys.controller;


import java.util.ArrayList;
import java.util.Date;
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
import cn.itcast.sys.pojo.Dept;
import cn.itcast.sys.service.DeptService;
import cn.itcast.sys.vo.DeptVo;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author leijun
 * @since 2019-10-08
 */
@RestController
@RequestMapping("dept")
public class DeptController {
	
	@Autowired
	private DeptService deptService;
	
	/**
	 * 加载左边部门json
	 * @return
	 */
	@RequestMapping("loadLeftDeptJson")
	public DataGrid loadLeftDeptJson(DeptVo deptVo) {
		QueryWrapper<Dept> queryWrapper = new QueryWrapper<>();
		
		//查询可用的
		queryWrapper.eq("available", Constant.AVAILABLE);		
		List<Dept> list = deptService.list(queryWrapper);
		
		//遍历部门，构建部门的树节点
		List<TreeNode> treeNodes = new ArrayList<>();		
		for (Dept dept : list) {			
			Integer id  = dept.getId();
			Integer pid = dept.getPid();
			String title = dept.getTitle();
			Boolean spread = dept.getOpen() == 1?Constant.SPREAD_TRUE:Constant.SPREAD_FALSE;
			
			treeNodes.add(new TreeNode(id, pid, title, spread));		
		}
		
		return new DataGrid(treeNodes);
	}
	
	/**
	 * 查询部门带分页带条件
	 * @return
	 */
	@RequestMapping("queryAllDept")
	public DataGrid queryAllDept(DeptVo deptVo) {
		
		IPage<Dept> page = new Page<>(deptVo.getPage(), deptVo.getLimit());
		QueryWrapper<Dept> queryWrapper = new QueryWrapper<Dept>();
		
		//构造条件
		queryWrapper.like(StringUtils.isNotBlank(deptVo.getTitle()), "title",deptVo.getTitle());
		queryWrapper.like(StringUtils.isNotBlank(deptVo.getAddress()), "address",deptVo.getAddress());
		
		//这个是点击数，查当前节点，和字节点的
		queryWrapper.eq(deptVo.getId()!=null, "id", deptVo.getId())
		       .or().eq(deptVo.getId()!=null,"pid", deptVo.getId());
		
		deptService.page(page, queryWrapper);
		
		return new DataGrid(page.getTotal(), page.getRecords());
		
	}
	
	/**
	 * 添加部门
	 * @param deptVo
	 * @return
	 */
	@RequestMapping("addDept")
    public ResultObj addDept(DeptVo deptVo) {
		
		try {
			//设置部门创建时间
			deptVo.setCreatetime(new Date());
			
			deptService.save(deptVo);
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}		
	}
	
	/**
	 * 更新部门
	 * @return
	 */
	@RequestMapping("updateDept")
	public ResultObj updateDept(DeptVo deptVo) {
		
		try {
			deptService.updateById(deptVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	/**
	 * 检查是否有子部门
	 * @return
	 */
	@RequestMapping("checkHasChildDept")
	public Map<String, Object> checkHasChildDept(DeptVo deptVo) {
		
		//构造条件
		QueryWrapper<Dept> queryWrapper = new QueryWrapper<>();		
		queryWrapper.eq("pid", deptVo.getId());
		
		//查询
		int count = deptService.count(queryWrapper);		
		Map<String, Object> map = new HashMap<>();
		//有子部门为true
		if (count>0) {
			map.put("value", true); 
		}else {
			map.put("value", false);
		}
		
		return map;
	}
	
	/**
	 * 删除部门
	 * @param deptVo
	 * @return
	 */
	@RequestMapping("deleteDept")
	public ResultObj deleteDept(DeptVo deptVo) {
		try {
			deptService.removeById(deptVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();		
			return ResultObj.DELETE_ERROR;
		}
		
	}
	
	/**
	 * 获取最大的排序码
	 * @return
	 */
	@RequestMapping("getMaxOrderNum")
	public Map<String, Object> getMaxOrderNum() {
		
		//构造查询条件
		QueryWrapper<Dept> queryWrapper = new QueryWrapper<>();		
		queryWrapper.orderByDesc("ordernum");
		List<Dept> list = deptService.list(queryWrapper);
		
		//降序排序拿到最大的id
		Map<String, Object> map = new HashMap<>();
		//接着加1返回去
		map.put("value", list.get(0).getOrdernum()+1);
		return  map;
		
	}
	

}

