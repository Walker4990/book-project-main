package com.bk.project.marketing.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MarketingDTO {	
	private Integer eventNo;
	private String companyName;
	private LocalDate createdAt;
	private String createdBy;
	private String department;
	private String eventType;
	private String eventName;
	private LocalDate durationStart;
	private LocalDate durationEnd;
	private int cost;
	private LocalDate currentDate;
}
