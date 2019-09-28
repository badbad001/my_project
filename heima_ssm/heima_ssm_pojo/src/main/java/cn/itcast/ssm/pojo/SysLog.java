package cn.itcast.ssm.pojo;

import cn.itcast.ssm.utils.DateUtils;
import lombok.Data;

import java.util.Date;

/**
 * 日志
 */

/**
 * 1 id VARCHAR2 主键 无意义uuid
 2 visitTime timestamp 访问时间
 3 username VARCHAR2 操作者用户名
 4 ip VARCHAR2 访问ip
 5 url VARCHAR2 访问资源url
 6 executionTime int 执行时长
 7 method VARCHAR 访问方法
 */
@Data
public class SysLog {
    private String id;
    private Date visitTime;
    private String visitTimeStr;
    private String username;
    private String ip;
    private String url;
    private Long executionTime;
    private String method;

    public String getVisitTimeStr() {

        //回显时间
        if (visitTime!=null){
            visitTimeStr= DateUtils.date2String(visitTime,"yyyy-MM-dd HH:mm");
        }
        return visitTimeStr;
    }


}
