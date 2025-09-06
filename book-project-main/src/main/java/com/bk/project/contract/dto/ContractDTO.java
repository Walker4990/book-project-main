package com.bk.project.contract.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;

@Data
public class ContractDTO {
	private int contractNo;
    private String bookTitle;
    private int contractAmount;
    private BigDecimal royaltyRate;
    private String endDate;
    private String manuscriptDue;
    private String printDate;
    private String publishDate;
    private List<Integer> contractNos; // 단건/다건 둘 다 처리 가능
    private String closeType;          // EXPIRE(만료), CANCEL(해지)
    private String reason;              // 해지 사유 등 옵션
    private String genre;
}
