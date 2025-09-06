package com.bk.project.salary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.salary.vo.PositionSalary;
import com.bk.project.member.dto.MemberDTO;
import com.bk.project.salary.dto.SalaryPagingDTO;
import com.bk.project.salary.vo.Salary;

@Mapper
public interface SalaryMapper {

	void insertSalary(Salary sal);
	int getTotalSalary(int memberNo);
	List<Salary> allSalary(SalaryPagingDTO paging);
	PositionSalary positionSalary(String position);
	int deleteSalary(int salaryNo);
	List<Salary> searchSalary(SalaryPagingDTO paging);
	Salary getSalaryByNo(int salaryNo);
	int updateSalary(Salary s);
	List<Salary> getAllSalaryInfo(SalaryPagingDTO paging);
	int total(SalaryPagingDTO paging);
	int totalAll();
}