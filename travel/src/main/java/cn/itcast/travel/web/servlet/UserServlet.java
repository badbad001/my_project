package cn.itcast.travel.web.servlet;

import cn.itcast.travel.domain.ResultInfo;
import cn.itcast.travel.domain.User;
import cn.itcast.travel.service.UserService;
import cn.itcast.travel.util.JsonUtils;
import cn.itcast.travel.util.MailUtils;
import cn.itcast.travel.util.RetrunUtils;
import cn.itcast.travel.util.UuidUtil;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * @Author: badbad
 * @Date: 2019/9/6 20:33
 * @Version 1.0
 */
@WebServlet("/user/*")
public class UserServlet extends BaseServlet {

    /**
     *登录
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.获取参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        //2.调用service
        UserService us = new UserService();
        User existUser = us.login(username,password);

        //3.先判断是否为空
        //3.1如果为空，就写回去用户名莫玛错误,不往下执行
        if (existUser == null){
            ResultInfo info = new ResultInfo();
            info.setFlag(false);
            info.setErrorMsg("用户名或者密码错误");
            RetrunUtils.writeToView(response,info);

            return;
        }
        //4.如果不为空，接着判断是否普已经激活
        //4.1如果没有激活就写回去 不往下执行
        if (!existUser.getStatus().equalsIgnoreCase("y")){
            ResultInfo info = new ResultInfo();
            info.setFlag(false);
            info.setErrorMsg("请到邮箱激活");
            RetrunUtils.writeToView(response,info);
            return;
        }

        //5.如果已经激活，就写回去,登录成功
        //5.1 把用户放到session里面，接着再ajax来发起请求重用户那里获取信息
        request.getSession().setAttribute("user",existUser);
        ResultInfo info = new ResultInfo();
        info.setFlag(true);
        RetrunUtils.writeToView(response,info);
    }


    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void regist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.获取参数
        User user = new User();
        try {
            BeanUtils.populate(user,request.getParameterMap());
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }


        //1.获取验证码
        String checkCode = request.getParameter("checkCode");
        System.out.println("checkCode = " + checkCode);
        //2.从session获取
        HttpSession session = request.getSession();
        String checkcode_server = (String) session.getAttribute("CHECKCODE_SERVER");
        System.out.println("checkcode_server = " + checkcode_server);
        //2.1获取完验证码立即移除，保证一次性验证码
        session.removeAttribute("CHECKCODE_SERVER");
        //2.2.判断是否一样
        if (checkCode == null || "".equals(checkCode) || !checkcode_server.equalsIgnoreCase(checkCode)){
            //2.3如果不一样，不往下执行
            ResultInfo info = new ResultInfo();
            info.setFlag(false);//设置为true
            info.setErrorMsg("验证码错误");
            //4.写回页面
            RetrunUtils.writeToView(response,info);
            return;
        }

        //2.调用service

        try {
            UserService us = new UserService();
            //2.1生成激活码
            String code = UuidUtil.getUuid();
            user.setCode(code);
            //2.2设置状态为N，为激活状态
            user.setStatus("n");
            us.regist(user);

            //3.注册成功，就把数据写回去
            ResultInfo info = new ResultInfo();
            info.setFlag(true);//设置为true
            //4.写回页面
            RetrunUtils.writeToView(response,info);

            //5.注册成功，接着就发送激活邮箱

            String title = "【黑马旅游网】";
            String text = "点我<a href = 'http://localhost/travel/user/active?code="+code+"'>激活</a>";
            MailUtils.sendMail(user.getEmail(),text,title);

        } catch (Exception e) {
            e.printStackTrace();

            //4.出现异常就 设置为false
            ResultInfo info = new ResultInfo();
            info.setFlag(false);//设置为true
            info.setErrorMsg("注册失败");
            //4.写回页面
            RetrunUtils.writeToView(response,info);

        }
    }

    /**
     * 激活
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void active(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.获取激活码
        String code = request.getParameter("code");
        //2.如果为空，就不往下执行
        if (code == null || "".equals(code)){
            response.getWriter().write("激活码不能为空");
            return;
        }
        //3.先去查询通过激活码能不能找到用户
        UserService us = new UserService();
        User user = us.findByCode(code);

        //4.判断是否为空
        //4.1如果用户为空，说明这个激活码无效
        if (user == null){
            response.getWriter().write("激活码无效或激活码已经使用");
            return;
        }

        //5.如果能找到用户，就激活用户
        try {
            us.active(user);   //激活同时，把激活码置空
            response.getWriter().write("激活成功,请<a href = 'http://localhost/travel/login.html'>登录</a>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("激活失败");
        }
    }



    /**
     * 校检用户名是否可用
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void checkUserName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1.获取参数
        String username = request.getParameter("username");
        //2.去数据库查，看是否有人用了这个用户名
        UserService userService = new UserService();
        boolean flag = userService.findUserByUserName(username);

        //3.写flag回去
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JsonUtils.serialize(flag));

    }

    /**
     * 获取用户信息
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void getUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1.获取session里面的user写回去
        User user = (User) request.getSession().getAttribute("user");
        System.out.println(user);
        //2.写数据回去
        if (user == null){  //用户为空就不往下执行，用户不为空才把数据写回去
            return;
        }
        RetrunUtils.writeToView(response,user);
    }

    /**
     * 登出
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void loginOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1.使sesion失效
        request.getSession().invalidate();
    }


}
