package cn.itcast.ssm.service;

import cn.itcast.ssm.pojo.Role;
import cn.itcast.ssm.pojo.UserInfo;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 20:46
 * @Version 1.0
 */
public interface IUserService extends UserDetailsService {

    public List<UserInfo> findAll();

    public void save(UserInfo userInfo);

    public UserInfo findById(int id);

    public List<Role> findOtherRole(int roleId);

    public void addUserToRole(int userId,Integer[] ids);


}
