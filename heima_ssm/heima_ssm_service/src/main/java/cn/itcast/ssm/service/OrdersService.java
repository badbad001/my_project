package cn.itcast.ssm.service;

import cn.itcast.ssm.mapper.OrdersMapper;
import cn.itcast.ssm.pojo.Orders;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 14:41
 * @Version 1.0
 */
@Service
@Transactional
public class OrdersService {

    @Autowired
    private OrdersMapper ordersMapper;

    /**
     * 分页查询所有订单
     * @param currPage
     * @param pageSize
     * @return
     */
    public PageInfo<Orders> findByPage(int currPage,int pageSize){
        //开启分页
        PageHelper.startPage(currPage,pageSize);

        List<Orders> list = ordersMapper.findAll();

        PageInfo<Orders> pageInfo = new PageInfo<>(list);

        return  pageInfo;
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    public Orders findById(int id){
        return ordersMapper.findById(id);
    }
}
