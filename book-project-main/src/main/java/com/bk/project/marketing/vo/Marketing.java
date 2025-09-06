package com.bk.project.marketing.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Marketing {

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
}
