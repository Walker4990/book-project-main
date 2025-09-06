package com.bk.project.delivery.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Delivery {
	
	private Integer deliveryNo; //company_no
	private String name; //name
	private String address; //address
	private int contractAmount; //contract_amount
	private LocalDate contractDate; //contract_date
}
