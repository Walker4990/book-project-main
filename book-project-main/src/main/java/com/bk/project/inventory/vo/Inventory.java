package com.bk.project.inventory.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Inventory {
	
	private int inventoryNo;
	private int defectNo;
	private Integer bookNo;
	private String bookTitle;
	private String actionType;
	private LocalDate actionDate;
	private String location;
	private LocalDate endContractDate;
	private int contractNo;
	private int quantity;
	private String reason;
}
