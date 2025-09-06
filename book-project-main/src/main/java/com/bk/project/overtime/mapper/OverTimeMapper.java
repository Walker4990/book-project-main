package com.bk.project.overtime.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.overtime.vo.OverTime;

@Mapper
public interface OverTimeMapper {

	int addOverTime(OverTime overtime);
	List<Integer> todayOverTime(String day);
	OverTime searchOverTime(OverTime overTime);
}
