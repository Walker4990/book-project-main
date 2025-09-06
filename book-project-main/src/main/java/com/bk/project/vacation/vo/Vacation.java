package com.bk.project.vacation.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Vacation {
	
	private int vacationNo;
	private int memberNo;
	private LocalDate date;
	private LocalDate startDate;
	private LocalDate endDate;
	private String reason;
	private String status;//검토중 검토 완료
	private String approve;//승인, 미승인, 미정
	
}
