package com.bk.project.salary.dto;

import java.util.ArrayList;
import java.util.List;

import com.bk.project.salary.vo.Salary;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SalaryForm {
    // 스프링이 기본생성자 + getter/setter 보고 바인딩합니다.
    private List<Salary> memberList = new ArrayList<>();
//    private Integer memberNo;   // null 체크 가능
//    private Integer bonus;      // 입력 안 하면 null
//    private Integer otRate;
//    private Integer tax;
//    private Integer totalSalary;
}
