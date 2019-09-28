package cn.itcast.ssm.mapper;

import cn.itcast.ssm.pojo.Role;
import cn.itcast.ssm.pojo.UserInfo;
import org.apache.ibatis.annotations.*;
import org.springframework.security.core.userdetails.User;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 17:08
 * @Version 1.0
 */
public interface UserInfoMapper {

    /**
     * 根据用户名查用户
     * @param username

     * @return
     */
    @Select("select * from users where username = #{username}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "email", column = "email"),
            @Result(property = "password", column = "password"),
            @Result(property = "phoneNum", column = "phoneNum"),
            @Result(property = "status", column = "status"),
            @Result(property = "roles",column = "id",many = @Many(select = "cn.itcast.ssm.mapper.RoleMapper.findByUserId"))
    })
    public UserInfo findByUserName(String username);

    /**
     * 查询所有
     * @return
     */
    @Select("select * from users")
    public List<UserInfo> findAll();

    /**
     * 新曾角色
     * @param userInfo
     */
    @Insert("insert into users values(null,#{email},#{username},#{password},#{phoneNum},#{status})")
    public void save(UserInfo userInfo);

    @Select("select * from users where id = #{id}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "email", column = "email"),
            @Result(property = "password", column = "password"),
            @Result(property = "phoneNum", column = "phoneNum"),
            @Result(property = "status", column = "status"),
            @Result(property = "roles",column = "id",many = @Many(select = "cn.itcast.ssm.mapper.RoleMapper.findByUserId"))
    })
    public UserInfo findById(int id);


    /**
     * 查询用户没有的角色
     * @param userId
     * @return
     */
    @Select("select * from role where id not in (select roleId from users_role where userId = #{userId})")
    public List<Role> findOtherRole(int userId);

    /**
     * 给用户添加角色
     * @param userId
     * @param roleId
     */
    @Select("insert into users_role values(#{userId},#{roleId})")
    public void addRoleToUser(@Param("userId")int userId,@Param("roleId")int roleId);
}
