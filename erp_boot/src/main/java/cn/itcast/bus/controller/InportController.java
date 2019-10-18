package cn.itcast.bus.controller;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Inport;
import cn.itcast.bus.pojo.Provider;
import cn.itcast.bus.service.GoodsService;
import cn.itcast.bus.service.InportService;
import cn.itcast.bus.service.ProviderService;
import cn.itcast.bus.vo.InportVo;
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
 * @since 2019-10-11
 */
@RestController
@RequestMapping("inport")
public class InportController {
	
	@Autowired
	private InportService inportService;
	
	@Autowired
	private ProviderService providerService;
	
	@Autowired
	private GoodsService goodsService;
	
	/**
	 * 查询所有进货单
	 * @param inportVo
	 * @return
	 */
	@RequestMapping("queryAllInport")
	public DataGrid queryAllInport(InportVo inportVo) {
		
		IPage<Inport> page = new Page<>(inportVo.getPage(), inportVo.getLimit());
		QueryWrapper<Inport> queryWrapper = new QueryWrapper<>();
		
		
		//构造条件
		queryWrapper.like(inportVo.getProviderid()!=null, "providerid", inportVo.getProviderid());
		queryWrapper.like(inportVo.getGoodsid()!=null, "goodsid", inportVo.getGoodsid());
		queryWrapper.like(StringUtils.isNotBlank(inportVo.getOperateperson()),"operateperson" ,inportVo.getOperateperson());
		queryWrapper.gt(inportVo.getStartTime()!=null, "inporttime", inportVo.getStartTime());
		queryWrapper.lt(inportVo.getEndTime()!=null, "inporttime", inportVo.getEndTime());
		inportService.page(page, queryWrapper);
		
		
		//遍历查询供应商名字和商品名字
		List<Inport> list = page.getRecords();
		
		for (Inport inport : list) {
			Provider provider = providerService.getById(inport.getProviderid());
			Goods goods = goodsService.getById(inport.getGoodsid());			
			inport.setGoodsname(goods.getGoodsname());
			inport.setProvidername(provider.getProvidername());
		}
		
		
		return new DataGrid(page.getTotal(), list);
	}

	/**
	 * 添加进货
	 * @return
	 */
	@RequestMapping("addInport")
	public ResultObj addInport(InportVo inportVo) {
		try {
			
			//设置入库员和入库时间
			User user = (User) WebUtils.getHttpSession().getAttribute("user");
			inportVo.setOperateperson(user.getName());
			
			inportVo.setInporttime(new Date());
			
			inportService.save(inportVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	/**
	 * 删除进货
	 * @param inportVo
	 * @return
	 */
	@RequestMapping("deleteInport")
	public ResultObj deleteInport(InportVo inportVo) {
		try {
			inportService.removeById(inportVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 批量删除
	 * @param inportVo
	 * @return
	 */
	@RequestMapping("deleteBatchInport")
	public ResultObj deleteBatchInport(InportVo inportVo) {
		try {			
			//构建id集合
			Integer[] ids = inportVo.getIds();					
			Collection<Serializable> idList = new ArrayList<>();
			for (Integer id : ids) {
				idList.add(id);
			}			
			inportService.removeByIds(idList);		
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 更新进货
	 * @param inportVo
	 * @return
	 */
	@RequestMapping("updateInport")
	public ResultObj updateInport(InportVo inportVo) {
		try {
			inportService.updateById(inportVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	


}

