package com.bk.project.overtime.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OverTime {

	private String name;
	private LocalDate date;
	private String reason;
	private int overTimeNo; //overtime_no
	private int memberNo; //member_no
}
