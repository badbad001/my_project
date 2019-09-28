package cn.itcast.ssm.controller;

import cn.itcast.ssm.pojo.Role;
import cn.itcast.ssm.pojo.UserInfo;
import cn.itcast.ssm.service.IUserService;
import cn.itcast.ssm.service.UserService;
import org.apache.ibatis.annotations.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.annotation.security.RolesAllowed;
import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 20:34
 * @Version 1.0
 */
@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private IUserService userService;

    /**
     * 查询所有
     * @return
     */
    @RequestMapping("findAll")
    public ModelAndView findAll(){
        List<UserInfo> list = userService.findAll();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user-list");
        mv.addObject("userList",list);
        return mv;
    }

    /**
     * 添加角色
     * @param userInfo
     * @return
     */
    @RequestMapping("save")
    public String save(UserInfo userInfo){
        userService.save(userInfo);

        return "redirect:findAll";
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @RequestMapping("findById")
    public ModelAndView finfById(Integer id){
        UserInfo userInfo = userService.findById(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user-show");
        mv.addObject("user",userInfo);
        return mv;
    }

    /**
     * 查询用户没有的其余角色
     * @param
     * @return
     */
    @RequestMapping("findUserByIdAndAllRole")
    public ModelAndView findUserByIdAndAllRole(Integer id){
        List<Role> list = userService.findOtherRole(id);
        UserInfo userInfo = userService.findById(id);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("user-role-add");
        mv.addObject("roleList",list);
        mv.addObject("user",userInfo);

        return mv;
    }

    /**
     * 给用户添加角色
     * @return
     */
    @RequestMapping("addRoleToUser")
    public String addRoleToUser(@RequestParam("userId")Integer userId,
                                @RequestParam("ids")Integer[] ids){
        userService.addUserToRole(userId,ids);

        return "redirect:findAll";
    }
}
