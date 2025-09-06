package com.bk.project.tax.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Tax {
	private int taxNo;
	private String category; // 세금 종류
	private String relatedTable; // 발생 경로
	private int relatedNo; // 관련된 테이블의 no
	private int taxAmount; // 세금 금액
	private double taxRate; // 세율
	private LocalDate taxDate; // 납부일
	private String description; // 세부 사항
	private String status; 
	private int remainingAmount; // 남은 세액
}
