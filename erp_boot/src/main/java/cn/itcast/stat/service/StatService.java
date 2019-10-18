package cn.itcast.stat.service;

import java.util.List;

import cn.itcast.stat.pojo.BaseEntity;

public interface StatService {

	/**
     * 查询用户地区信息
     * @return
     */
	List<BaseEntity> loadCustomerAreaList();

	List<Double> queryCompanyYearGrade(String year);

	
	List<BaseEntity> queryCustomerYearSales(String year);

}
