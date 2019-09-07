package cn.itcast.travel.dao;

import cn.itcast.travel.domain.RouteImg;
import cn.itcast.travel.domain.Seller;
import cn.itcast.travel.util.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/7 17:57
 * @Version 1.0
 */
public class RouteImgDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(JDBCUtils.getDataSource());


    /**
     * 根据id查询
     * @param rid
     * @return
     */
    public List<RouteImg> findById(int rid) {
        String sql = "select * from tab_route_img where rid = ?";


        return jdbcTemplate.query(sql,new BeanPropertyRowMapper<>(RouteImg.class),rid);
    }
}
