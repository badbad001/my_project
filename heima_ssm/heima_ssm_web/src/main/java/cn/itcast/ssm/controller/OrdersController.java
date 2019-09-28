package cn.itcast.ssm.controller;

import cn.itcast.ssm.pojo.Orders;
import cn.itcast.ssm.service.OrdersService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Author: badbad
 * @Date: 2019/9/18 14:44
 * @Version 1.0
 */
@Controller
@RequestMapping("orders")
public class OrdersController {

    @Autowired
    private OrdersService ordersService;

    /**
     * 分页查询
     * @param currpage
     * @param pageSize
     * @return
     */
    @RequestMapping("findByPage")
    public ModelAndView findAll(
            @RequestParam(value = "currPage",required = false,defaultValue = "1")Integer currpage,
            @RequestParam(value = "pageSize",required = false,defaultValue = "3")Integer pageSize
    ){
        PageInfo<Orders> pageInfo = ordersService.findByPage(currpage, pageSize);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("orders-list");
        mv.addObject("pageInfo",pageInfo);
        return mv;
    }

    /**
     * 根据id查询
     * @param orderId
     * @return
     */
    @RequestMapping("findById")
    public ModelAndView findById(@RequestParam("id")Integer orderId){
        Orders orders = ordersService.findById(orderId);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("orders-show");
        mv.addObject("orders",orders);
        return mv;
    }
}
