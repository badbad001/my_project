package cn.itcast.stat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.itcast.stat.mapper.StatMapper;
import cn.itcast.stat.pojo.BaseEntity;
import cn.itcast.stat.service.StatService;

@Service
@Transactional
public class StatServiceImpl implements StatService {

	@Autowired
	private StatMapper statMapper;
	
	/**
	 * 查询客户地区数据
	 */
	@Override
	public List<BaseEntity> loadCustomerAreaList() {
		
		return statMapper.queryCustomerAreaList();
	}

	/**
     * 查询年度公司销售额
     * @param year
     * @return
     */
    @Override
    public List<Double> queryCompanyYearGrade(String year) {
        return statMapper.queryYearGrade(year);
    }

    /**
     * 查询客户年度销售额数据
     * @param year
     * @return
     */
	@Override
	public List<BaseEntity> queryCustomerYearSales(String year) {
		
		return statMapper.queryCustomerYearSales(year);
	}

	
}
