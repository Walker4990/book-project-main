package com.bk.project.budget.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.budget.dto.BudgetPagingDTO;
import com.bk.project.budget.mapper.BudgetMapper;
import com.bk.project.budget.vo.BudgetExecution;
import com.bk.project.budget.vo.BudgetPlan;
import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;

@Service
public class BudgetService {

	@Autowired
	private BudgetMapper mapper;
	@Autowired
	private FinancialMapper financialMapper;
	
	public void insertBudgetPlan(BudgetPlan bp) {
		if(mapper.existsByMonth(bp.getDeptNo(), bp.getBudgetMonth()) >0) {
			  throw new IllegalStateException("이미 해당 월에 등록된 부서입니다.");
		}
		mapper.insertBudgetPlan(bp);
	}
	public List<BudgetPlan> allBudgetPlan(){
		return mapper.allBudgetPlan();
	}
	@Transactional
	public String insertBudgetExecution(BudgetExecution be) {
	    // 1. 현재 남은 예산 조회
	    int remaining = mapper.getRemainingAmount(be.getBudgetNo());
	    LocalDate budgetMonth = mapper.getBudgetMonth(be.getBudgetNo());
	    
	    System.out.println("👉 insertBudgetExecution 실행됨");
	    System.out.println("👉 execDate = " + be.getExecDate() + ", budgetMonth = " + budgetMonth);
	    System.out.println("👉 remaining = " + remaining);
	    // 2-1. 날짜 정합성 체크 
	    if(be.getExecDate().isBefore(budgetMonth)) {
	        return "failDate";
	    }
	    // 2-2. 예산 초과 여부 체크
	    if (be.getAmount() > remaining) {
	        return "failAmount";
	       
	    }
		mapper.insertBudgetExecution(be);
		int updated = mapper.updateBudgetPlan(be);
		System.out.println("👉 updateBudgetPlan 실행됨, updated rows = " + updated);
		
		Financial fi = new Financial();
		fi.setType("EXPENSE");
		fi.setCategory("예산 집행");
		fi.setRelatedNo(be.getBudgetNo());
		fi.setTotalPrice(be.getAmount());
		fi.setTransactionDate(be.getExecDate());
		fi.setDescription(be.getDescription());
		financialMapper.insertFinance(fi);
		return "success";
	}
	public List<Map<String, Object>> getMonthlyBudget(){
		return mapper.getMonthlyBudget();
	}
	public List<BudgetPlan> budgetSelectByMonth(BudgetPagingDTO paging){
		return mapper.budgetSelectByMonth(paging);
	}
	public int budgetCountByMonth(String month) {
		return mapper.budgetCountByMonth(month);
	}
	public boolean existsByMonth(int deptNo, LocalDate budgetMonth) {
		return mapper.existsByMonth(deptNo, budgetMonth) >0;
	}
}
