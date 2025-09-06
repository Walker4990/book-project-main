package com.bk.project.vacation.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class VacationDTO {
	
	private int vacationNo;//vacation_no
	private int memberNo;//member_no
	private LocalDate date;
	private String deptName;//dept_name
	private String name;
	private String id;
	private String email;
	private LocalDate startDate;//start_date
	private LocalDate endDate;//end_date;
	private String reason;
	private String status;
	private String approve;
	private String position;
	
	
}
