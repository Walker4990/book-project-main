package com.bk.project.department.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.department.mapper.DepartmentMapper;
import com.bk.project.department.vo.Department;

@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper mapper;
	
	public List<Department> allDepartment(){
		return mapper.allDepartment();
	}
}
