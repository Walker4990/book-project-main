package com.bk.project.taxPayment.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TaxPayment {
	private int taxPaymentNo;
	private int taxNo;
	private LocalDate paymentDate;
	private int amount;
	private String paymentMethod;
	private String status; 
	private String description;
	private String category; 
	private int taxAmount;   
	private LocalDate taxDate;
	
}
