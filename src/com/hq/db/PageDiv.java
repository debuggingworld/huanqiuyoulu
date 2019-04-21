package com.hq.db;

import java.util.List;

/**
 * 封装一页数据
 * @author zth
 * @Date 2019-04-21 11:14
 */
public class PageDiv<T> {
    private int pageNO;             //  当前多少页
    private int pageSize;           //  每页多少条
    private int totalPage;          //  总共多少页
    private long totalCount;         //  总共多少条
    private int indexCount = 9;     //  显示页码数
    private int start;              //  从第几页开始
    private int end;                //  到第几页结束

    private List<T> list;           //  当前页中的数据

    public PageDiv(){}

    public PageDiv(int pageNO,int pageSize,long totalCount,List<T> list){

        this.pageNO = pageNO;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.totalPage = (int)((totalPage+pageSize-1)/pageSize);
        this.list = list;

        if (pageNO-indexCount/2<1){
            start = 1;
        }else {
            start = pageNO-indexCount/2;
        }

        if (pageNO+indexCount/2 > totalPage){
            end = totalPage;
        }else {
            end = pageNO+indexCount/2;
        }
    }

    public int getPrevious(){
        int re = 0;
        if (this.pageNO - 1 >0){
            re = this.pageNO-1;
        }else {
            re = 1;
        }
        return re;
    }

    public int getNext(){
        int re = 0;
        if (this.pageNO+1 < this.totalPage){
            re = totalPage +1;
        }else {
            re = totalPage;
        }
        return re;
    }

    public int getPageNO() {
        return pageNO;
    }

    public void setPageNO(int pageNO) {
        this.pageNO = pageNO;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public long getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }

    public int getIndexCount() {
        return indexCount;
    }

    public void setIndexCount(int indexCount) {
        this.indexCount = indexCount;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
