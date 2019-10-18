package cn.itcast.bus.controller;


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

import cn.itcast.bus.pojo.Provider;
import cn.itcast.bus.service.ProviderService;
import cn.itcast.bus.vo.ProviderVo;
import cn.itcast.sys.common.Constant;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;

/**
 * <p>
 *  供应商
 * </p>
 *
 * @author 超极本
 * @since 2019-10-10
 */
@RestController
@RequestMapping("provider")
public class ProviderController {
	
	@Autowired
	private ProviderService providerService;
	
	/**
	 * 查询所有用户
	 * @param providerVo
	 * @return
	 */
	@RequestMapping("queryAllProvider")
	public DataGrid queryAllProvider(ProviderVo providerVo) {
		
		IPage<Provider> page = new Page<>(providerVo.getPage(), providerVo.getLimit());
		QueryWrapper<Provider> queryWrapper = new QueryWrapper<>();
		
		//查询可用的
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		//构造条件
		queryWrapper.like(StringUtils.isNotBlank(providerVo.getProvidername()), "providername", providerVo.getProvidername());
		queryWrapper.like(StringUtils.isNotBlank(providerVo.getConnectionperson()),"connectionperson" ,providerVo.getConnectionperson());
		queryWrapper.like(StringUtils.isNotBlank(providerVo.getAddress()), "address", providerVo.getAddress());
		providerService.page(page, queryWrapper);
		
		return new DataGrid(page.getTotal(), page.getRecords());
	}

	/**
	 * 添加供应商
	 * @return
	 */
	@RequestMapping("addProvider")
	public ResultObj addProvider(ProviderVo providerVo) {
		try {
			providerService.save(providerVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	/**
	 * 删除供应商
	 * @param providerVo
	 * @return
	 */
	@RequestMapping("deleteProvider")
	public ResultObj deleteProvider(ProviderVo providerVo) {
		try {
			providerService.removeById(providerVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 批量删除
	 * @param providerVo
	 * @return
	 */
	@RequestMapping("deleteBatchProvider")
	public ResultObj deleteBatchProvider(ProviderVo providerVo) {
		try {			
			//构建id集合
			Integer[] ids = providerVo.getIds();					
			Collection<Serializable> idList = new ArrayList<>();
			for (Integer id : ids) {
				idList.add(id);
			}			
			providerService.removeByIds(idList);		
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 更新供应商
	 * @param providerVo
	 * @return
	 */
	@RequestMapping("updateProvider")
	public ResultObj updateProvider(ProviderVo providerVo) {
		try {
			providerService.updateById(providerVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	/**
	 * 查询所有供应商
	 * @return
	 */
	@RequestMapping("queryAllProviderForList")
	public DataGrid queryAllGoodsForList() {
		
		QueryWrapper<Provider> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("available", Constant.AVAILABLE);
		List<Provider> list = providerService.list(queryWrapper);
		
		
		
		return new DataGrid(list);
				
		
	}

}

