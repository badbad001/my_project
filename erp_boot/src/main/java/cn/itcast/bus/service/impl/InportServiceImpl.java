package cn.itcast.bus.service.impl;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.bus.mapper.GoodsMapper;
import cn.itcast.bus.mapper.InportMapper;
import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Inport;
import cn.itcast.bus.service.InportService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-11
 */
@Service
@Transactional
public class InportServiceImpl extends ServiceImpl<InportMapper, Inport> implements InportService {
	
	@Autowired
	private GoodsMapper goodsMapper;
		
	
	//添加入库单
	@Override
	public boolean save(Inport inport) {
		
		//根据商品id查询商品
		Goods goods = goodsMapper.selectById(inport.getGoodsid());			
		//重新设置商品库存
		goods.setNumber(goods.getNumber()+inport.getNumber());		
		//重新设置的数量是
		System.err.println("商品数量:"+goods.getNumber());
			
		//更新商品
		goodsMapper.updateById(goods);
		
		
		
		return super.save(inport);
	}
	
	//修改进货单
    @Override
	public boolean updateById(Inport inport) {
    	
    	//根据id查询原来的进货单
    	Inport oldInport = this.getBaseMapper().selectById(inport.getId());
		
    	//根据商品id查询商品
		Goods goods = goodsMapper.selectById(inport.getGoodsid());
		//重新设置商品库存 
		//公式  商品库存-原来的旧进货单的数量+更改后的数量
		goods.setNumber(goods.getNumber()-oldInport.getNumber()+inport.getNumber());
		
		//更新商品库存
	    goodsMapper.updateById(goods);
    	
		return super.updateById(inport);
	}
    
    //删除进货单
    @Override
    public boolean removeById(Serializable id) {
        //1.先根据id查询进货单
    	Inport inport = this.getBaseMapper().selectById(id);
    	//2.再根据商品id查询商品
    	Goods goods = goodsMapper.selectById(inport.getGoodsid());
    	//3.删除进货单就要除去进货单的库存
    	goods.setNumber(goods.getNumber()-inport.getNumber());
    	
    	//4.更新商品
    	goodsMapper.updateById(goods);
    	
    	return super.removeById(id);
    }

}
