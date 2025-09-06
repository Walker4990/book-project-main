package com.bk.project.printorder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bk.project.printorder.dto.PrintOrderPagingDTO;
import com.bk.project.printorder.dto.printOrderDTO;
import com.bk.project.printorder.vo.PrintOrder;
import com.bk.project.printorder.vo.PrintOrderDetailVO;



@Mapper
public interface PrintOrderMapper {
	int newPrintOrder(PrintOrder po);
	
	void newPrintOrderDetail(PrintOrderDetailVO pod);
	
	List<PrintOrder> allPrintOrder(PrintOrderPagingDTO paging);
	
	List<PrintOrder> searchPrintOrder(PrintOrderPagingDTO paging);
	
	int countPrintOrder(PrintOrderPagingDTO paging);
	
	int updatePrintOrder(PrintOrder order);
	
	int updatePrintOrderDetail(PrintOrderDetailVO newVO);
	
	PrintOrder getPrintOrderByNo(int orderNo);
	
	List<PrintOrderDetailVO> getPrintOrderDetailByNo(int orderNo);
	
	int deletePrintOrder(int orderNo);
	
	void deletePrintOrderDetail(PrintOrderDetailVO order);

	void updateInvenQuantity(PrintOrderDetailVO order);
	
	PrintOrderDetailVO selectDetail(PrintOrderDetailVO order);
	
	void deleteByBookNo(int bookNo);
	void deletePrintOrderDetailByOrderNo(int bookNo);
	
	int updateStatus(int orderNo, String status);
	
	List<PrintOrderDetailVO> deliveryStatusByOrderNo(int orderNo);
	
	String selectStatus(int orderNo);
	
	// 품질 검수 대상 조회 및 페이징 처리
	List<PrintOrder> qualityCheckTarget(PrintOrderPagingDTO paging);
	int countQualityCheckTarget(PrintOrderPagingDTO paging);
	List<PrintOrder> allQualityCheckTarget(PrintOrderPagingDTO paging);
	int countAllQualityCheckTarget();
	
	
	 List<PrintOrderDetailVO> getPrintOrderDetailByOrderNo(int orderNo);
	
	int updateQualityChecked(Integer orderNo);

	int countAllPrintOrder();


}
