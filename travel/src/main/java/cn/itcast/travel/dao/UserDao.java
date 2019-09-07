package cn.itcast.travel.dao;

import cn.itcast.travel.domain.User;
import cn.itcast.travel.util.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * @Author: badbad
 * @Date: 2019/9/6 13:34
 * @Version 1.0
 */
public class UserDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(JDBCUtils.getDataSource());

    /**
     * 通过用户名检查用户名是否已经注册
     * @param username
     * @return
     */
    public boolean findUserByUserName(String username){
        String sql = "select count(*) from tab_user where username = ?";
        int count = jdbcTemplate.queryForObject(sql, Long.class, username).intValue();

        return count > 0? false : true;
    }

    /**
     * 注册用户
     * @param user
     */
    public void regist(User user) {
        String sql = "insert into tab_user values(null,?,?,?,?,?,?,?,?,?)";

        jdbcTemplate.update(sql,user.getUsername(),user.getPassword(),
                user.getName(),user.getBirthday(),user.getSex(),
                user.getTelephone(),user.getEmail(),user.getStatus(),user.getCode()
        );
    }

    /**
     * 通过激活码查用户
     * @param code
     * @return
     */
    public User findByCode(String code) {
        String sql = "select * from tab_user where code = ?";
        User user = null;
        try {
            user = jdbcTemplate.queryForObject(sql,new BeanPropertyRowMapper<>(User.class),code);
        } catch (DataAccessException e) {
            e.printStackTrace();
        }

        return user;
    }

    /**
     *
     * @param user
     */
    public void active(User user) {
        String sql = "update tab_user set status = 'y', code = null where uid = ?";
        jdbcTemplate.update(sql,user.getUid());
    }

    /**
     *
     * @param username
     * @param password
     * @return
     */
    public User login(String username, String password) {
        String sql = "select * from tab_user where username = ? and password = ?";
        User user = null;
        try {
            user = jdbcTemplate.queryForObject(sql,new BeanPropertyRowMapper<>(User.class),username,password);
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return user;
    }
}
