package cn.itcast.bus.controller;


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
import cn.itcast.bus.pojo.Salesback;
import cn.itcast.bus.service.CustomerService;
import cn.itcast.bus.service.GoodsService;
import cn.itcast.bus.service.SalesbackService;
import cn.itcast.bus.vo.SaleBackVo;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 超极本
 * @since 2019-10-12
 */
@RestController
@RequestMapping("salesback")
public class SalesbackController {
	
	
	@Autowired
	private SalesbackService salebackService;
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private GoodsService goodsService;
	
	/**
	 * 退货
	 * @param salebackVo
	 * @return
	 */
	@RequestMapping("addSalesBack")
	public ResultObj addSalesBack(SaleBackVo salebackVo) {
		
		try {
			salebackService.addSalesBack(salebackVo);
			return ResultObj.OPETRATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.OPETRATE_ERROR;
		}
	}
	
	
	/**
	 * 查询所有退货单
	 * @param salebackVo
	 * @return
	 */
	@RequestMapping("queryAllSaleback")
	public DataGrid queryAllSaleback(SaleBackVo salebackVo) {
		
		IPage<Salesback> page = new Page<>(salebackVo.getPage(), salebackVo.getLimit());
		QueryWrapper<Salesback> queryWrapper = new QueryWrapper<>();
		
		
		//构造条件
		queryWrapper.like(salebackVo.getCustomerid()!=null, "customerid", salebackVo.getCustomerid());
		queryWrapper.like(salebackVo.getGoodsid()!=null, "goodsid", salebackVo.getGoodsid());
		queryWrapper.like(StringUtils.isNotBlank(salebackVo.getOperateperson()),"operateperson" ,salebackVo.getOperateperson());
		queryWrapper.gt(salebackVo.getStartTime()!=null, "outputtime", salebackVo.getStartTime());
		queryWrapper.lt(salebackVo.getEndTime()!=null, "outputtime", salebackVo.getEndTime());
		salebackService.page(page, queryWrapper);
		
		
		//遍历查询供应商名字和商品名字
		List<Salesback> list = page.getRecords();
		
		for (Salesback saleback : list) {
			Customer customer = customerService.getById(saleback.getCustomerid());
			Goods goods = goodsService.getById(saleback.getGoodsid());			
			saleback.setGoodsname(goods.getGoodsname());
			saleback.setCustomername(customer.getCustomername());
		}
		
		
		return new DataGrid(page.getTotal(), list);
	}

}

