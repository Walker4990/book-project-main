package com.bk.project.shipment.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Shipment {
	private int shipmentNo;
	private int inventoryNo;
	private LocalDate shipmentDate;
	private int partnerNo;
	private String location;
	private int price;
	private int quantity;
	private int totalAmount;
	private String note;
	private String deliveryType;
	private String bookTitle;
	private String partnerName;
	private String deliveryName;
	private String bookNo;
	private String deliveryNo;
	}
