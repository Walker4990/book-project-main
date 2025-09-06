package com.bk.project.overtime.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.overtime.mapper.OverTimeMapper;
import com.bk.project.overtime.vo.OverTime;

@Service
public class OverTimeService implements OverTimeMapper{

	@Autowired
	private OverTimeMapper overTimeMapper;

	@Override
	public int addOverTime(OverTime overtime) {
		return overTimeMapper.addOverTime(overtime);
	}

	@Override
	public List<Integer> todayOverTime(String day) {
		return overTimeMapper.todayOverTime(day);
	}

	@Override
	public OverTime searchOverTime(OverTime overTime) {
		return overTimeMapper.searchOverTime(overTime);
	}
}
