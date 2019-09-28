package cn.itcast.ssm.mapper;

import cn.itcast.ssm.pojo.Permission;
import cn.itcast.ssm.pojo.Role;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 17:11
 * @Version 1.0
 */

public interface RoleMapper {

    /**
     * 根据用户名跟密码查用户
     * @param userId
     * @return
     */
    @Select("select * from role where id in (select roleId from users_role where userId = #{userId})")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "roleName", column = "roleName"),
            @Result(property = "roleDesc", column = "roleDesc"),
            @Result(property = "permissions",column = "id",many = @Many(select = "cn.itcast.ssm.mapper.PermissionMapper.findByRoleId"))
    })
    public List<Role> findByUserId(int userId);

    /**
     * 查询所有
     * @return
     */
    @Select("select *from role")
    public List<Role> findAll();

    /**
     * 添加角色
     * @param role
     */
    @Insert("insert into role values(null,#{roleName},#{roleDesc})")
    public void save(Role role);

    /**
     * 查询角色没有的权限
     * @param roleId
     * @return
     */
    @Select("select * from permission where id not in(select permissionId from role_permission where roleId = #{roleId})")
    public List<Permission> findOtherPermissions(int roleId);

    /**
     * 给角色添加权限
     * @param permissionId
     * @param roleId
     */
    @Insert("insert into role_permission values(#{permissionId},#{roleId})")
    public void addPermissionToRole(@Param("permissionId") int permissionId,@Param("roleId") int roleId);

    /**
     * 根据id查询角色     * @param id
     * @return
     */
    @Select("select * from role where id = #{id}")
    public Role findById(int id);

}
