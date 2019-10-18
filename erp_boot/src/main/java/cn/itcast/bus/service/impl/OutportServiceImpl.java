package cn.itcast.bus.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.bus.mapper.GoodsMapper;
import cn.itcast.bus.mapper.InportMapper;
import cn.itcast.bus.mapper.OutportMapper;
import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Inport;
import cn.itcast.bus.pojo.Outport;
import cn.itcast.bus.service.OutportService;
import cn.itcast.bus.vo.OutportVo;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.util.WebUtils;

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
public class OutportServiceImpl extends ServiceImpl<OutportMapper, Outport> implements OutportService {

	@Autowired
	private GoodsMapper goodsMapper;
	
	@Autowired
	private InportMapper inportMapper;
	
    
	
	
	/**
	 * 退货
	 * 
	 */   
	public void addOutPort(OutportVo outportVo) {
	
		//1.根据进货单id查询进货单
		Inport inport = inportMapper.selectById(outportVo.getInportid());
		
		System.err.println("进货单"+inport.getId());
		
		//2.查询商品库存,来更新商品库存
		Goods goods = goodsMapper.selectById(inport.getGoodsid());
		//重新更新库存
		goods.setNumber(goods.getNumber()-outportVo.getNumber());
		
		goodsMapper.updateById(goods);
		
		//3.组装退货信息
		outportVo.setProviderid(inport.getProviderid());
		outportVo.setPaytype(inport.getPaytype());
		outportVo.setOutputtime(new Date());
		User user = (User) WebUtils.getHttpSession().getAttribute("user");
		outportVo.setOperateperson(user.getName());
		outportVo.setOutportprice(inport.getInportprice());
		outportVo.setGoodsid(inport.getGoodsid());
		
		super.save(outportVo);
	}
}
