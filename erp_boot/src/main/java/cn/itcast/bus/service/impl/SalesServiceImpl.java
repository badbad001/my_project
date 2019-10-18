package cn.itcast.bus.service.impl;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.bus.mapper.GoodsMapper;
import cn.itcast.bus.mapper.SalesMapper;
import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Sales;
import cn.itcast.bus.service.SalesService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-12
 */
@Service
@Transactional
public class SalesServiceImpl extends ServiceImpl<SalesMapper, Sales> implements SalesService {

	@Autowired
	private GoodsMapper goodsMapper;
	
	//添加销售单
	@Override
	public boolean save(Sales sales) {
		//先查询原来的商品库存
		Goods goods = goodsMapper.selectById(sales.getGoodsid());
		//然后设置库存，重新更新库存		
		goods.setNumber(goods.getNumber()-sales.getNumber());
		//更新库存
		goodsMapper.updateById(goods);
		
		return super.save(sales);
	}
	
	
	//更新销售单
	@Override
	public boolean updateById(Sales sales) {
		
		//先查询原来销售单的数据
		Sales oldSales = this.getBaseMapper().selectById(sales.getId());
		
		//然后更新商品库存
	    Goods goods = goodsMapper.selectById(sales.getGoodsid());
	    
	    //重新设置库存  公式是 商品库存+原来销售单库存-更新的库存
	    goods.setNumber(goods.getNumber()+oldSales.getNumber()-sales.getNumber());
		
	    goodsMapper.updateById(goods);
		
		return super.updateById(sales);
	}
	
	
	//删除销售单
	@Override
	public boolean removeById(Serializable id) {
		//1.先根据销售单查询销售单
		Sales sales = this.getBaseMapper().selectById(id);
		//2.然后查询商品
		Goods goods = goodsMapper.selectById(sales.getGoodsid());
		//3.拿库存数量然后重新设置库存
		goods.setNumber(goods.getNumber()+sales.getNumber());
		
		goodsMapper.updateById(goods);
		
		return super.removeById(id);
	}
}
