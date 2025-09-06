package com.bk.project.printorder.vo;

import java.time.LocalDate;
import java.util.List;


import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class PrintOrderDetailVO {
	private int detailNo;
	private int orderNo;
	private Integer bookNo;
	private String productName;
	private Integer regularPrice;
	private Integer quantity;
	private Integer totalAmount;
	private int promotionQuantity;
	private int editQuantity;
	
    //  검수 시 입력하는 값
    private Integer checkQuantity;    // 검수 완료 수량
    private String defectReason;
    private List<String> defectReasons;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate printDate;
}
