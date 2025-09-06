package com.bk.project.payroll.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Payroll {
	private int payrollNo;
	private int memberNo;
	private int salaryNo;
	private LocalDate salaryDate;
	private int payAmount;
	private int financeTransactionNo;
	
	
}
