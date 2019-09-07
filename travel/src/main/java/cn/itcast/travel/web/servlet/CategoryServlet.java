package cn.itcast.travel.web.servlet;

import cn.itcast.travel.domain.Category;
import cn.itcast.travel.service.CategoryService;
import cn.itcast.travel.util.JedisUtil;
import cn.itcast.travel.util.JsonUtils;
import cn.itcast.travel.util.RetrunUtils;
import redis.clients.jedis.Jedis;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/6 21:34
 * @Version 1.0
 */
@WebServlet("/category/*")
public class CategoryServlet extends BaseServlet {
    private CategoryService cs = new CategoryService();

    /**
     * 查询全部列表
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void findAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.先从redis获取
        Jedis jedis = JedisUtil.getJedis();
        String categories = jedis.get("categories");
        //2.判断是否为空
        //2.1如果为空，就去数据库查询
        if (categories == null || "".equals(categories)){
            List<Category> list = cs.findAll();
            //2.2查到东西接着序列化成json,放到redis里面
            categories = JsonUtils.serialize(list);
            jedis.set("categories",categories);
            System.out.println("数据库中查。。");
        }else {
            System.out.println("缓存拿。。");
        }

        //3.把json数据写回去
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(categories);

    }
}
