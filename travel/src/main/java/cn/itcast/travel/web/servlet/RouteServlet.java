package cn.itcast.travel.web.servlet;

import cn.itcast.travel.domain.PageBean;
import cn.itcast.travel.domain.Route;
import cn.itcast.travel.domain.User;
import cn.itcast.travel.service.FavoriteService;
import cn.itcast.travel.service.RouteService;
import cn.itcast.travel.util.RetrunUtils;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: badbad
 * @Date: 2019/9/7 11:22
 * @Version 1.0
 */
@WebServlet("/route/*")
public class RouteServlet extends BaseServlet {

    private RouteService rs = new RouteService();
    private FavoriteService fs = new FavoriteService();


    /**
     * 分页数据展示
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void findByPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1.获取参数
        String currPage = request.getParameter("currPage");
        String pageSize = request.getParameter("pageSize");
        String cid = request.getParameter("cid");
        String rname = request.getParameter("rname");

        //解决tomcat7中文乱码问题
        rname =new String(rname.getBytes("iso-8859-1"),"utf-8");

        //2.判断是否为空，初始化数据
        if (currPage == null || "".equals(currPage)){
            currPage = "1";
        }
        if (pageSize == null || "".equals(pageSize)){
            pageSize = "10";
        }
        if (cid == null || "".equals(cid) || "null".equals(cid)){//cid等于空字符串
            cid = "0";
        }

        System.out.println(Integer.parseInt(cid));
        //3.调用service查询数据
       PageBean<Route> pageBean = rs.findByPage(
               Integer.parseInt(currPage),Integer.parseInt(pageSize),
               Integer.parseInt(cid),rname);

        //4。把数据写回去
        RetrunUtils.writeToView(response,pageBean);

    }

    /**
     * 通过id查询
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void findById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1.获取参数
        String rid = request.getParameter("rid");
        //2.调用service
        Route route = rs.findById(Integer.parseInt(rid));
        //3.写回页面
        RetrunUtils.writeToView(response,route);
    }

    /**
     * 是否已经收藏
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void isFavorite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1.获取参数
        String rid = request.getParameter("rid");
        //2.判断用户是否已经登录
        User user = (User) request.getSession().getAttribute("user");
        //2.1如果用户没有登录，就不往下执行，页面显示可以收藏
        if (user == null){
            //把false写回去
            RetrunUtils.writeToView(response,false);
            return;
        }

        //3.通过用户id和rid查询是否有记录
        boolean flag= fs.isFavorite(rid,user.getUid());

        //4.把flag写回去
        RetrunUtils.writeToView(response,flag);
    }

    /**
     * 添加收藏
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void addFavorite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.先判断用户是否已经登录
        User user = (User) request.getSession().getAttribute("user");
        //2.判断是否为空,为空用户为空，就去登录
        if (user == null){
            RetrunUtils.writeToView(response,false);
            return;
        }

        //3.获取参数
        String rid = request.getParameter("rid");
        //4.调用service
        fs.addFavorite(user.getUid(),rid);
        RetrunUtils.writeToView(response,true);
    }

    /**
     * 取消收藏
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void cancelFavorite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.获取参数
        String rid = request.getParameter("rid");
        //2.获取正在登录的用户
        User user = (User) request.getSession().getAttribute("user");
        //4.调用service
        fs.cancelFavorite(user.getUid(),rid);
        RetrunUtils.writeToView(response,true);
    }







}
