package com.bk.project.overtime.controller;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.overtime.service.OverTimeService;
import com.bk.project.overtime.vo.OverTime;

@Controller
public class OverTimeController {

	@Autowired
	private OverTimeService overTimeService;
	
	@ResponseBody
	@PostMapping("/newOverTime")
	public String newOverTime(OverTime overtime)
	{
		System.out.println(overtime.getMemberNo());
		OverTime time = overTimeService.searchOverTime(overtime);
		if(time != null)
		{
			System.out.println("오늘 이미 야근 신청을 완료했습니다.");
			return "already";
		}
		
		//데이터 베이스에 추가
		int check = overTimeService.addOverTime(overtime);
		if(check > 0)
		{
			return "success";			
		}
		return "fail";
	}
	
	
	//오늘 야근 날짜인 memberNo 반환
		@ResponseBody
		@GetMapping("/getOverTime")
		public List<Integer> getTodayDate(Model model) {
			LocalDate today = LocalDate.now();
			String day = today.toString();
			
			List<Integer> memberNo = overTimeService.todayOverTime(day); 
		    return memberNo; // 예: "2025-07-30"
		}
	

}
