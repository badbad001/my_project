package cn.itcast.ssm.pojo;

import lombok.Data;

//会员
@Data
public class Member {
    private Integer id;
    private String name;
    private String nickname;
    private String phoneNum;
    private String email;

}
