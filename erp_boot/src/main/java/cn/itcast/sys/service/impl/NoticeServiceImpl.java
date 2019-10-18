package cn.itcast.sys.service.impl;

import cn.itcast.sys.pojo.Notice;
import cn.itcast.sys.mapper.NoticeMapper;
import cn.itcast.sys.service.NoticeService;
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
public class NoticeServiceImpl extends ServiceImpl<NoticeMapper, Notice> implements NoticeService {

}
