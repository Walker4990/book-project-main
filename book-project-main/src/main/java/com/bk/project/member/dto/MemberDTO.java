package com.bk.project.member.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
	
	private int memberNo;
	private String name;
	private String id;
	private String password;
	private int deptNo;
	private String addr;
	private String email;
	private String role;
	private String deptName;
	private LocalDate joinDate;
	private LocalDate quitDate;
	// 급여 등록시 검색할때 필요
	private long  baseSalary;  
	private long  positionAllowance;  
	private long  mealAllowance;  
	private long  otRate;  
	private long  tax;  
	private long  bonus;  
	private long totalSalary;
}
