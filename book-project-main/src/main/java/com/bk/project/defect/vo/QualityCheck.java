package com.bk.project.defect.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QualityCheck {

	private int qcNo;
	private int orderNo;
	private int bookNo;
	private String inspector;
	private int quantity;
	private LocalDate checkDate;
	private int checkQuantity;
	private String defectReason;
	private LocalDateTime createTime;
	
}
