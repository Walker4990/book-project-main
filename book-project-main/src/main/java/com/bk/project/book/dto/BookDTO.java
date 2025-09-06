package com.bk.project.book.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookDTO {

	private String select;
	private String keyword;
	private int bookNo;
	private String title;//제목
	private String author;//작가
	private LocalDate publishDate;//출판날짜
	private int price;//가격
	private String genre;//장르
	private int contractNo;
}
