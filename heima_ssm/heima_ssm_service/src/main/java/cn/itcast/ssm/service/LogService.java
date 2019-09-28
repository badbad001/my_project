package cn.itcast.ssm.service;

import cn.itcast.ssm.mapper.LogMapper;
import cn.itcast.ssm.pojo.SysLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/19 13:28
 * @Version 1.0
 */
@Service
@Transactional
public class LogService {

    @Autowired
    private LogMapper logMapper;

    /**
     * 添加日志
     */
    public void addLog(SysLog sysLog){
        logMapper.addLog(sysLog);
    }

    /**
     * 查询日志
     * @return
     */
    public List<SysLog> findAll(){
        return logMapper.findAll();
    }
}
