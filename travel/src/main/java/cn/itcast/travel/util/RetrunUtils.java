package cn.itcast.travel.util;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: badbad
 * @Date: 2019/9/6 14:06
 * @Version 1.0
 */
public class RetrunUtils {

    public static void writeToView(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JsonUtils.serialize(data));
    }
}
