package cn.itcast.ssm.pojo;

import lombok.Data;

import java.util.List;

@Data
public class Permission {
    private Integer id;
    private String permissionName;
    private String url;
    private List<Role> roles;


}
