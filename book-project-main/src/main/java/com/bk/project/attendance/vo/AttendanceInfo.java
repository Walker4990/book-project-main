package com.bk.project.attendance.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class AttendanceInfo {
	private int attendanceInfoNo;
	private int memberNo;
	private String type;	   //출근 상태
	private int vacation;
	private int attendance;    //한달간 출근한 횟수
	private int Annual; 	   // 연차 개수
	
}
