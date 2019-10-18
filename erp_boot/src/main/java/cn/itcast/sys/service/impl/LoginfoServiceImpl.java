package cn.itcast.sys.service.impl;

import cn.itcast.sys.pojo.Loginfo;
import cn.itcast.sys.mapper.LoginfoMapper;
import cn.itcast.sys.service.LoginfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author leijun
 * @since 2019-10-07
 */
@Service
public class LoginfoServiceImpl extends ServiceImpl<LoginfoMapper, Loginfo> implements LoginfoService {

}
