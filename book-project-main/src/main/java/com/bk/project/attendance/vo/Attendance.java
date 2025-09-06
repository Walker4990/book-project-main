package com.bk.project.attendance.vo;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Attendance {
	private int attendanceNo;
	private int memberNo;
	private LocalDate date;		// 날짜
	private LocalTime checkIn; //  출근 시간
	private LocalTime checkOut;//  퇴근 시간
	private LocalTime workingHours;//  퇴근 시간
	private LocalTime overTime;

}
