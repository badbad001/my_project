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

import cn.itcast.bus.pojo.Customer;
import cn.itcast.bus.service.CustomerService;
import cn.itcast.bus.vo.CustomerVo;
import cn.itcast.sys.common.Constant;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 超极本
 * @since 2019-10-10
 */
@RestController
@RequestMapping("customer")
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	/**
	 * 查询所有用户
	 * @param customerVo
	 * @return
	 */
	@RequestMapping("queryAllCustomer")
	public DataGrid queryAllCustomer(CustomerVo customerVo) {
		
		IPage<Customer> page = new Page<>(customerVo.getPage(), customerVo.getLimit());
		QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
		
		//查询可用的
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		//构造条件
		queryWrapper.like(StringUtils.isNotBlank(customerVo.getCustomername()), "customername", customerVo.getCustomername());
		queryWrapper.like(StringUtils.isNotBlank(customerVo.getConnectionperson()),"connectionperson" ,customerVo.getConnectionperson());
		queryWrapper.like(StringUtils.isNotBlank(customerVo.getAddress()), "address", customerVo.getAddress());
		customerService.page(page, queryWrapper);
		
		return new DataGrid(page.getTotal(), page.getRecords());
	}

	/**
	 * 添加客户
	 * @return
	 */
	@RequestMapping("addCustomer")
	public ResultObj addCustomer(CustomerVo customerVo) {
		try {
			customerService.save(customerVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	/**
	 * 删除客户
	 * @param customerVo
	 * @return
	 */
	@RequestMapping("deleteCustomer")
	public ResultObj deleteCustomer(CustomerVo customerVo) {
		try {
			customerService.removeById(customerVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 批量删除
	 * @param customerVo
	 * @return
	 */
	@RequestMapping("deleteBatchCustomer")
	public ResultObj deleteBatchCustomer(CustomerVo customerVo) {
		try {			
			//构建id集合
			Integer[] ids = customerVo.getIds();					
			Collection<Serializable> idList = new ArrayList<>();
			for (Integer id : ids) {
				idList.add(id);
			}			
			customerService.removeByIds(idList);		
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 更新客户
	 * @param customerVo
	 * @return
	 */
	@RequestMapping("updateCustomer")
	public ResultObj updateCustomer(CustomerVo customerVo) {
		try {
			customerService.updateById(customerVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	
	/**
	 * 查询所有客户
	 * @return
	 */
	@RequestMapping("queryAllCustomerForList")
	public DataGrid queryAllGoodsForList() {
		
		QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		List<Customer> list = customerService.list(queryWrapper);
		
		
		return new DataGrid(list);
				
		
	}
}

