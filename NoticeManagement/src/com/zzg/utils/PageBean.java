package com.zzg.utils;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;


public class PageBean extends ArrayList{
    /**
     *
     * @author ZhangZhongguo
     *
     */
    private int currentPage;//当前页
    private int pageSize;//每页的条数
    private int total;//总条数
    private List rows;//查询的集合

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }

}



