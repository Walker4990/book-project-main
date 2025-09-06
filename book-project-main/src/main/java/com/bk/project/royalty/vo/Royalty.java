package com.bk.project.royalty.vo;

import java.math.BigDecimal;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Royalty {
	private int royaltyNo;
	private int contractNo;
	private int bookNo;
	private int authorNo;
	private int totalSales;
	private BigDecimal royaltyRate;
	private int royaltyPrice;
	private LocalDate royaltyDate;
	private String description;
}
