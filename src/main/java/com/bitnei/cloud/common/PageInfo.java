package com.bitnei.cloud.common;

import java.util.List;

public class PageInfo<T> {

    @SuppressWarnings("unused")
    private int start = 0;        //开始的记录数
    private int page = 1;    //开始的页数
    private int count = 0;//总记录条数
    private int pagesize = 10;//一页显示的记录条数
    private List<T> result;//当前页的记录集合
    private String sort = "id";
    private String order = "desc";//排序方式
    private String orderBy = "addDataTime";//排序字段
    private boolean hasNextPage;    //是否有下一页
    private int pageCount;        //总页数
    private boolean hasPrePage; //是否有上一页
    @SuppressWarnings("unused")
    private int nextPage;        //下一页的页码
    @SuppressWarnings("unused")
    private int prePage;        //上一页的页码

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public PageInfo() {
    }

    public PageInfo(int page, int pagesize) {
        this.setPage(page);
        this.setPagesize(pagesize);
    }

    public boolean isHasPrePage() {
        return page > 1 ? true : false;
    }

    public int getNextPage() {
        return hasNextPage == true ? page + 1 : page;
    }

    public int getPrePage() {
        return hasPrePage == true ? page - 1 : page;
    }

    public boolean isHasNextPage() {
        return page < pageCount ? true : false;
    }

    public int getPageCount() {
        return count == 0 ? pageCount : (count % pagesize == 0 ? count / pagesize : count / pagesize + 1);
    }

    public int getPage() {
        return page;
    }

    public int getCount() {
        return count;
    }

    public int getPagesize() {
        return pagesize;
    }

    public int getStart() {
        return (page - 1) * pagesize;
    }

    public List<T> getResult() {
        return result;
    }

    public String getOrder() {
        return order;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    public void setResult(List<T> result) {
        this.result = result;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

}
