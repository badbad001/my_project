package cn.itcast.travel.service;

import cn.itcast.travel.dao.FavoriteDao;

/**
 * @Author: badbad
 * @Date: 2019/9/7 20:16
 * @Version 1.0
 */
public class FavoriteService {
    private FavoriteDao favoriteDao = new FavoriteDao();

    public boolean isFavorite(String rid, int uid) {
        return favoriteDao.isFavorite(rid,uid);
    }


    public void addFavorite(int uid, String rid) {
        favoriteDao.addDavorite(uid,rid);
    }

    public void cancelFavorite(int uid, String rid) {
        favoriteDao.cancelFavorite(uid,rid);
    }
}
