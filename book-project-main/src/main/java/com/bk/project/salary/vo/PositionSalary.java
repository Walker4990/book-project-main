package com.bk.project.salary.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PositionSalary {
	private String position;
	private int baseSalary;
	private int positionAllowance;
	private int mealAllowance;
}
