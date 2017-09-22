package cn.lgq.mm.vo;

import lombok.Data;

import java.util.List;

@Data
public class Page<T> {

    /**
     * 一页显示的记录数
     */
    private int limit = 10;
    /**
     * 记录总数
     */
    private long totalRows;
    /**
     * 当前页码
     */
    private int pageNo = 1;
    /**
     * 结果集存放List
     */
    private List<T> resultList;

    /**
     * 计算总页数
     */
    public long getTotalPage() {
        long totalPages;
        if (totalRows % limit == 0) {
            totalPages = totalRows / limit;
        } else {
            totalPages = (totalRows / limit) + 1;
        }
        return totalPages;
    }

    /**
     * 当前页的偏移位置
     */
    public int getOffset() {
        return (pageNo - 1) * limit;
    }
}