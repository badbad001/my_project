package cn.itcast.ssm.mapper;

import cn.itcast.ssm.pojo.Product;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 12:00
 * @Version 1.0
 */
public interface ProductMapper {

    /**
     * 查询所有
     * @return
     */
    @Select("select * from product")
    public List<Product> findAll();

    /**
     * 添加产品
     * @param product
     */
    @Insert("insert into product values(null,#{productNum},#{productName},#{cityName}," +
            "#{departureTime},#{productPrice},#{productDesc},#{productStatus})")
    public void save(Product product);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @Select("select * from product where id = #{id}")
    public Product findById(Integer id);
}
