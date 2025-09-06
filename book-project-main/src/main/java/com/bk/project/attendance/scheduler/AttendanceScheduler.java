package com.bk.project.attendance.scheduler;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.bk.project.attendance.mapper.AttendanceMapper;
import com.bk.project.attendance.vo.Attendance;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.attendance.vo.AttendanceSave;
import com.bk.project.member.dto.MemberPagingDTO;
import com.bk.project.member.mapper.MemberMapper;
import com.bk.project.member.vo.Member;
import com.bk.project.vacation.mapper.VacationMapper;
import com.bk.project.vacation.vo.Vacation;

@Component
public class AttendanceScheduler {
	@Autowired
	 private AttendanceMapper attendanceMapper;
	@Autowired
	 private MemberMapper memberMapper;
	@Autowired
     private VacationMapper vacationMapper;
	
	 
     	// 출/퇴근 버튼 클릭 시 : 근무시간, 초과근무 시간 저장
     	public void allCheckinOut(Attendance li)
     	{
			// 출/퇴근 버튼 모두 클릭했을시
			LocalTime checkIn = li.getCheckIn();
			LocalTime checkOut = li.getCheckOut();
			
			Duration inOut = Duration.between(checkIn, checkOut);
			LocalTime totalTime = LocalTime.MIDNIGHT.plus(inOut);
			LocalTime trimNano = totalTime.truncatedTo(ChronoUnit.SECONDS);
			
			li.setWorkingHours(trimNano);
			attendanceMapper.setTotalTime(li); 
			
			System.out.println("총 근무시간 저장 완료!");
	    	
			//초과 근무 계산
	    	Duration baseWorkTime = Duration.ofHours(8);
	    	if(inOut.compareTo(baseWorkTime) > 0) {
	    		Duration over = inOut.minus(baseWorkTime);
	    		LocalTime overTime = LocalTime.MIDNIGHT.plus(over).truncatedTo(ChronoUnit.SECONDS);
	    		li.setOverTime(overTime);
	    		attendanceMapper.setOverTime(li);
	    	}
	    	System.out.println("초과 근무시간 저장 완료!");
	    	
     	}
     	
     	
     	//출근 버튼만 눌렀을 시
     	public void checkinOnly(Attendance li)
     	{
     		//출근 버튼만 클릭 했을 시
			LocalTime checkIn = li.getCheckIn();
			LocalTime checkOut = LocalTime.of(17, 0);
		
			Duration inOut = Duration.between(checkIn, checkOut);
			LocalTime totalTime = LocalTime.MIDNIGHT.plus(inOut);
			LocalTime trimNano = totalTime.truncatedTo(ChronoUnit.SECONDS);
		
			li.setWorkingHours(trimNano);
			li.setCheckOut(checkOut);
			attendanceMapper.notCheckout(li);
			System.out.println("퇴근버튼 x , 근무시간 저장 완료!");
     	}
     	
     	
     	//출근 퇴근 버튼 둘다 안눌렀을 시 
     	public void notCheck(Attendance li)
     	{
    		//출, 퇴근 시간이 안적혀있을 경우
    		Attendance notCheck = new Attendance();
    		notCheck.setDate(LocalDate.now().minusDays(1));
    		notCheck.setMemberNo(li.getMemberNo());
    		
    		// 출/퇴근 시간이 없는 attendance 생성
    		attendanceMapper.notCheck(notCheck);
     	}
     	
     	//신입 사원 연차 관리
     	public void annualNewbie(Member m)
     	{
     		LocalDate today = LocalDate.now();
     		//입사한 날짜마다 연차 1개 지급
			LocalDate joinDate = m.getJoinDate();
			//개월만 알고 싶을 때(1개월부터 계산)
			long joinMonth = ChronoUnit.MONTHS.between(joinDate.withDayOfMonth(1), today.withDayOfMonth(1));
			LocalDate isJoinMonth = joinDate.plusMonths(joinMonth);
			
			//오늘 날짜가 입사일로부터 1달일 때
			if(today.isEqual(isJoinMonth))
			{
				AttendanceInfo info = attendanceMapper.annualInfo(m.getMemberNo());
				if(info.getAnnual() < 11)
				{
					attendanceMapper.annualSet(info.getMemberNo());
				}
			}
     	}
     	//신입 사원이 아닌 경우 연자 관리
     	public void annualNotNewbie(Member m)
     	{
     		LocalDate today = LocalDate.now();
     		LocalDate joinYear = m.getJoinDate();
			long isjoinYear = ChronoUnit.YEARS.between(joinYear, today);
			LocalDate nowYear = joinYear.plusYears(isjoinYear);
			
			//오늘 날짜가 입사일로부서 1년일 때 == 15개
			if(today.isEqual(nowYear))
			{
				attendanceMapper.annualSetFull(m.getMemberNo());
			}
     	}
     	
     	
     	//한달간 출근 횟수 저장
     	public void saveAttendance(AttendanceInfo li)
     	{
     		//저장 및 초기화
	    	YearMonth now = YearMonth.now();
	    	YearMonth month = now.minusMonths(1);
	    	
			AttendanceSave save = new AttendanceSave();
			save.setMemberNo(li.getMemberNo());
			save.setAttendance(li.getAttendance());
			save.setMonth(month);
			save.setVacation(li.getVacation());
			
			//save 테이블에 저장
			attendanceMapper.saveStatus(save);
     	}
     	
