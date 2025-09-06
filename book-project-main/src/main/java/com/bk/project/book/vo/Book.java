package com.bk.project.book.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Book {
	private int bookNo;
	private String title;//제목
	private String author;//작가
	private LocalDate publishDate;//출판날짜
	private int price;//가격
	private String genre;//장르
	private int contractNo;
}

