package com.bk.project.claim.vo;

import java.time.LocalDate;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
public class Claim {

	private int claimNo;
	private Integer partnerNo;
	private String name;
	private Integer bookNo;
	private String title;
	private Integer price;
	private Integer quantity;
	private Integer totalAmount;
	private String defectType;
	private String recall;
	private String recallStatus;
	private String content;
	private LocalDate claimDate;
	private List<String> defectTypeList;
	private String reason = "반품";
	private String location = "창고";
	
}
