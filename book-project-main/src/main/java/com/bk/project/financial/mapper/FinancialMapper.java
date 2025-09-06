package com.bk.project.financial.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bk.project.financial.dto.PagingDTO;
import com.bk.project.financial.vo.Financial;

@Mapper
public interface FinancialMapper {

	void insertFinance(Financial vo);
	List<Financial> revenueSelect(PagingDTO paging);
	int revenueCount();
	List<Financial> expenseSelect(PagingDTO paging);
	int expenseCount();
	int total(String keyword);
	List<Map<String, Object>> getMonthlyFinance();
	
	// 월별 수입 내역 조회
	List<Financial> revenueSelectByMonth(@Param("revenuepaging")PagingDTO revenuepaging);
	int revenueCountByMonth(String isMonth);
	// 월별 지출 내역 조회
	List<Financial> expenseSelectByMonth(@Param("expensepaging")PagingDTO expensepaging, String month);
	int expenseCountByMonth(String month);
	int totals(String keyword);
}
