package cn.itcast.ssm.controller;

import cn.itcast.ssm.pojo.SysLog;
import cn.itcast.ssm.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/19 13:55
 * @Version 1.0
 */
@RequestMapping("sysLog")
@Controller
public class LogController {

    @Autowired
    private LogService logService;

    /**
     * 查询所有
     * @return
     */
    @RequestMapping("findAll")
    public ModelAndView fingAll(){
        List<SysLog> list = logService.findAll();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("syslog-list");
        mv.addObject("sysLogs",list);

        return mv;
    }
}
