package com.bk.project.defect.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.book.vo.Book;
import com.bk.project.defect.dto.DefectPagingDTO;
import com.bk.project.defect.vo.Defect;
import com.bk.project.defect.vo.QualityCheck;
import com.bk.project.inventory.vo.Inventory;
import com.bk.project.printorder.vo.PrintOrderDetailVO;

@Mapper
public interface DefectMapper {

	void newDefect(Defect defect);
	
	Defect selectDefect(int defectNo);
    int updateDefect(Defect defect);
    int deleteDefect(int defectNo);
	void deleteByBookNo(int bookNo);
	Book selectBook(int bookNo);
	
	
	// 페이징 처리
	List<Defect> searchDefect(DefectPagingDTO dto);
	List<Defect> allDefect(DefectPagingDTO paging);
	int countAll();
	int countDefect(DefectPagingDTO paging);
	
	List<Map<String, Object>> selectDefectStats();
	
	int insertQualityCheck(QualityCheck qc);
	boolean existsByOrderNo(int orderNo);
	
	int deleteByOrderNo(int orderNo);
	
	Defect findDefectNo();
	Defect findDefectbyDefectNo(int defectNo);
	List<PrintOrderDetailVO> selectOrderDetailByOrderNo(int orderNo);
	
	PrintOrderDetailVO selectOrderDetailByDetailNo(int detailNo);
	
	
	void updateDetail(PrintOrderDetailVO detail);
	void updateInventory(Inventory inven);
	
}
