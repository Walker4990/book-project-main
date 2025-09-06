package com.bk.project.vacation.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.vacation.dto.VacationDTO;
import com.bk.project.vacation.dto.VacationPagingDTO;
import com.bk.project.vacation.vo.Vacation;

@Mapper
public interface VacationMapper {
	
	void addVacation(Vacation vacation);
	List<VacationDTO> allVacation();
	List<VacationDTO> searchVacationInfo(String keyword);
	//검토전, 후 따로 뽑기
	/*
	List<VacationDTO> beforeVacation(VacationPagingDTO paging);
	List<VacationDTO> afterVacation(VacationPagingDTO paging);
	*/
	
	//List<VacationDTO> searchBefore(String keyword);
	//List<VacationDTO> searchAfter(VacationPagingDTO paging);
	
	Vacation getVacation(int vacationNo);
	int approveVacation(Vacation vacation);
	int notApprove(Vacation vacation);
	List<Vacation> getVacationInfo();
	List<Vacation> getApproveVacation();
	List<Vacation> notCheckApprove();
	List<Map<String, Object>> vacationCalendar();
	int total();
	int searchTotal(String keyword);
	
	//----------------------------------------------------
	List<VacationDTO> beforeVacation(VacationPagingDTO pagingBefore);
	List<VacationDTO> afterVacation(VacationPagingDTO pagingAfter);
	List<VacationDTO> searchBefore(VacationPagingDTO pagingBefore);
	List<VacationDTO> searchAfter(VacationPagingDTO pagingAfter);
	int searchTotalBefore(String keyword);
	int searchTotalAfter(String keyword);
	int totalAfter();
	int totalBefore();
	
	List<Vacation> checkDuplicationVacation(Vacation vacation);
	
}
