package com.bk.project.printorder.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.book.mapper.BookMapper;
import com.bk.project.book.vo.Book;
import com.bk.project.defect.mapper.DefectMapper;
import com.bk.project.defect.vo.QualityCheck;
import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;
import com.bk.project.inventory.mapper.InventoryMapper;
import com.bk.project.inventory.vo.Inventory;
import com.bk.project.printorder.dto.PrintOrderPagingDTO;
import com.bk.project.printorder.dto.printOrderDTO;
import com.bk.project.printorder.mapper.PrintOrderMapper;
import com.bk.project.printorder.vo.PrintOrder;
import com.bk.project.printorder.vo.PrintOrderDetailVO;
import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;


@Service
public class PrintOrderService {
	@Autowired
	private PrintOrderMapper mapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private InventoryMapper invenMapper;
	
	@Autowired
	private FinancialMapper financeMapper;
	
	@Autowired
	private TaxMapper taxMapper;
	
	@Autowired
	private DefectMapper defectMapper;
	public void newPrintOrder(PrintOrder po) {
		
		mapper.newPrintOrder(po);
		System.out.println("생성된 orderNo = " + po.getOrderNo());

		List<PrintOrderDetailVO> details = po.getDetailList();
		int totalPrice = 0;
		
		if (details != null) {
			for (PrintOrderDetailVO detail : details) {
				if (detail.getBookNo() == null) continue;
				detail.setOrderNo(po.getOrderNo());
				
				// 도서명 및 가격 조회
			    // ★ book 조회 결과 안전하게 처리
			    Book book = bookMapper.selectUpdate(detail.getBookNo());
			    if (book != null) {
			        detail.setProductName(book.getTitle());
			        detail.setRegularPrice(book.getPrice());
			    } else {
			        // 조회 실패시 최소값 보정(제약 회피)
			        if (detail.getProductName() == null || detail.getProductName().isBlank())
			            detail.setProductName("미상");
			        if (detail.getRegularPrice() == null)
			            detail.setRegularPrice(0);
			    }
			    detail.setTotalAmount(detail.getRegularPrice() * detail.getQuantity());

			    mapper.newPrintOrderDetail(detail);
			}
			}
	}
	@Transactional
	public int updateStatus(PrintOrderPagingDTO dto) {

	    // 현재 상태 확인
	    String currentStatus = mapper.selectStatus(dto.getOrderNo());
	    if (currentStatus.equals("배송완료")) {
	        return 0; // 이미 배송완료면 더 이상 처리 안 함
	    }

	    // 상태만 업데이트
	    return mapper.updateStatus(dto.getOrderNo(), dto.getStatus());
	}
	
	
	
	
	public List<PrintOrder> allPrintOrder(PrintOrderPagingDTO paging) {
		 List<PrintOrder> list = mapper.allPrintOrder(paging);
		    for (PrintOrder order : list) {
		        List<PrintOrderDetailVO> details = mapper.getPrintOrderDetailByNo(order.getOrderNo());
		        
		        order.setDetailList(details);
		        System.out.println("orderDetail : " + order.getDetailList());
		    }
		    return list;
	}
	
	public List<PrintOrder> searchPrintOrder(PrintOrderPagingDTO dto) {
		
		System.out.println("dto : " + dto);
		 List<PrintOrder> list = mapper.searchPrintOrder(dto);
		    for (PrintOrder order : list) {
		        List<PrintOrderDetailVO> details = mapper.getPrintOrderDetailByNo(order.getOrderNo());
		        order.setDetailList(details);
		    }
		    return list;
	}
	
	public int countPrintOrder(PrintOrderPagingDTO paging) {
		return mapper.countPrintOrder(paging);
	}
	
	//정보 업데이트
	@Transactional
	public int updatePrintOrder(PrintOrder order) {
		
		System.out.println("service 들어욤");
		List<PrintOrderDetailVO> newList = order.getDetailList();
		
		// 발주 기본 정보 수정
		int result = mapper.updatePrintOrder(order);
		
		// 상세 발주 정보 삭제 후 다시 insert
		
		for(PrintOrderDetailVO detail : newList) {
			detail.setOrderNo(order.getOrderNo());
			//book_no랑 orderNo로 기존 detail 값 가져오기(select문 생성)
			PrintOrderDetailVO vo = mapper.selectDetail(detail);
			//기존의 regular_price 값을 변경할 detail에 넣기(total_amount, regular_price)
			detail.setRegularPrice(vo.getRegularPrice());
			detail.setTotalAmount(vo.getTotalAmount());
			System.out.println("detail에 들어갈 정보 확인"+ detail);
			
			//발주 재고 계산
			int oldQuantity = (vo != null) ? vo.getQuantity() : 0;
			System.out.println("기존 재고" + oldQuantity);
			detail.setQuantity(detail.getQuantity());
			System.out.println("quantity : " + detail.getQuantity());
			
			//삭제 후 재생성
			mapper.deletePrintOrderDetail(detail);
			mapper.newPrintOrderDetail(detail);
			mapper.updateInvenQuantity(detail);
			System.out.println("service 실행 완료");
		}
		
		// 재고 계산
//		for(PrintOrderDetailVO newDetail : newList) {
//			System.out.println("재고계산 : "+ newList);
//			int bookNo = newDetail.getBookNo();
//			int newQuantity = newDetail.getQuantity();
//			
//			PrintOrderDetailVO oldDetail = getOldDetail(oldList, bookNo);
//			int oldQuantity = (oldDetail != null) ? oldDetail.getQuantity() : 0;
//			int editQuantity = newQuantity-oldQuantity;
//			
//		}
		return result;
	}
	
