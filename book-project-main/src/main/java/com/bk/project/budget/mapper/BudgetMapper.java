package com.bk.project.budget.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.budget.dto.BudgetPagingDTO;
import com.bk.project.budget.vo.BudgetExecution;
import com.bk.project.budget.vo.BudgetPlan;

@Mapper
public interface BudgetMapper {
	void insertBudgetPlan(BudgetPlan bp);
	int existsByMonth(int deptNo, LocalDate budgetMonth);
	LocalDate getBudgetMonth(int budgetNo);
	List<BudgetPlan> allBudgetPlan();
	int updateBudgetPlan(BudgetExecution be);
	void insertBudgetExecution(BudgetExecution be);
	int getRemainingAmount(int budgetNo);
	List<Map<String, Object>> getMonthlyBudget();
	// 부서별 예산 월별 검색
	List<BudgetPlan> budgetSelectByMonth(BudgetPagingDTO paging);
	int budgetCountByMonth(String month);
}
