package cn.itcast.ssm.controller;

import cn.itcast.ssm.pojo.Permission;
import cn.itcast.ssm.pojo.Role;
import cn.itcast.ssm.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 22:14
 * @Version 1.0
 */
@Controller
@RequestMapping("role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    /**
     * 查询所有
     * @return
     */
    @RequestMapping("findAll")
    public ModelAndView findAll(){
        List<Role> list = roleService.findAll();
        ModelAndView mv = new ModelAndView();
        mv.addObject("roleList",list);
        mv.setViewName("role-list");
        return mv;
    }

    /**
     * 查询所有
     * @param role
     * @return
     */
    @RequestMapping("save")
    public String save(Role role){
        roleService.save(role);
        return "redirect:findAll";
    }

    /**
     *查询没有的权限
     * @param id
     * @return
     */
    @RequestMapping("findRoleByIdAndAllPermission")
    public ModelAndView findRoleByIdAndAllPermission(Integer id){
        List<Permission> list = roleService.findOtherPermission(id);
        Role role = roleService.findById(id);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("role-permission-add");
        mv.addObject("permissionList",list);
        mv.addObject("role",role);

        return mv;
    }

    /**
     * 添加权限给角色
     * @param roleId
     * @param ids
     * @return
     */
    @RequestMapping("addPermissionToRole")
    public String addPermissionToRole(
            @RequestParam("roleId")Integer roleId,@RequestParam("ids")Integer[] ids){
        roleService.addPermissionToRole(roleId,ids);

        return "redirect:findAll";
    }

    /**
     * 根据id查询
     * @return
     *//*
    @RequestMapping("findById")
    public ModelAndView findById(Integer id){
        Role role = roleService.findById(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("");
    }*/
}


