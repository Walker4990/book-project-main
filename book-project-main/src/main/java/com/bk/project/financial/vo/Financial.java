package com.bk.project.financial.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Financial {

	private int transactionNo;
	private String type;
	private String category;
	private int relatedNo;
	private long totalPrice;
	private LocalDate transactionDate;
	private String description;
	
}
