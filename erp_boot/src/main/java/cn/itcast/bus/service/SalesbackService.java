package cn.itcast.bus.service;

import com.baomidou.mybatisplus.extension.service.IService;

import cn.itcast.bus.pojo.Salesback;
import cn.itcast.bus.vo.SaleBackVo;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-12
 */
public interface SalesbackService extends IService<Salesback> {

	void addSalesBack(SaleBackVo salebackVo);

}
