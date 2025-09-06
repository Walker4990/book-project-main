package com.bk.project.quit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.attendance.vo.Attendance;
import com.bk.project.attendance.vo.AttendanceInfo;
import com.bk.project.attendance.vo.AttendanceSave;
import com.bk.project.evaluation.vo.Evaluation;
import com.bk.project.member.vo.Member;
import com.bk.project.payroll.vo.Payroll;
import com.bk.project.quit.dto.QuitDTO;
import com.bk.project.quit.dto.QuitPagingDTO;
import com.bk.project.quit.vo.Quit;
import com.bk.project.request.vo.Request;
import com.bk.project.salary.vo.Salary;

@Mapper
public interface QuitMapper {
	
	//퇴사할 사원 찾기
	Member findMemberNo(int memberNo);
	
	
	//퇴사 테이블 추가
	int addQuitMember(Quit quit);
	AttendanceInfo getAttendanceInfo(int memberNo);
	Payroll getPayRoll(int memberNo);
	Salary getSalary(int memberNo);
	
	//퇴사 사원 자식 테이블 값 찾기
	AttendanceInfo findAttendanceInfo(int memberNo);
	List<Attendance> findAttendance(int memberNo);
	List<Evaluation> findEvaluation(int memberNo);
	List<Salary> findSalary(int memberNo);
	List<AttendanceSave> findAttendanceSave(int memberNo);
	List<Payroll> findPayroll(int memberNo);
	List<Request> findRequest(int memberNo);
	
	//퇴사 사원 자식 테이블 값 삭제
	int quitAttendanceInfo(int memberNo);
	int quitAttendance(int memberNo);
	int quitSalary(int memberNo);
	int quitPayroll(int memberNo);
	
	//퇴사 사원 부모 테이블 삭제
	int quitMember(int memberNo);
	int quitEvaluation(int memberNo);
	
	
	List<QuitDTO> allQuit(QuitPagingDTO paging);
	int total(QuitPagingDTO paging);


	List<QuitDTO> searchQuit(QuitPagingDTO paging);

	
	int quitAttendanceSave(int memberNo);


	void quitRequest(int memberNo);
}
