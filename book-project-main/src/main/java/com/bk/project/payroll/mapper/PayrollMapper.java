package com.bk.project.payroll.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bk.project.payroll.dto.PayrollPagingDTO;
import com.bk.project.payroll.vo.Payroll;
import com.bk.project.salary.vo.Salary;

@Mapper
public interface PayrollMapper {

	void insertPayroll(Payroll pr);
	int countPayrollThisMonth(@Param("yearMonth") String yearMonth);
	List<Salary> getLatestSalaryList(PayrollPagingDTO fixedPaging);
	int countAll();
}
