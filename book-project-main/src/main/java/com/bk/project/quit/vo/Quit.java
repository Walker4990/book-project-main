package com.bk.project.quit.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Quit {
	private int quitNo;
	private int deptNo;
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

