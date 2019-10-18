package cn.itcast.bus.service;

import com.baomidou.mybatisplus.extension.service.IService;

import cn.itcast.bus.pojo.Outport;
import cn.itcast.bus.vo.OutportVo;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-11
 */
public interface OutportService extends IService<Outport> {

	void addOutPort(OutportVo outportVo);

}
