package com.bk.project.defect.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.bk.project.printorder.vo.PrintOrderDetailVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QualityCheckDTO {
    private Integer orderNo;     
    // null방지
    private List<PrintOrderDetailVO> detailList = new ArrayList<>();
    private int qcNo;
	private int bookNo;
	private String inspector;
	private int quantity;
	private LocalDate checkDate;
	private int checkQuantity;
	private String defectReason;
	private List<String> defectReasons;
	private LocalDateTime createTime;
	
    }
