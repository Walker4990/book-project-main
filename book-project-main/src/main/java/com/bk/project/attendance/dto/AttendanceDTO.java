package com.bk.project.attendance.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AttendanceDTO {

	private LocalDate date;		// 날짜
	private String name;		// 사원 명
	private String deptName;
	private LocalTime checkIn; //  출근 시간
	private LocalTime checkOut;//  퇴근 시간
	private String type;	   //출근 상태
	private int attendance;    //한달간 출근한 횟수
	private int annual; 	   // 연차 개수
	
}
