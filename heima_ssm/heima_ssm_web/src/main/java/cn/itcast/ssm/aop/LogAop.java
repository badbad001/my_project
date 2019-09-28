package cn.itcast.ssm.aop;

import cn.itcast.ssm.pojo.SysLog;
import cn.itcast.ssm.service.LogService;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;

/**
 * @Author: badbad
 * @Date: 2019/9/19 13:20
 * @Version 1.0
 */
@Aspect
@Component
public class LogAop {

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private LogService logService;

    //开始日期
    private Date startDate;

    //切入点的class
    private Class clazz;

    //切入点的方法
    private Method method;

    /**
     * 前置增强
     * @param joinPoint
     */

    /*@Before("execution(* cn.itcast.ssm.controller.*.*(..))")*/
    @Before("execution(* cn.itcast.ssm.controller.*.*(..))")
    public void doBefore(JoinPoint joinPoint) throws NoSuchMethodException {

        System.out.println("aaaaaaaaaa......");

        //1.开始时间
        startDate = new Date();

        //2.获取切入点的class
        clazz = joinPoint.getTarget().getClass();

        //3.获取切入点的方法
        //3.0获取方法的名字
        String methodName=joinPoint.getSignature().getName();
        //3.1先获取方法的参数
        Object[] args = joinPoint.getArgs();
        //3.2无参方法
        if (args == null || args.length==0){
            method = clazz.getMethod(methodName);
        }else {
            //3.3有参方法
            //3.3.1获取所有的参数，遍历所有参数获取参数的clazz数组
            Class[] argClazz = new Class[args.length];
            for (int i = 0; i < argClazz.length; i++) {
                argClazz[i] = args[i].getClass();
            }

            method = clazz.getMethod(methodName,argClazz);

        }

    }

    /**
     * 后置增强
     * @param joinPoint
     */
    /*@After("execution(* cn.itcast.ssm.controller.*.*(..))")*/
    @After("execution(* cn.itcast.ssm.controller.*.*(..))")
    public void doAfter(JoinPoint joinPoint){
        //1.获取处理事件时长
        long time = new Date().getTime() -startDate.getTime();
        //2.获取ip地址
        String ip = request.getRemoteAddr();
        //3.获取执行的方法者
        SecurityContext context = SecurityContextHolder.getContext();
        User user = (User) context.getAuthentication().getPrincipal();
        String username  = user.getUsername();

        //4.获取执行方法的url
        String url = "";
        if (clazz!=null && method!=null&&clazz!=LogAop.class){
             RequestMapping classAnno = (RequestMapping) clazz.getAnnotation(RequestMapping.class);
             if (classAnno!= null){
                 RequestMapping methodAnno = method.getAnnotation(RequestMapping.class);
                 if (methodAnno!= null){
                      url = classAnno.value()[0] +"-"+methodAnno.value()[0];
                 }
             }

        }

        //5.组装syslog
        SysLog sysLog = new SysLog();
        sysLog.setVisitTime(startDate);
        sysLog.setExecutionTime(time);
        sysLog.setIp(ip);
        sysLog.setMethod(clazz.getName()+"-"+method.getName());
        sysLog.setUsername(username);
        sysLog.setUrl(url);

        //6.插进数据库
        logService.addLog(sysLog);
    }
}
