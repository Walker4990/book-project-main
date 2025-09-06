package com.bk.project.salary.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Salary {

	private int salaryNo;
	private int memberNo;
	private String name;
	private int deptNo;
	private int baseSalary; // 기본급
	private int positionAllowance; // 직책 수당
	private int mealAllowance; // 식대
	private int otRate; // 오버타임 수당
	private int tax;
	private LocalDate effectiveDate; // (수당)적용 시작일
	private String description; // 세부사항
	private int totalSalary;
	private int bonus;
	private String deptName;
	
}
