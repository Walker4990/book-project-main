package com.bk.project.contract.vo;

import java.math.BigDecimal;
import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Contract {
	//작가 계약 테이블
	   private Integer contractNo;
	    private String authorName;     // 작가 이름
	    private String nationality;    // 국적
	    private String bookTitle;      // 책 제목
	    private String genre;          // 책 장르
	    private int contractAmount;    // 계약금
	    private BigDecimal royaltyRate;// 인세
	    private LocalDate startDate;   // 계약 시작일
	    private LocalDate endDate;     // 계약 종료일
	    private LocalDate manuscriptDue; // 원고 마감일
	    private LocalDate printDate;   // 인쇄 시작 날짜
	    private LocalDate publishDate; // 출판 날짜
	    private String gender;
	    private int price;             // 판매가격
	    private int authorNo;

	    // 🔹 생년월일
	    @DateTimeFormat(pattern = "yyyy-MM-dd") 
	    private LocalDate birthDate;

	    // 🔹 폼에서 String으로 넘어와도 안전하게 변환되도록 보완
	    public void setBirthDate(String birthDate) {
	        if (birthDate != null && !birthDate.isEmpty()) {
	            this.birthDate = LocalDate.parse(birthDate);
	        }
	        }
}
