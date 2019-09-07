package cn.itcast.travel.dao;

import cn.itcast.travel.domain.Route;
import cn.itcast.travel.domain.Seller;
import cn.itcast.travel.util.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * @Author: badbad
 * @Date: 2019/9/7 17:57
 * @Version 1.0
 */
public class SellerDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(JDBCUtils.getDataSource());


    /**
     * 根据id查询
     * @param sid
     * @return
     */
    public Seller findById(int sid) {
        String sql = "select * from tab_seller where sid = ?";
        Seller seller = null;
        try {
            seller = jdbcTemplate.queryForObject(sql,new BeanPropertyRowMapper<>(Seller.class),sid);
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return seller;
    }
}
