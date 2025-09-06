package com.bk.project.payroll.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PayrollPagingDTO {
    private int limit = 10;        // 한 페이지에 보여줄 게시글 수
    private String month;
    private int page = 1;          // 현재 페이지
    private int pageSize = 10;     // 하단에 보여줄 페이지 번호 개수 (1~5, 6~10 등)
    private int endPage = this.pageSize;  
    private int startPage = this.endPage - this.pageSize + 1; 
    private boolean prev; 
    private boolean next; 
    private int lastPage;
    public PayrollPagingDTO(int page, int total) {
        this.page = Math.max(page, 1);

        this.endPage = (int) (Math.ceil((double) this.page / this.pageSize)) * this.pageSize;
        this.startPage = Math.max(this.endPage - this.pageSize + 1, 1);   // ✅ 음수 방지

        int lastPage = (int) Math.ceil((double) total / this.limit);
        this.lastPage = lastPage;
        if (lastPage < this.endPage) {
            this.endPage = lastPage;
        }

        this.prev = this.startPage > 1;
        this.next = this.page < lastPage;
    }

    public int getOffset() {
        return Math.max((this.page - 1) * this.limit, 0);
    }

    public int getLimit() {
        return this.limit;
    }

}

