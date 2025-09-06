package com.bk.project.department.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.department.vo.Department;

@Mapper
public interface DepartmentMapper {

	List<Department> allDepartment();
}
