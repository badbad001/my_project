package cn.itcast.travel.domain;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/7 11:24
 * @Version 1.0
 */
public class PageBean<T> {

    private int currPage;
    private int pageSize;
    private int totalCount;
    private int totalPage;
    private List<T> list;

    public PageBean() {
    }

    /**
     * 四个参数的构造
     * @param currPage
     * @param pageSize
     * @param totalCount
     * @param list
     */
    public PageBean(int currPage, int pageSize, int totalCount, List<T> list) {
        this.currPage = currPage;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.list = list;
    }

    /**
     * 获取总页数
     * @return
     */
    public int getTotalPage() {
        return (int) Math.ceil(totalCount*1.0/pageSize);
    }


    public int getCurrPage() {
        return currPage;
    }

    public void setCurrPage(int currPage) {
        this.currPage = currPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
