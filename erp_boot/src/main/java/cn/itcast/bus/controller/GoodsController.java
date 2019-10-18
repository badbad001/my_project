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

import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Provider;
import cn.itcast.bus.service.GoodsService;
import cn.itcast.bus.service.ProviderService;
import cn.itcast.bus.utils.AppFileUtils;
import cn.itcast.bus.vo.GoodsVo;
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
@RequestMapping("goods")
public class GoodsController {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private ProviderService providerService;
	
	/**
	 * 查询所有用户
	 * @param goodsVo
	 * @return
	 */
	@RequestMapping("queryAllGoods")
	public DataGrid queryAllGoods(GoodsVo goodsVo) {
		
		IPage<Goods> page = new Page<>(goodsVo.getPage(), goodsVo.getLimit());
		QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
		
		//查询可用的
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		//构造条件
		queryWrapper.eq(goodsVo.getProviderid()!=null&&goodsVo.getProviderid()!=0, "providerid", goodsVo.getProviderid());
		queryWrapper.like(StringUtils.isNotBlank(goodsVo.getGoodsname()), "goodsname", goodsVo.getGoodsname());
		queryWrapper.like(StringUtils.isNotBlank(goodsVo.getProduceplace()),"produceplace" ,goodsVo.getProduceplace());
		queryWrapper.like(StringUtils.isNotBlank(goodsVo.getGoodspackage()), "goodspackage", goodsVo.getGoodspackage());
		goodsService.page(page, queryWrapper);
		
		//遍历查询供应商名字
		List<Goods> list = page.getRecords();		
		for (Goods goods : list) {
			Provider provider = providerService.getById(goods.getProviderid());			
			goods.setProvidername(provider.getProvidername());
		}
		
		return new DataGrid(page.getTotal(), list);
	}

	/**
	 * 添加商品
	 * @return
	 */
	@RequestMapping("addGoods")
	public ResultObj addGoods(GoodsVo goodsVo) {
		try {
			//1.先判断绝对路径是不是默认图片,不是再改后缀
			if (!goodsVo.getGoodsimg().equals(Constant.DEFULT_IMG)) {
				String newGoodsImg = AppFileUtils.updateFileName(goodsVo.getGoodsimg(), Constant.FILE_UPLOAD_TEMP_SUFFIX);
			
				//2.更改后的绝对路径，去掉后缀的，重新设置进去
				goodsVo.setGoodsimg(newGoodsImg);
			}
						
			goodsService.save(goodsVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	/**
	 * 删除商品
	 * @param goodsVo
	 * @return
	 */
	@RequestMapping("deleteGoods")
	public ResultObj deleteGoods(GoodsVo goodsVo) {
		try {
			
			//删除商品前,先查询是不是默认图片，如果不是默认图片才删除
			Goods goods = goodsService.getById(goodsVo.getId());
			
			if (!goods.getGoodsimg().equals(Constant.DEFULT_IMG)) {
				AppFileUtils.removeFile(goods.getGoodsimg());
			}
			
			
			goodsService.removeById(goodsVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 批量删除
	 * @param goodsVo
	 * @return
	 */
	@RequestMapping("deleteBatchGoods")
	public ResultObj deleteBatchGoods(GoodsVo goodsVo) {
		try {			
			//构建id集合
			Integer[] ids = goodsVo.getIds();					
			Collection<Serializable> idList = new ArrayList<>();
			for (Integer id : ids) {
				idList.add(id);
				
				//遍历每一个期间查询是不是默认图片，不是才删除
				Goods goods = goodsService.getById(id);
				//不是才删除
				if (!goods.getGoodsimg().equals(Constant.DEFULT_IMG)) {
					AppFileUtils.removeFile(goods.getGoodsimg());
				}
			}			
			goodsService.removeByIds(idList);		
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 更新商品
	 * @param goodsVo
	 * @return
	 */
	@RequestMapping("updateGoods")
	public ResultObj updateGoods(GoodsVo goodsVo) {
		try {
			
			//1.先查询原来图片是不是默认图片
			//不是默认图片就删除
			Goods goods = goodsService.getById(goodsVo.getId());
			if (!goods.getGoodsimg().equals(Constant.DEFULT_IMG)) {
				AppFileUtils.removeFile(goods.getGoodsimg());
			}
			
			//2.接着判断新传过来的图片是不是临时图片
			//时临时图片就去掉后缀,重新设置进去
			if (goodsVo.getGoodsimg().endsWith(Constant.FILE_UPLOAD_TEMP_SUFFIX)) {
				String newGoodsImg = AppFileUtils.updateFileName(goodsVo.getGoodsimg(), Constant.FILE_UPLOAD_TEMP_SUFFIX);			
				goodsVo.setGoodsimg(newGoodsImg);
			}
			
			goodsService.updateById(goodsVo);			
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	/**
	 * 查询全部商品
	 * @return
	 */
	@RequestMapping("queryAllGoodsForList")
	public DataGrid queryAllGoodsForList() {
		
		QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("available", Constant.AVAILABLE);
		List<Goods> list = goodsService.list(queryWrapper );
		
		//查询供应商名字
		for (Goods goods : list) {
			Provider provider = providerService.getById(goods.getProviderid());		
			goods.setProvidername(provider.getProvidername());
		}
		
		return new DataGrid(list);
	}
	
	/**
	 * 根据供应商查询商品集合
	 * @param goodsVo
	 * @return
	 */
	@RequestMapping("queryGoodsByProviderId")
	public DataGrid queryGoodsByProviderId(GoodsVo goodsVo) {
		
		 QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
		 
		 //查看供应商商品
		 queryWrapper.eq("available", Constant.AVAILABLE);
		 queryWrapper.eq(goodsVo.getProviderid()!=null,"providerid", goodsVo.getProviderid());
		 
		 System.err.println("供应商id"+goodsVo.getProviderid());
		 
		 List<Goods> list = goodsService.list(queryWrapper);
		 
		//查询供应商名字
		for (Goods goods : list) {
			Provider provider = providerService.getById(goods.getProviderid());		
			goods.setProvidername(provider.getProvidername());
		}
		 
		 
		 return new DataGrid(list);
	}


}

