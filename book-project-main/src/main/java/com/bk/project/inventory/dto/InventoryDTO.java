package com.bk.project.inventory.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class InventoryDTO {

	private String keyword;
	private String select;
	private int offset = 0; // SQL LIMIT에서 시작 위치
	private int limit = 10; // 한 페이지에 보여줄 게시글 수
	
	private int page = 1; // 현재 페이지가 어딘지
	private int pageSize = 5; //하단에 보여줄 페이지 번호 개수 (1~5, 6~10 등)
	private int endPage = this.pageSize;  // 페이징 하단 끝 번호
	private int startPage = this.endPage - this.pageSize + 1; // 페이징 하단 시작 번호
	private int lastPage;
	/*
	 * page : 1 ~ 10 -> endPage : 10
	 * page : 11 ~ 20 -> endPage : 20
	 * page : 21 ~ 30 -> endPage : 30
	 * */
	private boolean prev; // 이전 페이지 영역 존재 여부
	private boolean next; // 다음 페이지 영역 존재 여부
	
	public InventoryDTO(int page, int total) {
		   this.page = Math.max(page, 1);

		    // ① 전체 마지막 페이지 계산 -> 필드에 대입해야 함(중요)
		    this.lastPage = (int) Math.ceil((double) total / this.limit);

		    // ② 현재 블록의 끝/시작 페이지
		    this.endPage = (int) (Math.ceil((double) this.page / this.pageSize)) * this.pageSize;
		    this.startPage = this.endPage - this.pageSize + 1;

		    // ③ endPage가 실제 lastPage를 넘지 않게 보정
		    if (this.lastPage < this.endPage) {
		        this.endPage = this.lastPage;
		    }

		    // ④ 이전/다음 블록 존재 여부
		    this.prev = this.startPage > 1;
		    this.next = this.endPage < this.lastPage;  // 블록 기준으로 판단
		}

		public int getOffset() {
		    return Math.max((this.page - 1) * this.limit, 0);
		}
	public int getLimit() {
	    return this.limit;
	}
	public int getLastPage() {
	    return this.lastPage;
	}
}
