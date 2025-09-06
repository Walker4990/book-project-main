package com.bk.project.budget.vo;


import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BudgetPlan {
	private int budgetNo;
	private int deptNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate budgetMonth;
	private int totalAmount;
	private int spentAmount;
	private int remainingAmount;
	private String deptName;
}
