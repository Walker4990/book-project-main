package com.bk.project.quit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.attendance.vo.Attendance;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.attendance.vo.AttendanceSave;
import com.bk.project.evaluation.vo.Evaluation;
import com.bk.project.member.vo.Member;
import com.bk.project.payroll.vo.Payroll;
import com.bk.project.quit.dto.QuitDTO;
import com.bk.project.quit.dto.QuitPagingDTO;
import com.bk.project.quit.mapper.QuitMapper;
import com.bk.project.quit.vo.Quit;
import com.bk.project.request.vo.Request;
import com.bk.project.salary.vo.Salary;

@Service
public class QuitService implements QuitMapper{

	@Autowired
	private QuitMapper mapper;
	
	//퇴사 테이블에 넣기
	
	@Override
	public int addQuitMember(Quit quit) {
		return mapper.addQuitMember(quit);
	}

	@Override
	public AttendanceInfo getAttendanceInfo(int memberNo) {
		return mapper.getAttendanceInfo(memberNo);
	}

	@Override
	public Payroll getPayRoll(int memberNo) {
		return mapper.getPayRoll(memberNo);
	}

	@Override
	public Salary getSalary(int memberNo) {
		return mapper.getSalary(memberNo);
	}

	//값 찾기

	@Override
	public Member findMemberNo(int memberNo) {
		return mapper.findMemberNo(memberNo);
	}

	@Override
	public AttendanceInfo findAttendanceInfo(int memberNo) {
		return mapper.findAttendanceInfo(memberNo);
	}

	@Override
	public List<Attendance> findAttendance(int memberNo) {
		return mapper.findAttendance(memberNo);
	}

	@Override
	public List<Salary> findSalary(int memberNo) {
		return mapper.findSalary(memberNo);
	}

	@Override
	public List<Payroll> findPayroll(int memberNo) {
		return mapper.findPayroll(memberNo);
	}
	
	//테이블 값 삭제하기
	
	
	@Override
	public int quitAttendanceInfo(int memberNo) {
		return mapper.quitAttendanceInfo(memberNo);
	}

	@Override
	public int quitAttendance(int memberNo) {
		return mapper.quitAttendance(memberNo);
	}

	@Override
	public int quitSalary(int memberNo) {
		return mapper.quitSalary(memberNo);
	}

	@Override
	public int quitPayroll(int memberNo) {
		return mapper.quitPayroll(memberNo);
	}
	
	@Override
	@Transactional
	public int quitMember(int memberNo) {
		
		AttendanceInfo info = mapper.findAttendanceInfo(memberNo);
		if(info!= null)
		{
			mapper.quitAttendanceInfo(memberNo);
			System.out.println("attendanceInfo 삭제 완료");
		}
		List <AttendanceSave> save = mapper.findAttendanceSave(memberNo);
		if(!save.isEmpty()  && save!=null)
		{
			mapper.quitAttendanceSave(memberNo);
		}
		List<Request> request = mapper.findRequest(memberNo);
		if(request != null  && !request.isEmpty())
		{
			mapper.quitRequest(memberNo);
		}
		
		List<Attendance> attendance = mapper.findAttendance(memberNo);
		if(attendance != null && !attendance.isEmpty())
		{
			mapper.quitAttendance(memberNo);
			System.out.println("attendance 삭제 완료");
		}
		List<Payroll> payroll = mapper.findPayroll(memberNo);
		if(payroll != null && !payroll.isEmpty())
		{
			mapper.quitPayroll(memberNo);
			System.out.println("payroll 삭제 완료");
		}
		List<Salary> salary = mapper.findSalary(memberNo);
		if(salary != null  && !salary.isEmpty())
		{
			mapper.quitSalary(memberNo);
			System.out.println("salary 삭제 완료");
		}
		
		List<Evaluation> evals = mapper.findEvaluation(memberNo);
		if (evals != null && !evals.isEmpty()) {
			mapper.quitEvaluation(memberNo);
		    System.out.println("evaluation 삭제 완료");
		}
		
		
		
		int deleteCheck =mapper.quitMember(memberNo);
		if(deleteCheck <= 0)
		{
			System.out.println("삭제 실패");
			return -1;
		}
		return deleteCheck;
	}

	@Override
	public List<QuitDTO> allQuit(QuitPagingDTO paging) {
		return mapper.allQuit(paging);
	}
	
	public int total(QuitPagingDTO paging) {
		return mapper.total(paging);
	}

	@Override
	public List<Evaluation> findEvaluation(int memberNo) {
		return mapper.findEvaluation(memberNo);
	}

	@Override
	public int quitEvaluation(int memberNo) {
		return mapper.quitEvaluation(memberNo);
	}

	public List<QuitDTO> searchQuit(QuitPagingDTO paging) {
		return mapper.searchQuit(paging);
	}

	@Override
	public List<AttendanceSave> findAttendanceSave(int memberNo) {
		return mapper.findAttendanceSave(memberNo);
	}


	public int quitAttendanceSave(int memberNo) {
		return mapper.quitAttendanceSave(memberNo);
	}

	@Override
	public List<Request> findRequest(int memberNo) {
		return mapper.findRequest(memberNo);
	}
	@Override
	public void quitRequest(int memberNo) {
		mapper.quitRequest(memberNo);
		
	}


}
