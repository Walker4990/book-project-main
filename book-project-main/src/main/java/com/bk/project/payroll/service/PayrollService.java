package com.bk.project.payroll.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;
import com.bk.project.payroll.dto.PayrollPagingDTO;
import com.bk.project.payroll.mapper.PayrollMapper;
import com.bk.project.payroll.vo.Payroll;
import com.bk.project.salary.mapper.SalaryMapper;
import com.bk.project.salary.vo.Salary;
import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;

@Service
public class PayrollService {

	 @Autowired
	    private PayrollMapper mapper;

	    @Autowired
	    private FinancialMapper finanMapper;

	    @Autowired
	    private SalaryMapper salaryMapper;

	    @Autowired
	    private TaxMapper taxMapper;


	  @Transactional
	    public boolean insertPayroll(List<Payroll> list) {
	        if (list == null || list.isEmpty()) return false;

	        // 이번 달 체크 (salaryDate → yyyy-MM)
	        String yearMonth = list.get(0).getSalaryDate()
	                .format(DateTimeFormatter.ofPattern("yyyy-MM"));
	        int alreadyPaid = mapper.countPayrollThisMonth(yearMonth);
	        if (alreadyPaid > 0) {
	            return false; // 이번 달 이미 지급됨
	        }

	        for (Payroll p : list) {
	            // 1. Salary 조회 (세금 계산된 값)
	            Salary s = salaryMapper.getSalaryByNo(p.getSalaryNo());

	            // 2. Tax INSERT (지급 시점에만)
	            int taxable = s.getBaseSalary() + s.getPositionAllowance() + s.getBonus() + s.getOtRate();
	            double taxRate = (taxable != 0) ? ((double) s.getTax() / taxable) * 100 : 0.0;

	            Tax t = new Tax();
	            t.setCategory("4대보험");
	            t.setRelatedNo(s.getSalaryNo());
	            t.setRelatedTable("salary");
	            t.setTaxAmount(s.getTax());
	            t.setTaxRate(Math.round(taxRate * 100.0) / 100.0);
	            t.setTaxDate(p.getSalaryDate());
	            t.setDescription("세금 확정 : " + s.getMemberNo() + " 급여 지급");

	            taxMapper.insertTax(t);

	            // 3. Financial INSERT (재무 지출 기록)
	            Financial fi = new Financial();
	            fi.setCategory("급여");
	            fi.setType("EXPENSE");
	            fi.setTotalPrice(p.getPayAmount());
	            fi.setTransactionDate(p.getSalaryDate());
	            fi.setDescription("사번 : " + p.getMemberNo() + " 급여 지급");
	            fi.setRelatedNo(s.getSalaryNo());

	            finanMapper.insertFinance(fi);
	            p.setFinanceTransactionNo(fi.getTransactionNo());

	            // 4. Payroll INSERT (급여 지급 이력)
	            mapper.insertPayroll(p);
	        }

	        return true;
	    }
	

	



	public List<Salary> getLatestSalaryList(PayrollPagingDTO fixedPaging) {
		return mapper.getLatestSalaryList(fixedPaging);
	}
	public int countAll() {
		return mapper.countAll();
	}





}

