package com.bk.project.salary.service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.attendance.mapper.AttendanceMapper;
import com.bk.project.member.dto.MemberDTO;
import com.bk.project.member.mapper.MemberMapper;
import com.bk.project.member.vo.Member;
import com.bk.project.salary.dto.SalaryPagingDTO;
import com.bk.project.salary.mapper.SalaryMapper;
import com.bk.project.salary.vo.PositionSalary;
import com.bk.project.salary.vo.Salary;
import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;

@Service
public class SalaryService {

    @Autowired
    private SalaryMapper mapper;

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private AttendanceMapper attendanceMapper;

    // ✅ 세금 계산 로직 (등록/수정 시 항상 호출)
    private void calculateSalary(Salary s) {
        int base = s.getBaseSalary();
        int pos = s.getPositionAllowance();
        int bonus = s.getBonus();
        int ot = s.getOtRate();
        int meal = s.getMealAllowance();

        // 1. 과세소득
        int taxable = base + pos + bonus + ot;

        // 2. 4대보험
        double pension = taxable * 0.045;   // 국민연금
        double health  = taxable * 0.03545; // 건강보험
        double longTerm = health * 0.1295;  // 장기요양보험
        double empIns  = taxable * 0.009;   // 고용보험

        // 총 공제액
        int realTax = (int) Math.round(pension + health + longTerm + empIns);

        // 3. 총 지급액 (식대는 비과세라 마지막에 합산)
        int totalSalary = taxable + meal - realTax;

        // 4. VO 세팅
        s.setTax(realTax);
        s.setTotalSalary(totalSalary);
        s.setEffectiveDate(LocalDate.now());
    }

    /**
     * 급여 등록
     * - OT/보너스 반영
     * - 세금 계산 (calculateSalary 호출)
     * - Salary 테이블 INSERT
     * ⚠️ Tax는 지급 시점에만 등록 → 여기서는 제외
     */
    @Transactional
    public boolean insertSalary(List<Salary> list) {
        try {
            Map<Integer, Integer> bonusMap = new HashMap<>();
            if (list != null) {
                for (Salary s : list) {
                    if (s != null && s.getMemberNo() != 0) {
                        bonusMap.put(s.getMemberNo(),
                                     (s.getBonus() == 0) ? 0 : s.getBonus());
                    }
                }
            }

            List<Member> allMember = memberMapper.allMembers();
            String thisMonth = LocalDate.now().toString().substring(0, 7);

            for (Member m : allMember) {
                PositionSalary ps = mapper.positionSalary(m.getPosition());

                // OT 계산
                String overTimeStr = attendanceMapper.findMonthlyOvertime(m.getMemberNo(), thisMonth);
                Duration overtime = Duration.ZERO;
                if (overTimeStr != null) {
                    LocalTime time = LocalTime.parse(overTimeStr);
                    overtime = Duration.between(LocalTime.MIN, time);
                }
                long overMinutes = overtime.toMinutes();
                double monthlyWorkHours = 209.0;
                double hourlyRate = ps.getBaseSalary() / monthlyWorkHours;
                double overTimePay = (overMinutes / 60.0) * hourlyRate * 1.5;

                // Bonus
                int bonus = bonusMap.getOrDefault(m.getMemberNo(), 0);

                // Salary 세팅
                Salary s = new Salary();
                s.setMemberNo(m.getMemberNo());
                s.setName(m.getName());
                s.setDeptNo(m.getDeptNo());
                s.setBaseSalary(ps.getBaseSalary());
                s.setMealAllowance(ps.getMealAllowance());
                s.setPositionAllowance(ps.getPositionAllowance());
                s.setOtRate((int) overTimePay);
                s.setBonus(bonus);

                // 세금/총액 계산
                calculateSalary(s);

                // Salary INSERT
                mapper.insertSalary(s);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ 급여 단건 수정 시 세금 재계산 & Salary UPDATE
    @Transactional
    public int updateSalary(Salary s) {
        calculateSalary(s); // 세금/총액 재계산
        return mapper.updateSalary(s);
    }

    public int getTotalSalary(int memberNo) {
        return mapper.getTotalSalary(memberNo);
    }

    public List<Salary> allSalary(SalaryPagingDTO paging) {
        return mapper.allSalary(paging);
    }

    public int deleteSalary(int salaryNo) {
        return mapper.deleteSalary(salaryNo);
    }

    public List<Salary> searchSalary(SalaryPagingDTO paging) {
        return mapper.searchSalary(paging);
    }

    public List<Salary> getAllSalaryInfo(SalaryPagingDTO paging) {
        return mapper.getAllSalaryInfo(paging);
    }

    public int total(SalaryPagingDTO paging) {
        return mapper.total(paging);
    }

    public int totalAll() {
        return mapper.totalAll();
    }

    public Salary getSalaryByNo(int salaryNo) {
        return mapper.getSalaryByNo(salaryNo);
    }
}
