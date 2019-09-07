package cn.itcast.travel.service;

import cn.itcast.travel.dao.CategoryDao;
import cn.itcast.travel.domain.Category;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/6 21:38
 * @Version 1.0
 */
public class CategoryService {

    private CategoryDao categoryDao = new CategoryDao();

    public List<Category> findAll() {

        return categoryDao.findAll();
    }
}
