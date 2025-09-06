package com.bk.project.printorder.dto;

import java.time.LocalDate;
import java.util.List;

import com.bk.project.printorder.vo.PrintOrderDetailVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class printOrderDTO {

	private int orderNo;
	private int bookNo;
	private String productName;
	private int quantity;
	private int promotionQuantity;
	private String manager;
	private LocalDate issueDate;
	private LocalDate deliveryDate;
	private List<PrintOrderDetailVO> detailList;
	
}
