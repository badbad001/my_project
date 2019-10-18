package cn.itcast.bus.controller;


import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.itcast.bus.pojo.Customer;
import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Sales;
import cn.itcast.bus.service.CustomerService;
import cn.itcast.bus.service.GoodsService;
import cn.itcast.bus.service.SalesService;
import cn.itcast.bus.vo.SalesVo;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.util.WebUtils;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 超极本
 * @since 2019-10-12
 */
@RestController
@RequestMapping("sales")
public class SalesController {
	
	@Autowired
	private SalesService salesService;
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private GoodsService goodsService;
	
	
	/**
	 * 查询所有销售单
	 * @param salesVo
	 * @return
	 */
	@RequestMapping("queryAllSales")
	public DataGrid queryAllSales(SalesVo salesVo) {
		
		IPage<Sales> page = new Page<>(salesVo.getPage(), salesVo.getLimit());
		QueryWrapper<Sales> queryWrapper = new QueryWrapper<>();
		
		
		//构造条件
		queryWrapper.like(salesVo.getCustomerid()!=null, "customerid",salesVo.getCustomerid());
		queryWrapper.like(salesVo.getGoodsid()!=null, "goodsid", salesVo.getGoodsid());
		queryWrapper.like(StringUtils.isNotBlank(salesVo.getOperateperson()),"operateperson" ,salesVo.getOperateperson());
		queryWrapper.gt(salesVo.getStartTime()!=null, "salestime", salesVo.getStartTime());
		queryWrapper.lt(salesVo.getEndTime()!=null, "salestime", salesVo.getEndTime());
		salesService.page(page, queryWrapper);
		
		
		//遍历查询客户名字和商品名字
		List<Sales> list = page.getRecords();
		
		for (Sales sales : list) {
			Customer customer = customerService.getById(sales.getCustomerid());
			Goods goods = goodsService.getById(sales.getGoodsid());			
			sales.setGoodsname(goods.getGoodsname());
			sales.setCustomername(customer.getCustomername());
		}
		
		
		return new DataGrid(page.getTotal(), list);
	}
	
	
	/**
	 * 添加销售单
	 * @return
	 */
	@RequestMapping("addSales")
	public ResultObj addSales(SalesVo salesVo) {
		try {
			
			//设置销售员和销售时间
			User user = (User) WebUtils.getHttpSession().getAttribute("user");
			salesVo.setOperateperson(user.getName());
			
			salesVo.setSalestime(new Date());
			
			salesService.save(salesVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	
	/**
	 * 更新销售单
	 * @param salesVo
	 * @return
	 */
	@RequestMapping("updateSales")
	public ResultObj updateSales(SalesVo salesVo) {
		try {
			salesService.updateById(salesVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	
	/**
	 * 删除销售单
	 * @param salesVo
	 * @return
	 */
	@RequestMapping("deleteSales")
	public ResultObj deleteSales(SalesVo salesVo) {
		try {
			salesService.removeById(salesVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
	}
	
	
	


}