     	//휴가 사원 관리
     	public void vacationCheck(Vacation va)
     	{
     		LocalDate today = LocalDate.now();
     		LocalDate startDate =  va.getStartDate();
			LocalDate endDate = va.getEndDate();
			  //끝까지 세었으면 나가기
			while(!startDate.isAfter(endDate))
			{
			   //만약 memberNo에서 찾은 휴가 날짜가 오늘날이랑 겹치면 
			    if(startDate.isEqual(today))
			    {
			    	//attendanceInfo update에서 type '휴가'로 변경
			    	attendanceMapper.changeVacation(va.getMemberNo());
			    	//vacation + 1
			    	attendanceMapper.goVacation(va.getMemberNo());
			    	break;
			   }
			   startDate = startDate.plusDays(1);
			}
     	}
     	
     	//미승인 상태인데 휴가시작날짜가 오늘이면 자동으로 미승인 처리
     	public void notCheckApprove(Vacation v)
     	{
     		LocalDate Dday = LocalDate.now();
			LocalDate vacationDay = v.getStartDate();
			
			//만약 오늘날짜가 휴가시작 날짜를 지나면
			if(Dday.isAfter(vacationDay))
			{	//미승인 처리
				int check = vacationMapper.notApprove(v);
			}
     	}
     	

     	
     
	    @Scheduled(cron = "0 0 5 * * ?") // 매일 오전 5시
	    public void resetWorkStatus() 
	    {
	    	//어제 날짜의 리스트 가져오기
	    	LocalDate today = LocalDate.now();
	    	LocalDate day = LocalDate.now().minusDays(1);
	    	Attendance getDate = new Attendance();
	    	getDate.setDate(day);
	    	List<Attendance> attendance = attendanceMapper.getAttendance(getDate);
	    	
	    // 연차 계산
	    	//전체 직원 불러오기
	    	List<Member> member = memberMapper.allMembers();
	    	if(member != null)
	    	{
	    		for(Member m : member) 		
	    		{	//만약 신입 사원일 경우, 한달에 1개씩 적용
	    			//모든 info 정보 '출근전' 으로 초기화
	    			attendanceMapper.resetStatus(m.getMemberNo());
	    			
	    			if(m.getPosition().equals("사원"))
	    			{
	    				annualNewbie(m);
	    			}
	    			//신입사원이 아닐경우
	    			else {
	    				annualNotNewbie(m);
	    			}
	    		}//member m
	    	}
	    	
	    	//총 근무 시간 계산 후 값 넣기, 초과 근무 계산
	    	if(attendance != null)
	    	{
	    		for(Attendance li: attendance)
	    		{
	    			if(li.getCheckIn() != null && li.getCheckOut() != null){
	    				allCheckinOut(li);
	    			}
	    			else if(li.getCheckIn() != null && li.getCheckOut() == null){
	    				checkinOnly(li);
	    			}
	    			else
	    			{
	    				notCheck(li);
	    			}
	    		}
	    	}
	    	
	    	
	    	//휴가신청 가져오기 : 휴가인 사람들 info -> '휴가'로 변경
			List<Vacation> vacationInfo = vacationMapper.getApproveVacation();
			if(vacationInfo != null)
			{
				for(Vacation va : vacationInfo)
				{
					vacationCheck(va);
				}//vacation v
			}
			
			//만약 휴가시작 날짜가 오늘인데 승인전일 경우 자동으로 미승인 처리
			List<Vacation> notCheckInfo = vacationMapper.notCheckApprove();
			if(notCheckInfo != null)
			{
				for(Vacation v: notCheckInfo)
				{
					notCheckApprove(v);
				}
			}

	        System.out.println("12시 땡");
	    }
	    
	    @Scheduled(cron = "0 0 0 1 * ?") // 매월 1일 업데이트
	    public void monthWorkStatus() {
	    	List<Member> member = memberMapper.allMembers();
     		for(Member m: member)
     		{
    		    List<AttendanceInfo> info = attendanceMapper.getInfo();
    		    if(info != null)
    		    {
    		    	for(AttendanceInfo li: info)
    		    	{
    		    		saveAttendance(li);
    		    	}
    		    }
    		    //info 테이블 초기화
    		    attendanceMapper.monthStatus();
     		}
	    }

}
