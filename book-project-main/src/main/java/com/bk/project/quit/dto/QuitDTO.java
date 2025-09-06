package com.bk.project.quit.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuitDTO {
	
	private int quitNo;
	private String deptName;
	private String name;
	private String position;
	private String addr;
	private String email;
	private LocalDate joinDate;
	private LocalDate quitDate;
	private int attendance;
	private int otRate;
	private int baseSalary;
	private int positionAllowance;
	private int tax;
	private int totalSalary;
	private int bonus;
	
}
