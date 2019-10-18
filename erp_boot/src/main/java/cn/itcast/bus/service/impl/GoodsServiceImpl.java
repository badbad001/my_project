package cn.itcast.bus.service.impl;

import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.mapper.GoodsMapper;
import cn.itcast.bus.service.GoodsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-10
 */
@Service
public class GoodsServiceImpl extends ServiceImpl<GoodsMapper, Goods> implements GoodsService {

}
