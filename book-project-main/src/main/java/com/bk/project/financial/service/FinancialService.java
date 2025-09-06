package com.bk.project.financial.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.financial.dto.PagingDTO;
import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;

@Service
public class FinancialService {

	@Autowired
	private FinancialMapper mapper;
	
	public void insertFinancial(Financial vo) {
		mapper.insertFinance(vo);
	}
	
	public List<Financial> revenueSelect(PagingDTO revenuepaging){
		return mapper.revenueSelect(revenuepaging);
	}
	public int revenueTotal() {
	    return mapper.revenueCount(); // 조건 걸린 count
	}
	
	public List<Financial> expenseSelect(PagingDTO expensepaging){
		expensepaging.setOffset(expensepaging.getLimit() * (expensepaging.getPage() -1));
	
		return mapper.expenseSelect(expensepaging);
	}
	public int expenseTotal() {
	    return mapper.expenseCount(); // 조건 걸린 count
	}

	public int total(String keyword) {
		return mapper.total(keyword);
	}
	
	public List<Map<String, Object>> getMonthlyFinance(){
		return mapper.getMonthlyFinance();
	}
	
	public List<Financial> revenueSelectByMonth(PagingDTO revenuepaging){
		return mapper.revenueSelectByMonth(revenuepaging);
	}
	
	public List<Financial> expenseSelectByMonth(PagingDTO expensepaging, String month){
		return mapper.expenseSelectByMonth(expensepaging, month);
	}
	
	public int totals(String keyword) {
		return mapper.total(keyword);
	}
	
	
	
	public int revenueCountByMonth(String isMonth) {
		return mapper.revenueCountByMonth(isMonth);
	}
	
	public int expenseCountByMonth(String months) {
		return mapper.expenseCountByMonth(months);
	}
	
}
