package cn.itcast.stat.mapper;

import java.util.List;

import cn.itcast.stat.pojo.BaseEntity;

public interface StatMapper {

	
	/**
	 * 查询客户地区数据
	 */
	List<BaseEntity> queryCustomerAreaList();

	/**
     * 查询年度公司销售额
     * @param year
     * @return
     */
	List<Double> queryYearGrade(String year);

	/**
     * 查询客户年度销售额数据
     * @param year
     * @return
     */
	List<BaseEntity> queryCustomerYearSales(String year);

}
