package cn.itcast.ssm.mapper;

import cn.itcast.ssm.pojo.Orders;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 14:33
 * @Version 1.0
 */
public interface OrdersMapper {

    /**
     * 查询所有订单
     * @return
     */
    @Select("select * from orders")
    @Results({
            @Result(id=true,property = "id",column = "id"),
            @Result(property = "orderNum",column = "orderNum"),
            @Result(property = "orderTime",column = "orderTime"),
            @Result(property = "orderStatus",column = "orderStatus"),
            @Result(property = "peopleCount",column = "peopleCount"),
            @Result(property = "peopleCount",column = "peopleCount"),
            @Result(property = "payType",column = "payType"),
            @Result(property = "orderDesc",column = "orderDesc"),
            @Result(column = "productId",property = "product",one = @One(select = "cn.itcast.ssm.mapper.ProductMapper.findById"))
    })
    public List<Orders> findAll();

    /**
     * 根据id查询订单
     * @return
     */
    @Select("select * from orders where id =#{id}")
    @Results({
            @Result(id=true,property = "id",column = "id"),
            @Result(property = "orderNum",column = "orderNum"),
            @Result(property = "orderTime",column = "orderTime"),
            @Result(property = "orderStatus",column = "orderStatus"),
            @Result(property = "peopleCount",column = "peopleCount"),
            @Result(property = "peopleCount",column = "peopleCount"),
            @Result(property = "payType",column = "payType"),
            @Result(property = "orderDesc",column = "orderDesc"),
            @Result(column = "productId",property = "product",one = @One(select = "cn.itcast.ssm.mapper.ProductMapper.findById")),
            @Result(column = "memberId",property = "member",one = @One(select = "cn.itcast.ssm.mapper.MemberMapper.findById")),
            @Result(column = "id",property = "travellers",many = @Many(select = "cn.itcast.ssm.mapper.TravellersMapper.findByOrderId"))
    })
    public Orders findById(int id);
}
