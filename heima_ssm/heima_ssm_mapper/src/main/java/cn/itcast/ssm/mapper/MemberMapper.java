package cn.itcast.ssm.mapper;

import cn.itcast.ssm.pojo.Member;
import org.apache.ibatis.annotations.Select;

/**
 * @Author: badbad
 * @Date: 2019/9/18 15:51
 * @Version 1.0
 */
public interface MemberMapper {

    @Select("select * from member where id = #{id}")
    public Member findById(int id);
}
