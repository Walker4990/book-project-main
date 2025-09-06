package com.bk.project.evaluation.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Evaluation {
	private int evalNo;
	private int memberNo;
	private int evaluatorNo;
	private String grade;
	private LocalDate evalDate;
	private String reason;
	private LocalDate registeredAt;
}
