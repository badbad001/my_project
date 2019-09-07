package cn.itcast.travel.dao;

import cn.itcast.travel.domain.Category;
import cn.itcast.travel.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/6 21:38
 * @Version 1.0
 */
public class CategoryDao {

    private JdbcTemplate jdbcTemplate = new JdbcTemplate(JDBCUtils.getDataSource());

    public List<Category> findAll() {
        String sql = "select * from tab_category order by cid";
        return jdbcTemplate.query(sql,new BeanPropertyRowMapper<>(Category.class));
    }
}
