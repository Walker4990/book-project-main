package com.bk.project.defect.service;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.book.mapper.BookMapper;
import com.bk.project.book.vo.Book;
import com.bk.project.defect.dto.DefectPagingDTO;
import com.bk.project.defect.dto.QualityCheckDTO;
import com.bk.project.defect.mapper.DefectMapper;
import com.bk.project.defect.vo.Defect;
import com.bk.project.defect.vo.QualityCheck;
import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;
import com.bk.project.inventory.mapper.InventoryMapper;
import com.bk.project.inventory.vo.Inventory;
import com.bk.project.printorder.mapper.PrintOrderMapper;
import com.bk.project.printorder.vo.PrintOrder;
import com.bk.project.printorder.vo.PrintOrderDetailVO;
import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class DefectService {

	@Autowired
    private DefectMapper mapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private InventoryMapper inventoryMapper;
	
	@Autowired
	private TaxMapper taxMapper;
	@Autowired
	private FinancialMapper financialMapper;
	@Autowired
	private PrintOrderMapper printOrderMapper;
	
	
	
	// 도서 리스트
	public List<Book> getBookList() {
		return bookMapper.allBooks();
	}
	
	// 신규 보고서 등록
	@Transactional
	public void newDefect(Defect defect) {
		
		if (defect.getStatusList() != null && !defect.getStatusList().isEmpty()) {
	        defect.setStatus(String.join(",", defect.getStatusList()));
	    }
		
		// 도서명
		Book book = bookMapper.selectUpdate(defect.getBookNo());
		if(book != null) {
			defect.setTitle(book.getTitle());
			if (defect.getPrice() == null) defect.setPrice(book.getPrice());
		}
		 Integer qty = defect.getQuantity();
		 Integer price = defect.getPrice();
		 defect.setTotalAmount((qty == null || price == null) ? 0 : qty * price);

		 mapper.newDefect(defect);
		}

	
	// 보고서 검색 조회
	public List<Defect> searchDefect(DefectPagingDTO dto) {
        return mapper.searchDefect(dto);
    }
	
	// 보고서 전체 조회
	public List<Defect> allDefect(DefectPagingDTO paging) {
        return mapper.allDefect(paging);
    }
	
	// 선택 보고서 수정버튼 이동
	public Defect selectDefect(int defectNo) {
		Defect defect = mapper.selectDefect(defectNo);
		
		if(defect.getStatus() != null && !defect.getStatus().equals("")) {
			defect.setStatusList((Arrays.asList(defect.getStatus().split(","))));
		}
		return defect;
			
	}
	
	public PrintOrderDetailVO selectOrderDetailByDetailNo(int detailNo)
	{
		return mapper.selectOrderDetailByDetailNo(detailNo);
	}
	public void updateDetail(PrintOrderDetailVO detail)
	{
		 mapper.updateDetail(detail);
	}
	public void updateInventory(Inventory inven)
	{
		 mapper.updateInventory(inven);
	}
	
	
	// 보고서 수정
	@Transactional
	public int updateDefect(Defect defect) {
		
		
		//주문 수량, 검수 수량을 조회해서 계산
		Defect originDefect = mapper.findDefectbyDefectNo(defect.getDefectNo());
		System.out.println("기존 defect 테이블 : "+ originDefect);
		System.out.println("detailNo : "+ defect.getDetailNo());
		PrintOrderDetailVO detail = mapper.selectOrderDetailByDetailNo(originDefect.getDetailNo());
		System.out.println("detail 테이블 : "+ detail);
		Inventory inven = inventoryMapper.findInventoryByDefectNo(defect.getDefectNo());
		System.out.println("inventory 테이블 : "+ inven);
		//detail 테이블의 quantity값 변경
		
		
		//발주 개수
		int detailQuantity = detail.getQuantity();

		//품질 이상 개수
		int defectQuantity = originDefect.getQuantity();
		
		//기존 총 발주 개수
		int total = defectQuantity + detailQuantity;
		
		int newDefectQty = defect.getQuantity();
		int gap = newDefectQty - defectQuantity;
		int newDetailQty = detailQuantity - gap;
		
		//기존 발주 개수보다 더 많아지면 오류
		if( newDetailQty < 0)
		{
			System.out.println("발주 수량보다 불량 수량이 많습니다.");
			 throw new IllegalArgumentException("발주 수량보다 불량 수량이 많습니다.");
		}
		
		
		//detail 개수 업데이트
		detail.setQuantity(newDetailQty);
		//가격 수정
		int price = detail.getRegularPrice() * detail.getQuantity();
		detail.setTotalAmount(price);
		
		//detail 값 업데이트
		mapper.updateDetail(detail);
		//inventory의 quantity값 업데이트
		inven.setQuantity(inven.getQuantity() - gap);
		mapper.updateInventory(inven);
		
		
		
	    if (defect.getStatusList() != null && !defect.getStatusList().isEmpty()) {
	        defect.setStatus(String.join(",", defect.getStatusList()));
	    }
	    if (defect.getQuantity() !=  null && defect.getPrice() != null) {
	        defect.setTotalAmount(defect.getQuantity() * defect.getPrice());
	    }
	    return mapper.updateDefect(defect);
	}
	
	// 보고서 삭제
    public int deleteDefect(int defectNo) {
        return mapper.deleteDefect(defectNo);
    }
    // 불량 건수 / 불량률 차트
    public List<Map<String, Object>> selectDefectStats() {
    	return mapper.selectDefectStats();
    }
  
    // bookNo로 북 정보 하나
    public Book selectBook(int bookNo) {
    	return mapper.selectBook(bookNo);
    }
    
    public int countDefect(DefectPagingDTO paging) {
    	return mapper.countDefect(paging);
    }
    public int countAll() {
    	return mapper.countAll();
    }
    
    public Defect findDefectNo()
    {
    	return mapper.findDefectNo();
    }
    public Defect findDefectbyDefectNo(int defectNo)
    {
    	return mapper.findDefectbyDefectNo(defectNo);
    }
    public List<PrintOrderDetailVO> selectOrderDetailByOrderNo(int orderNo)
    {
    	return mapper.selectOrderDetailByOrderNo(orderNo);
    }
    
    
    @Transactional
    public int insertQualityCheck(QualityCheckDTO dto) {
    	
    Integer orderNo = dto.getOrderNo();
    List<PrintOrderDetailVO> details = dto.getDetailList();
    int totalPrice = 0;
    if (dto.getDetailList() == null || dto.getDetailList().isEmpty()) {
        throw new IllegalArgumentException("검수 대상이 없습니다.");
    }
 // ✅ 마지막에 quality_checked 업데이트
    int updated = printOrderMapper.updateQualityChecked(orderNo);
    log.info("✅ 검수 완료 → print_order.quality_checked 업데이트 결과: {}", updated);
    
    boolean exists = mapper.existsByOrderNo(dto.getOrderNo());
    if (exists) {
        log.warn("🚨 중복 검수 시도: orderNo={}", dto.getOrderNo());
        return 0;
    }

    List<PrintOrderDetailVO> vo = mapper.selectOrderDetailByOrderNo(dto.getOrderNo());
    
    int detailNo = 0;
    for (PrintOrderDetailVO detail : dto.getDetailList()) {
    	int orderQty = detail.getQuantity() == null ? 0 : detail.getQuantity();
        int checkQty = detail.getCheckQuantity() == null ? 0 : detail.getCheckQuantity();
        int defectQty = orderQty - checkQty;
       
        if(orderQty<checkQty) return 0;
        
     
        
        Integer clientPrice = detail.getRegularPrice(); // JSP hidden input에서 온 값
        Integer dbPrice = bookMapper.findPriceByBookNo(detail.getBookNo()); // DB 조회 값

        if (dbPrice != null && !dbPrice.equals(clientPrice)) {
            log.warn("[무결성 경고] bookNo={} 클라이언트 price={} DB price={}", 
                      detail.getBookNo(), clientPrice, dbPrice);
            detail.setRegularPrice(dbPrice); // DB 값으로 덮어쓰기
        }
        // 디버깅 로그
        System.out.println("✅ [QC 디버깅] orderNo=" + orderNo
            + ", detailNo=" + detail.getDetailNo()
            + ", bookNo=" + detail.getBookNo()
            + ", orderQty=" + orderQty
            + ", checkQty=" + checkQty
            + ", defectQty=" + defectQty
            + ", defectReason=" + detail.getDefectReason());
        // 1. 품질검수 테이블 기록
        QualityCheck qc = new QualityCheck();
        qc.setOrderNo(dto.getOrderNo());
        qc.setBookNo(detail.getBookNo());
        qc.setInspector("검수팀"); // TODO: 로그인 유저
        qc.setCheckDate(LocalDate.now());
        qc.setCheckQuantity(checkQty);
        qc.setDefectReason(detail.getDefectReason());
        mapper.insertQualityCheck(qc);
        

        // ❌ 불량 반영
        if (defectQty > 0 && detail.getBookNo() != null) {
            Defect defect = new Defect();
            defect.setBookNo(detail.getBookNo());
            defect.setTitle(detail.getProductName());
            defect.setQuantity(defectQty);
            defect.setStatus(detail.getDefectReason());
            defect.setPrintDate(detail.getPrintDate());
            System.out.println("👉 detail.printDate=" + detail.getPrintDate());
            System.out.println("👉 productName=" + detail.getProductName());
            // 가격 보정
            Integer price = detail.getRegularPrice();
            if (price == null) {
                price = bookMapper.findPriceByBookNo(detail.getBookNo()); // DB 값으로 보정
            }
            defect.setPrice(price);
            defect.setTotalAmount(price * defectQty);
            defect.setDefectDate(LocalDate.now());
            defect.setOrderNo(detail.getOrderNo());
            System.out.println("detailNo : "+vo.get(detailNo).getDetailNo());
            defect.setDetailNo(vo.get(detailNo).getDetailNo());
            detailNo++;
            log.warn("⚠️ [Defect Insert 시도] bookNo={}, qty={}, reason={}, price={}",
                     defect.getBookNo(), defect.getQuantity(), defect.getContent(), defect.getPrice());
            mapper.newDefect(defect);
            
        }
        //방금 추가된 defect 찾기
        Defect def = mapper.findDefectNo();
        
        // ✅ 재고 반영
        if (checkQty > 0) {
            Inventory inven = new Inventory();
            inven.setDefectNo(def.getDefectNo());
            inven.setBookNo(detail.getBookNo());
            inven.setActionType("IN");
            inven.setActionDate(LocalDate.now());
            inven.setLocation("창고");
            inven.setContractNo(dto.getOrderNo());
            inven.setQuantity(checkQty);
            inven.setEndContractDate(LocalDate.now().plusMonths(6));
            inventoryMapper.insertInven(inven);
        }
        

        // 💰 재무는 발주수량 기준
        int price = detail.getRegularPrice() == null ? 0 : detail.getRegularPrice();
        totalPrice += orderQty * price;
    }

    //  재무 등록
    int vat = (int)(totalPrice * 0.1);
    int newTotalPrice = totalPrice + vat;

    Financial fi = new Financial();
    fi.setType("EXPENSE");
    fi.setCategory("인쇄비");
    fi.setRelatedNo(dto.getOrderNo());
    fi.setTotalPrice(newTotalPrice);
    fi.setTransactionDate(LocalDate.now());
    fi.setDescription("발주 번호 : " + dto.getOrderNo() + " 인쇄 비용");
    financialMapper.insertFinance(fi);

    //  세금 등록
    Tax tax = new Tax();
    tax.setCategory("VAT");
    tax.setRelatedTable("print_order");
    tax.setRelatedNo(dto.getOrderNo());
    tax.setTaxAmount(vat);
    tax.setTaxRate(10.00);
    tax.setTaxDate(LocalDate.now());
    tax.setDescription("발주번호 " + dto.getOrderNo() + " 매입 세액");
    taxMapper.insertTax(tax);

    
    
    return 1;
}
}
	
	
