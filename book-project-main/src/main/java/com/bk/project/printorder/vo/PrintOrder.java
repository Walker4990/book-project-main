package com.bk.project.printorder.vo;

import java.time.LocalDate;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class PrintOrder {
	private int detailNo;
	private Integer orderNo;
	private LocalDate orderDate;
	private String category;
	private String manager;
	private LocalDate deliveryDate;
	private LocalDate issueDate;
	private List<PrintOrderDetailVO> detailList;
	private String status;
	private int qualityChecked;
}
