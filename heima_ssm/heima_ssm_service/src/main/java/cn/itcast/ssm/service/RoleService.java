package cn.itcast.ssm.service;

import cn.itcast.ssm.mapper.RoleMapper;
import cn.itcast.ssm.pojo.Permission;
import cn.itcast.ssm.pojo.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 22:10
 * @Version 1.0
 */
@Service
@Transactional
public class RoleService {

    @Autowired
    private RoleMapper roleMapper;

    /**
     * 查询所有
     * @return
     */
    public List<Role> findAll(){
       return   roleMapper.findAll();
    }

    /**
     * 添加角色
     * @param role
     */
    public void save(Role role){
        roleMapper.save(role);
    }

    /**
     * 查询其他角色
     * @param roleId
     * @return
     */
    public List<Permission> findOtherPermission(int roleId){
        return roleMapper.findOtherPermissions(roleId);
    }

    /**
     * 给角色添加权限
     * @param roleId
     * @param ids
     */
    public void addPermissionToRole(int roleId,Integer[] ids){
        for (Integer permissionId : ids) {
            roleMapper.addPermissionToRole(permissionId,roleId);
        }

    }

    /**
     * 根据id查询角色
     * @param id
     * @return
     */
    public Role findById(int id){
       return roleMapper.findById(id);
    }
}
