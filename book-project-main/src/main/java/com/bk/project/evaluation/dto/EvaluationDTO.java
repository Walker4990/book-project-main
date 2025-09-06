package com.bk.project.evaluation.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
// dto로 뺸 이유 -> 진급 대상자 조회 : evaluation, member, department 를 조인해서 만들기 때문에 dto 사용.
public class EvaluationDTO {
	  private int candidateNo;
	  private String memberName;
	  private String deptName;
	  private String grade;
	  private LocalDate registeredAt;
	  private int evaluatorNo;       
	  private String evaluatorName;
}
