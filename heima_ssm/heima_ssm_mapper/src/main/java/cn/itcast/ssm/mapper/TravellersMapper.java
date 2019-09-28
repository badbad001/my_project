package cn.itcast.ssm.mapper;

import cn.itcast.ssm.pojo.Traveller;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 15:48
 * @Version 1.0
 */
public interface TravellersMapper {

    @Select("select * from traveller where id in (select travellerid from order_traveller where orderid = #{orderId})")
    public List<Traveller> findByOrderId(int orderId);
}
