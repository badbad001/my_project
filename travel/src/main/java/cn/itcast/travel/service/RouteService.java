package cn.itcast.travel.service;

import cn.itcast.travel.dao.*;
import cn.itcast.travel.domain.PageBean;
import cn.itcast.travel.domain.Route;
import cn.itcast.travel.domain.RouteImg;
import cn.itcast.travel.domain.Seller;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/7 11:37
 * @Version 1.0
 */
public class RouteService {
    private RouteDao routeDao = new RouteDao();
    private RouteImgDao routeImgDao = new RouteImgDao();
    private SellerDao sellerDao = new SellerDao();
    private FavoriteDao favoriteDao = new FavoriteDao();

    public PageBean<Route> findByPage(int currPage, int pageSize, int cid, String rname) {
        //1.查询总条数
        int totalCount = routeDao.findTotalCount(cid,rname);
        //2.查询数据
        List<Route> list = routeDao.findByPage(currPage,pageSize,cid,rname);

        return new PageBean<Route>(currPage,pageSize,totalCount,list);
    }

    /**
     * 根据id查询
     * @param
     * @return
     */
    public Route findById(int rid) {
        Route route = routeDao.findById(rid);
        Seller seller = sellerDao.findById(route.getSid());
        List<RouteImg> list = routeImgDao.findById(route.getRid());
        int favoriteCount = favoriteDao.getFavoriteCount(rid);

        //查询收藏次数
        route.setCount(favoriteCount);
        route.setSeller(seller);
        route.setRouteImgList(list);
        return route;
    }


}