	private PrintOrderDetailVO getOldDetail(List<PrintOrderDetailVO> oldList, Integer bookNo) {
	    for (PrintOrderDetailVO detail : oldList) {
	        if (detail.getBookNo().equals(bookNo)) {
	            return detail;
	        }
	    }
	    return null; // 기존에 없으면 null
	}
	
	public int updatePrintOrderDetail(PrintOrderDetailVO dto) {
		return mapper.updatePrintOrderDetail(dto);
	}
	@Transactional
	public int deletePrintOrder(int orderNo) {
		defectMapper.deleteByOrderNo(orderNo);
	    mapper.deletePrintOrderDetailByOrderNo(orderNo);
		return mapper.deletePrintOrder(orderNo);
	}
	
	public PrintOrder getPrintOrderByNo(Integer orderNo) {
		PrintOrder  printorder = mapper.getPrintOrderByNo(orderNo);
		List <PrintOrderDetailVO> detail = mapper.getPrintOrderDetailByNo(orderNo);
		        
		printorder.setDetailList(detail);
		    return printorder;
	}
	
	public List<PrintOrderDetailVO> getPrintOrderDetailByNo(Integer orderNo) {
		return mapper.getPrintOrderDetailByNo(orderNo);
	}
		
	public boolean validatePrintOrder(PrintOrder po) {
		 
		//null 체크
		if (po == null) 
		 { 
			 System.out.println("V-FAIL: po null"); return false; 
		 }
		 
		 if (po.getOrderDate() == null || po.getDeliveryDate() == null || po.getIssueDate() == null) 
		 {
		     System.out.println("V-FAIL: date null"); return false;
		 }
		 //날짜 체크 
		 if (po.getOrderDate().isAfter(po.getIssueDate())) 
		 {
		     System.out.println("V-FAIL: orderDate > issueDate"); return false;
		 }
		 
		 if (po.getIssueDate().isAfter(po.getDeliveryDate())) {
		     System.out.println("V-FAIL: issueDate > deliveryDate"); return false;
		 }
		 //null 체크
		 if (po.getDetailList() == null || po.getDetailList().isEmpty()) 
		 {
		     System.out.println("V-FAIL: detailList empty"); return false;
		 }

		    int i = 0;
		    for (PrintOrderDetailVO d : po.getDetailList()) {
		        if (d.getBookNo() == null) { System.out.println("V-FAIL["+i+"]: bookNo null"); return false; }
		        if (d.getQuantity() <= 0)   { System.out.println("V-FAIL["+i+"]: quantity <= 0"); return false; }
		        if (d.getPromotionQuantity() < 0) { System.out.println("V-FAIL["+i+"]: promo < 0"); return false; }
		        i++;
		    }
		    System.out.println("V-OK");
		    return true;
		
		    
		    
	}
	public List<PrintOrder> qualityCheckTarget(PrintOrderPagingDTO paging){
		List<PrintOrder> parents = mapper.qualityCheckTarget(paging); 
	    for (PrintOrder p : parents) {
	        List<PrintOrderDetailVO> details = mapper.getPrintOrderDetailByOrderNo(p.getOrderNo());
	        p.setDetailList(details);
	    }
	    return parents;
	}
	public int countQualityCheckTarget(PrintOrderPagingDTO paging) {
		return mapper.countQualityCheckTarget(paging);
	}
	public List<PrintOrder> allQualityCheckTarget(PrintOrderPagingDTO paging) {
		List<PrintOrder> parents = mapper.allQualityCheckTarget(paging); // ✅ Parent 빼고
	    for (PrintOrder p : parents) {
	        List<PrintOrderDetailVO> details = mapper.getPrintOrderDetailByOrderNo(p.getOrderNo());
	        p.setDetailList(details);
	    }
	    return parents;
	}
	
	
	
	public int countAllQualityCheckTarget() {
		return mapper.countAllQualityCheckTarget();
	}
	public int countAllPrintOrder() {
		// TODO Auto-generated method stub
		return mapper.countAllPrintOrder();
	}
	
}
