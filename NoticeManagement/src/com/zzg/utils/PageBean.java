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
    private Integer currentPage;//当前页
    private Integer pageSize;//每页的条数
    private Integer total;//总条数
    private List rows;//查询的集合

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }

}



