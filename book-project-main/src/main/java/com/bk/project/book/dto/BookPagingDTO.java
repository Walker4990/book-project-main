package com.bk.project.book.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor

public class BookPagingDTO {
	
	private String select;
	private String keyword;
	private int offset = 0; // 시작 위치
	private int limit = 10; // 개수
	
	private int page = 1; // 현재 페이지
	private int pageSize = 5; // 한 페이지 당 페이지 개수
	private int endPage = this.pageSize; // 한 페이지의 마지막 페이지 수
	private int startPage = this.endPage - this.pageSize + 1; // 한 페이지의 첫 페이지 수
	private int lastPage;
	/*
	 * page : 1 ~ 10 -> endPage : 10
	 * page : 11 ~ 20 -> endPage : 20
	 * page : 21 ~ 30 -> endPage : 30
	 * */
	
	private boolean prev;
	private boolean next;
	
	public BookPagingDTO(int page, int total) {
	    this.page = Math.max(page, 1);
	    this.endPage = (int) (Math.ceil((double) page / this.pageSize)) * this.pageSize;
	    this.startPage = this.endPage - this.pageSize + 1;

	    // 전체 개수를 통해서 마지막 페이지
	    this.lastPage = (int) Math.ceil((double) total / this.limit); // ✅ 필드에 세팅

	    if (this.lastPage < this.endPage) {
	        this.endPage = this.lastPage;
	    }
	    this.prev = this.startPage > 1;
	    this.next = this.page < this.lastPage; // ✅ 현재 페이지가 마지막보다 작으면 next 활성화
	}
	
	public int getOffset() {
	    int offset = (this.page - 1) * this.limit;
	    return Math.max(offset, 0);
	}
	public int getLimit() {
	    return this.limit;
	}
	public int getLastPage() {
	    return this.lastPage;
	}
}
