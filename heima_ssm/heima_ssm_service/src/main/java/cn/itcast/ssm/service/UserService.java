package cn.itcast.ssm.service;

import cn.itcast.ssm.mapper.UserInfoMapper;
import cn.itcast.ssm.pojo.Role;
import cn.itcast.ssm.pojo.UserInfo;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 17:19
 * @Version 1.0
 */
@Service("userService")
@Transactional
public class UserService implements IUserService {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    /**
     * 这个是登陆认证的方法
     * @param username
     * @return
     * @throws UsernameNotFoundException
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //根据用户名来查询用户
        UserInfo userInfo = userInfoMapper.findByUserName(username);
        //接着封装成spring-security的user对象，user是实现了UserDetails接口
       /* User user = new User(userInfo.getUsername(), "{noop}" + userInfo.getPassword(),
                userInfo.getStatus() == 0 ? false : true,
                true, true, true,
                getAuthority(userInfo.getRoles())
        );*/
        User user = new User(userInfo.getUsername(), userInfo.getPassword(),
                userInfo.getStatus() == 0 ? false : true,
                true, true, true,
                getAuthority(userInfo.getRoles())
        );

        return user;
    }

    /**
     * 获取角色信息
     * @param roles
     * @return
     */
    public List<SimpleGrantedAuthority> getAuthority(List<Role> roles){
        List<SimpleGrantedAuthority> list = new ArrayList<>();

        for (Role role : roles) {
            list.add(new SimpleGrantedAuthority(role.getRoleName()));
        }

        return list;
    }

    /**
     * 查询所有
     * @return
     */
    public List<UserInfo> findAll(){

        return userInfoMapper.findAll();
    }


    /**
     * 添加用户
     * @param userInfo
     */
    @Override
    public void save(UserInfo userInfo) {
        //把密码加密
         userInfo.setPassword(bCryptPasswordEncoder.encode(userInfo.getPassword()));
         userInfoMapper.save(userInfo);
    }

    /**
     * 根据id查询     * @param id
     * @return
     */
    @Override
    public UserInfo findById(int id) {
        return userInfoMapper.findById(id);
    }

    /**
     * 查询用户没有的其余角色
     * @param userId
     * @return
     */
    public List<Role> findOtherRole(int userId){
        return userInfoMapper.findOtherRole(userId);
    }

    /**
     * 添加用户给角色
     * @param userId
     * @param
     */
    @Override
    public void addUserToRole(int userId, Integer[] ids) {
        for (int roleId : ids) {
            userInfoMapper.addRoleToUser(userId,roleId);
        }

    }
}
