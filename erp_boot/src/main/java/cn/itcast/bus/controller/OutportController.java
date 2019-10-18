package cn.itcast.bus.controller;


import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Outport;
import cn.itcast.bus.pojo.Provider;
import cn.itcast.bus.service.GoodsService;
import cn.itcast.bus.service.OutportService;
import cn.itcast.bus.service.ProviderService;
import cn.itcast.bus.vo.OutportVo;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 超极本
 * @since 2019-10-11
 */
@RestController
@RequestMapping("outport")
public class OutportController {
	
	@Autowired
	private OutportService outportService;
	
	@Autowired
	private ProviderService providerService;
	
	@Autowired
	private GoodsService goodsService;
	
	/**
	 * 退货
	 * @param outportVo
	 * @return
	 */
	@RequestMapping("addOutPort")
	public ResultObj addOutPort(OutportVo outportVo) {
		
		try {
			outportService.addOutPort(outportVo);
			return ResultObj.OPETRATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.OPETRATE_ERROR;
		}
	}
	
	
	/**
	 * 查询所有退货单
	 * @param outportVo
	 * @return
	 */
	@RequestMapping("queryAllOutport")
	public DataGrid queryAllOutport(OutportVo outportVo) {
		
		IPage<Outport> page = new Page<>(outportVo.getPage(), outportVo.getLimit());
		QueryWrapper<Outport> queryWrapper = new QueryWrapper<>();
		
		
		//构造条件
		queryWrapper.like(outportVo.getProviderid()!=null, "providerid", outportVo.getProviderid());
		queryWrapper.like(outportVo.getGoodsid()!=null, "goodsid", outportVo.getGoodsid());
		queryWrapper.like(StringUtils.isNotBlank(outportVo.getOperateperson()),"operateperson" ,outportVo.getOperateperson());
		queryWrapper.gt(outportVo.getStartTime()!=null, "outputtime", outportVo.getStartTime());
		queryWrapper.lt(outportVo.getEndTime()!=null, "outputtime", outportVo.getEndTime());
		outportService.page(page, queryWrapper);
		
		
		//遍历查询供应商名字和商品名字
		List<Outport> list = page.getRecords();
		
		for (Outport outport : list) {
			Provider provider = providerService.getById(outport.getProviderid());
			Goods goods = goodsService.getById(outport.getGoodsid());			
			outport.setGoodsname(goods.getGoodsname());
			outport.setProvidername(provider.getProvidername());
		}
		
		
		return new DataGrid(page.getTotal(), list);
	}


}

