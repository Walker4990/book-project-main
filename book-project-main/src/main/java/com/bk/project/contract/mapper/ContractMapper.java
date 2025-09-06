package com.bk.project.contract.mapper;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


import com.bk.project.contract.dto.ContractExpiredDTO;
import com.bk.project.contract.dto.ContractPagingDTO;
import com.bk.project.contract.vo.Contract;
import com.bk.project.contract.vo.ContractExpired;

@Mapper
public interface ContractMapper {
	int newContract(Contract contract);
// 페이징 처리
	List<Contract> allContract(ContractPagingDTO fixedPaging);
	List<Contract> searchContract(ContractPagingDTO paging);
	int countContract(ContractPagingDTO paging);
	int countAll();
	
	int updateContract(Contract contract);
	
	Contract getContractByNo(int contractNo);

	int deleteContract(int contractNo);
	
	int deleteContractByBook(int contractNo);
	
	int deleteContractByAuthor(int contractNo);
	
	int confirmContract(String bookTitle);
	
	int deleteQualityCheckByBookNo(int bookNo);
	BigDecimal findRoyaltyRate(int bookNo);

	List<Integer> findBookNoByContract(int contractNo);
	
	List<Integer> findExpired();
	
	// 자동으로 계약 해지/만료 넘어감
	int insertExpiredAuto();
	
	int markContractsExpired();
	
	int deleteExpiredContracts();
	
	 // ▶ 테스트/수동용 (단일 계약 이동)
    int insertExpiredByContractNo(@Param("contractNo") int contractNo,
                                  @Param("closeType") String closeType,
                                  @Param("closeReason") String closeReason);

    int markContractExpiredByContractNo(@Param("contractNo") int contractNo);
	
	
	
	
	List<Contract> selectContractDate();
	
	int insertContractCalendar(Map<String, Object> param);
	
	Integer findContractNoByBookNo(Integer bookNo);
	
	LocalDate findEndDateByBookNo(Integer bookNo);
	
	List<ContractExpired> expiredList(ContractPagingDTO paging);
	
	
	int total();
	
	// 계약 일정에서 상세 계약 조회
	Contract selectContractDetail(int contractNo);
}

