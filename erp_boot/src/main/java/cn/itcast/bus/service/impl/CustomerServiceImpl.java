package cn.itcast.bus.service.impl;

import java.io.Serializable;
import java.util.Collection;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.bus.mapper.CustomerMapper;
import cn.itcast.bus.pojo.Customer;
import cn.itcast.bus.service.CustomerService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-10
 */
@Service
@Transactional
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements CustomerService {

	@Override
	public boolean save(Customer entity) {
		
		return super.save(entity);
	}
	
	@Override
	public boolean removeById(Serializable id) {
		
		return super.removeById(id);
	}
	
	@Override
	public boolean removeByIds(Collection<? extends Serializable> idList) {
	
		return super.removeByIds(idList);
	}
	
	@Override
	public boolean updateById(Customer entity) {
		
		return super.updateById(entity);
	}
	
	
	@Override
	public Customer getById(Serializable id) {
		
		return super.getById(id);
	}
	
}
