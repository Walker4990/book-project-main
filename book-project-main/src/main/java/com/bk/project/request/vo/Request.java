package com.bk.project.request.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Request {
	
		  private int requestNo;
		  private String title;
		  private String content;
		  private String filePath;
		  private int memberNo;
		  private String memberName;
		  private int approverNo;
		  private LocalDate writeDate;
		  private String approvalStatus;
		  private String writerName;
		  private String approverName;
		
}
