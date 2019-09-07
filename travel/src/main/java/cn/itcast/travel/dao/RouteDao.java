package cn.itcast.travel.dao;

import cn.itcast.travel.domain.Route;
import cn.itcast.travel.util.JDBCUtils;
import org.springframework.beans.factory.annotation.BeanFactoryAnnotationUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/7 11:37
 * @Version 1.0
 */
public class RouteDao {

    private JdbcTemplate jdbcTemplate = new JdbcTemplate(JDBCUtils.getDataSource());

    /**
     *
     * @param cid
     * @param rname
     * @return
     */
    public int findTotalCount(int cid, String rname) {

        String sql = "select count(*) from tab_route where 1=1";
        StringBuilder sb = new StringBuilder(sql);
        List<Object> params = new ArrayList<>();
        //如果cid等于0说明没有传参数
        if (cid != 0){
            sb.append(" and cid = ? ");
            params.add(cid);
        }

        //
        if (rname != null && !"".equals(rname)){
            sb.append(" and rname like ?");
            params.add("%"+rname+"%");
        }

        System.out.println(params);
        System.out.println(sb);

        sql = sb.toString();
        return jdbcTemplate.queryForObject(sql,Long.class,params.toArray()).intValue();
    }

    /**
     *
     * @param currPage
     * @param pageSize
     * @param cid
     * @param rname
     * @return
     */
    public List<Route> findByPage(int currPage, int pageSize, int cid, String rname) {
        String sql = "select * from tab_route where 1=1";
        StringBuilder sb = new StringBuilder(sql);
        List<Object> params = new ArrayList<>();
        //如果cid等于0说明没有传参数
        if (cid != 0){
            sb.append(" and cid = ? ");
            params.add(cid);
        }

        if (rname != null && !"".equals(rname)){
            sb.append(" and rname like ?");
            params.add("%"+rname+"%");
        }

        sb.append(" limit ? , ? ");
        params.add((currPage-1)*pageSize);
        params.add(pageSize);

        System.out.println(params);
        System.out.println(sb);
        sql = sb.toString();
        return jdbcTemplate.query(sql,new BeanPropertyRowMapper<>(Route.class),params.toArray());
    }

    /**
     * 根据id查询
     * @param rid
     * @return
     */
    public Route findById(int rid) {
        String sql = "select * from tab_route  where rid = ?";
        Route route = null;
        try {
            route = jdbcTemplate.queryForObject(sql,new BeanPropertyRowMapper<>(Route.class),rid);
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return route;
    }
}
