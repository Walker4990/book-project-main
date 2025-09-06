package com.bk.project.author.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Author {

	private int authorNo;
	private String authorName;
	private String nationality;
	private String gender;
	private LocalDate birthDate;
	private int contractNo;
}
