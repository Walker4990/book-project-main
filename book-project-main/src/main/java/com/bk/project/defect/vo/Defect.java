package com.bk.project.defect.vo;

import java.time.LocalDate;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Defect {

	private int defectNo;
	private int orderNo;
	private int bookNo;
	private String title;
	private LocalDate printDate;	
	private String status;
	private List<String> statusList;
	private String content;
	private Integer quantity;
	private Integer price;
	private Integer totalAmount;
	private LocalDate defectDate;
	private int detailNo;
}
