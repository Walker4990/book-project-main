package com.bk.project.contract.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ContractExpiredDTO {
	
	private String keyword;
	private String select;
	
	private int expiredNo;
	private int contractNo;
	private int authorNo;
	private String authorName;
	private String nationality;
	private String gender;
	private LocalDate birthDate;
	private String bookTitle;
	private String genre;
	private LocalDate publishDate;
	private int price;
	
	private int contractAmount;
	private double royaltyRate;
	private LocalDate startDate;
	private LocalDate endDate;
	private LocalDate manuscriptDue;
	private LocalDate printDate;
	private String closeType;
	private String closeReason;
	private LocalDate expiredDate; // 계약상 종료일
	private LocalDate closeAt; // 해지일자
}
