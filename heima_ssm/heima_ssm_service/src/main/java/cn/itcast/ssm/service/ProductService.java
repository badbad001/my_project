package cn.itcast.ssm.service;

import cn.itcast.ssm.mapper.ProductMapper;
import cn.itcast.ssm.pojo.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 12:08
 * @Version 1.0
 */
@Service
@Transactional
public class ProductService {

    @Autowired
    private ProductMapper productMapper;

    /**
     * 查询所有
     * @return
     */
    public List<Product> findAll(){
        return productMapper.findAll();
    }

    /**
     * 保存
     * @param product
     */
    public void save(Product product) {
        productMapper.save(product);
    }
}
