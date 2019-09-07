package cn.itcast.travel.service;

import cn.itcast.travel.dao.UserDao;
import cn.itcast.travel.domain.User;

/**
 * @Author: badbad
 * @Date: 2019/9/6 13:34
 * @Version 1.0
 */
public class UserService {
    private UserDao userDao = new UserDao();

    public boolean findUserByUserName(String username){
        return userDao.findUserByUserName(username);
    }

    public void regist(User user) {
        userDao.regist(user);
    }

    public User findByCode(String code) {
        return userDao.findByCode(code);
    }

    public void active(User user) {
        userDao.active(user);
    }

    public User login(String username, String password) {

        return userDao.login(username,password);
    }
}
