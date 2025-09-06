package com.bk.project.budget.dto;

import java.time.LocalDate;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BudgetPagingDTO {
	private int offset = 0; // SQL LIMIT에서 시작 위치
	private int limit = 5; // 한 페이지에 보여줄 게시글 수
	
	private String nowMonth;
	private int page = 1; // 현재 페이지가 어딘지
	private int pageSize = 5; //하단에 보여줄 페이지 번호 개수 (1~5, 6~10 등)
	private int endPage = this.pageSize;  // 페이징 하단 끝 번호
	private int startPage = this.endPage - this.pageSize + 1; // 페이징 하단 시작 번호
	/*
	 * page : 1 ~ 10 -> endPage : 10
	 * page : 11 ~ 20 -> endPage : 20
	 * page : 21 ~ 30 -> endPage : 30
	 * */
	private boolean prev; // 이전 페이지 영역 존재 여부
	private boolean next; // 다음 페이지 영역 존재 여부
	
	public BudgetPagingDTO(int page, int total) {
		this.page =  Math.max(page, 1);;
		this.endPage = (int) (Math.ceil((double)page / this.pageSize)) * this.pageSize;
		this.startPage = this.endPage - this.pageSize + 1;
		
		// 전체 개수를 통해서 마지막 페이지
		int lastPage = (int) Math.ceil((double)total / this.limit);
		
		if (lastPage < this.endPage) {
			this.endPage = lastPage;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < lastPage;
}
	public int getOffset() {
	    return (this.page - 1) * this.limit;
	}
	public int getLimit() {
	    return this.limit;
	}
}
