package cn.itcast.sys.controller;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
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
import cn.itcast.sys.pojo.Technology;
import cn.itcast.sys.service.TechnologyService;
import cn.itcast.sys.vo.TechnologyVo;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 超极本
 * @since 2019-10-12
 */
@RestController
@RequestMapping("technology")
public class TechnologyController {
	
	@Autowired
	private TechnologyService technologyService;
	
	/**
	 * 查询所有用户
	 * @param technologyVo
	 * @return
	 */
	@RequestMapping("queryAllTechnology")
	public DataGrid queryAllTechnology(TechnologyVo technologyVo) {
		
		IPage<Technology> page = new Page<>(technologyVo.getPage(), technologyVo.getLimit());
		QueryWrapper<Technology> queryWrapper = new QueryWrapper<>();
		
		//查询可用的
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		//构造条件
		queryWrapper.like(StringUtils.isNotBlank(technologyVo.getName()), "name", technologyVo.getName());
		queryWrapper.like(StringUtils.isNotBlank(technologyVo.getRemark()), "remark", technologyVo.getRemark());
		
		technologyService.page(page, queryWrapper);
		
		return new DataGrid(page.getTotal(), page.getRecords());
	}

	/**
	 * 添加技术
	 * @return
	 */
	@RequestMapping("addTechnology")
	public ResultObj addTechnology(TechnologyVo technologyVo) {
		try {
			technologyService.save(technologyVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	/**
	 * 删除技术
	 * @param technologyVo
	 * @return
	 */
	@RequestMapping("deleteTechnology")
	public ResultObj deleteTechnology(TechnologyVo technologyVo) {
		try {
			technologyService.removeById(technologyVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 批量删除
	 * @param technologyVo
	 * @return
	 */
	@RequestMapping("deleteBatchTechnology")
	public ResultObj deleteBatchTechnology(TechnologyVo technologyVo) {
		try {			
			//构建id集合
			Integer[] ids = technologyVo.getIds();					
			Collection<Serializable> idList = new ArrayList<>();
			for (Integer id : ids) {
				idList.add(id);
			}			
			technologyService.removeByIds(idList);		
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 更新技术
	 * @param technologyVo
	 * @return
	 */
	@RequestMapping("updateTechnology")
	public ResultObj updateTechnology(TechnologyVo technologyVo) {
		try {
			technologyService.updateById(technologyVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	
	/**
	 * 查询所有技术
	 */
	@RequestMapping("queryAllTechnologyForList")
	public DataGrid queryAllTechnologyForList() {
		List<Technology> list = technologyService.list();
		return new DataGrid(list);
	}

}

