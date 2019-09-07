package cn.itcast.travel.dao;

import cn.itcast.travel.util.JDBCUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Date;

/**
 * @Author: badbad
 * @Date: 2019/9/7 20:17
 * @Version 1.0
 */
public class FavoriteDao {

    private JdbcTemplate jdbcTemplate = new JdbcTemplate(JDBCUtils.getDataSource());

    public boolean isFavorite(String rid, int uid) {
        String sql = "select count(*) from tab_favorite where rid = ? and uid = ?";
        int count = jdbcTemplate.queryForObject(sql, Long.class,rid,uid).intValue();
        return count>0;  //看是否大于0
    }

    /**
     * 获取收藏的总数
     * @param rid
     * @return
     */
    public int getFavoriteCount(int rid){
        String sql = "select count(*) from tab_favorite where rid =?";
        return jdbcTemplate.queryForObject(sql, Long.class,rid).intValue();
    }

    /**
     * 点击收藏
     * @param uid
     * @param rid
     */
    public void addDavorite(int uid, String rid) {
        String sql = "insert into tab_favorite values(?,?,?)";

        jdbcTemplate.update(sql,rid,new Date(),uid);
    }

    /**
     * 取消收藏
     * @param uid
     * @param rid
     */
    public void cancelFavorite(int uid, String rid) {
        String sql = "delete from tab_favorite where uid = ? and rid = ?";

        jdbcTemplate.update(sql,uid,rid);
    }
}
