package cn.itcast.ssm.controller;

import cn.itcast.ssm.pojo.Permission;
import cn.itcast.ssm.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 22:14
 * @Version 1.0
 */
@Controller
@RequestMapping("permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    /**
     * 查询所有
     * @return
     */
    @RequestMapping("findAll")
    public ModelAndView findAll(){
        List<Permission> list = permissionService.findAll();
        ModelAndView mv = new ModelAndView();
        mv.addObject("permissionList",list);
        mv.setViewName("permission-list");
        return mv;
    }

    /**
     * 查询所有
     * @param permission
     * @return
     */
    @RequestMapping("save")
    public String save(Permission permission){
        permissionService.save(permission);
        return "redirect:findAll";
    }
}


