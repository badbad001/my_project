package cn.itcast.ssm.controller;

import cn.itcast.ssm.pojo.Product;
import cn.itcast.ssm.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 12:10
 * @Version 1.0
 */
@Controller
@RequestMapping("product")
public class ProductController {

    @Autowired
    private ProductService productService;

    /**
     * 查询所有
     * @return
     */
    @RequestMapping("findAll")
    public ModelAndView findAll(){
        List<Product> list = productService.findAll();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("product-list");
        mv.addObject("productList",list);
        return mv;
    }

    /**
     * 保存,保存完成，重定向到查询所有
     * @param product
     * @return
     */
    @RequestMapping("save")
    public String save(Product product){
        productService.save(product);
        return "redirect:findAll";
    }
}
