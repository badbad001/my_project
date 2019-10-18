package cn.itcast.bus.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.bus.mapper.GoodsMapper;
import cn.itcast.bus.mapper.SalesMapper;
import cn.itcast.bus.mapper.SalesbackMapper;
import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Sales;
import cn.itcast.bus.pojo.Salesback;
import cn.itcast.bus.service.SalesbackService;
import cn.itcast.bus.vo.SaleBackVo;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.util.WebUtils;

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
public class SalesbackServiceImpl extends ServiceImpl<SalesbackMapper, Salesback> implements SalesbackService {

	@Autowired
	private GoodsMapper goodsMapper;
	
	@Autowired
	private SalesMapper salesMapper;
	
	
	//退货
	@Override
	public void addSalesBack(SaleBackVo salebackVo) {
		//1.前端传来只有   销售单id,  数量  描述
		//1.根据销售单id查询销售单
		Sales sales = salesMapper.selectById(salebackVo.getSalesid());
		
		//2.查询商品
		Goods goods = goodsMapper.selectById(sales.getGoodsid());
		//更新库存
		//原来的库存+退货回来的数量
		goods.setNumber(goods.getNumber()+salebackVo.getNumber());
		
		goodsMapper.updateById(goods);
		
		//3.组装退货销售单
		salebackVo.setCustomerid(sales.getCustomerid());
		salebackVo.setPaytype(sales.getPaytype());
		salebackVo.setSalesbacktime(new Date());
		User user = (User) WebUtils.getHttpSession().getAttribute("user");
		salebackVo.setOperateperson(user.getName());
		salebackVo.setSalebackprice(sales.getSaleprice());
		
		salebackVo.setGoodsid(sales.getGoodsid());
		
		super.save(salebackVo);
	}

}
