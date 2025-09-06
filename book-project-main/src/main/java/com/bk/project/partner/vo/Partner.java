package com.bk.project.partner.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Partner {

	private int partnerNo;
	private String name;
	private String type;
	private LocalDate startDate;
	private LocalDate endDate;
}
