package com.bk.project.attendance.vo;

import java.time.LocalDate;
import java.time.YearMonth;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class AttendanceSave {

	private int saveNo;
	private int memberNo;
	private YearMonth month;
	private int attendance;
	private int vacation;
}
