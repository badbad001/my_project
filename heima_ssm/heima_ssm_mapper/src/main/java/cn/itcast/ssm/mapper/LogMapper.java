package cn.itcast.ssm.mapper;

import cn.itcast.ssm.pojo.SysLog;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/19 13:21
 * @Version 1.0
 */
public interface LogMapper {

    /**
     * 记录日志
     * @param sysLog
     */
    @Insert("insert into syslog values(null,#{visitTime},#{username},#{ip},#{url},#{executionTime},#{method})")
    public void addLog(SysLog sysLog);

    /**
     * 查询日志
     * @return
     */
    @Select("select * from syslog")
    public List<SysLog> findAll();
}
