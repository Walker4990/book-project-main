package com.bk.project.budget.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BudgetExecution {
	private int execNo;
	private int budgetNo;
	private LocalDate execDate;
	private int amount;
	private String description;
	private LocalDateTime createdAt;
    // Join 용
    private String deptName;
}
