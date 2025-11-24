package com.bk.project.shipment.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.book.mapper.BookMapper;
import com.bk.project.book.vo.Book;
import com.bk.project.contract.mapper.ContractMapper;
import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;
import com.bk.project.inventory.mapper.InventoryMapper;
import com.bk.project.inventory.vo.Inventory;
import com.bk.project.royalty.mapper.RoyaltyMapper;
import com.bk.project.royalty.vo.Royalty;
import com.bk.project.shipment.dto.ShipmentDTO;
import com.bk.project.shipment.mapper.ShipmentMapper;
import com.bk.project.shipment.vo.Shipment;
import com.bk.project.tax.mapper.TaxMapper;
import com.bk.project.tax.vo.Tax;

@Service
public class ShipmentService {

	@Autowired
	private ShipmentMapper mapper;
	@Autowired
	private FinancialMapper financeMapper;
	@Autowired
	private InventoryMapper invenMapper;
	@Autowired
	private TaxMapper taxMapper;
	@Autowired
	private BookMapper bookMapper;
	@Autowired
	private RoyaltyMapper royaltyMapper;
	@Autowired
	private ContractMapper contractMapper;
	
	@Transactional
	public boolean insertShipment(List<ShipmentDTO> list) {
		for(ShipmentDTO dto : list) {
			// 1. 재고 존재 확인
			 System.out.println("▶ inventoryNo: " + dto.getInventoryNo());
			 Inventory inven = invenMapper.findInvenNo(dto.getInventoryNo());

			 if (inven == null) {
				    System.err.println("❌ 출고 실패: inventoryNo [" + dto.getInventoryNo() + "] 해당 재고 없음");
				    return false;
				}
 
             dto.setBookNo(inven.getBookNo());
           
             //2 금액 계산
             int totalPrice= dto.getPrice() * dto.getQuantity();
             dto.setTotalAmount(totalPrice);
             // 3. 출고(shipment) 등록
             mapper.insertShipment(dto);

             // 4. 재고(inventory) 차감
             int affected = mapper.decreaseInven(dto); 
             if (affected == 0) {
                 // 재고 부족 or 동시성 경합 → 전체 트랜잭션 롤백
                 System.err.println("❌ 출고 실패: 재고 부족 또는 경합 - inventoryNo=" + dto.getInventoryNo() +
                                    ", 요청수량=" + dto.getQuantity());
                 throw new IllegalStateException("재고 부족/경합으로 출고 실패");
             }

             LocalDate end = contractMapper.findEndDateByBookNo(dto.getBookNo());
           
             // 5. inventory 테이블에 OUT 이력 등록
             Inventory out = new Inventory();
             out.setBookNo(inven.getBookNo());
             out.setActionType("OUT");
             out.setActionDate(LocalDate.now());
             out.setEndContractDate(end);
             out.setLocation(dto.getLocation());
             out.setQuantity(dto.getQuantity());
             out.setReason("출고 등록");

             invenMapper.insertInven(out);
             
             int vat = (int) (totalPrice * 0.1);
             int newTotalPrice = totalPrice + vat;
             
             // 도서 판매 수익 등록
             Financial fi = new Financial();
             fi.setType("REVENUE");
             fi.setCategory("도서 판매");
             fi.setRelatedNo(dto.getShipmentNo());
             fi.setTotalPrice(newTotalPrice);
             fi.setTransactionDate(LocalDate.now());
             fi.setDescription("출고번호 : " + dto.getShipmentNo() + " 도서 판매 수익");
             financeMapper.insertFinance(fi);
             
             // 세금 등록
             Tax tax = new Tax();
             tax.setCategory("VAT");
             tax.setRelatedTable("shipment");
             tax.setRelatedNo(dto.getShipmentNo());
             tax.setTaxAmount(vat);
             tax.setTaxRate(10.00);
             tax.setTaxDate(LocalDate.now());
             tax.setDescription("출고번호 : " + dto.getShipmentNo() + " VAT 발생");
             taxMapper.insertTax(tax);
             
             
          // 저작권료 등록  
             Integer authorNo = bookMapper.findAuthorNoByBookNo(dto.getBookNo());
             BigDecimal royaltyRate = contractMapper.findRoyaltyRate(dto.getBookNo()); 
             Integer contractNo = contractMapper.findContractNoByBookNo(dto.getBookNo());
             
             if (authorNo != null && royaltyRate != null) {
                 // 총판매금액(부가세 제외 금액 사용 가정: dto.getTotalAmount())
                 BigDecimal total = BigDecimal.valueOf(dto.getTotalAmount());

                 // 인세 = total * (rate / 100)
                 int royaltyAmount = total
                         .multiply(royaltyRate)                   // total * 10.00
                         .divide(BigDecimal.valueOf(100), 0,      // / 100
                                 RoundingMode.DOWN)               // 내림(정책에 맞게 HALF_UP 등 선택)
                         .intValue();

                 Royalty r = new Royalty();
                 r.setAuthorNo(authorNo);
                 r.setBookNo(dto.getBookNo());
                 r.setContractNo(contractNo);
                 r.setTotalSales(dto.getTotalAmount());
                 r.setRoyaltyRate(royaltyRate);
                 r.setRoyaltyPrice(royaltyAmount);
                 r.setRoyaltyDate(LocalDate.now());
                 r.setDescription("출고번호 : " + dto.getShipmentNo() + " 인세 정산");
                 royaltyMapper.insertRoyalty(r);

                 // 6. 저작권료 지출 등록
                 Financial expense = new Financial();
                 expense.setType("EXPENSE");
                 expense.setCategory("저작권료");
                 expense.setRelatedNo(dto.getShipmentNo());
                 expense.setTotalPrice(royaltyAmount);
                 expense.setTransactionDate(LocalDate.now());
                 expense.setDescription("출고번호 : " + dto.getShipmentNo() + " 인세 정산");
                 financeMapper.insertFinance(expense);
             }
		}
		return true;
	}
	
	public List<Shipment> allShipment(ShipmentDTO dto){
		return mapper.allShipment(dto);
	}
	
	public List<Shipment> searchShipment(ShipmentDTO dto){
		return mapper.searchShipment(dto);
	}
	
	public int countAll() {
		return mapper.countAll();
	}
	
	public int countShipment(ShipmentDTO dto) {
		return mapper.countShipment(dto); 
	}
	
	public ShipmentDTO selectShipment(int shipmentNo) {
		return mapper.selectShipment(shipmentNo);
	}
	@Transactional
	public void deleteShipment(int shipmentNo) {
		ShipmentDTO shipment = mapper.selectShipment(shipmentNo);
		
		if(shipment==null) {
			 return;
		}
		
		mapper.increaseInven(shipment.getInventoryNo(), shipment.getQuantity());
		
		mapper.deleteShipment(shipmentNo);
		
	}
	
	@Transactional
	public String updateOutInven(ShipmentDTO in) {
	    // 0) 유효성
	    if (in == null || in.getShipmentNo() == null || in.getQuantity() == null) {
	        return "fail";
	    }

	    // 1) 기존 출고 최소 정보 조회 (조인 없이)
	    ShipmentDTO old = mapper.selectShipment(in.getShipmentNo());
	    if (old == null) return "notFound";

	    // 필수 키/메타 세팅
	    in.setInventoryNo(old.getInventoryNo());
	    in.setBookNo(old.getBookNo());

	    // 2) Δ(증감량) 계산 : 출고↑(+) / 출고↓(-)
	    final int oldQty = old.getQuantity();
	    final int newQty = in.getQuantity();
	    final int delta  = newQty - oldQty;
	    in.setEditQuantity(delta);

	    // 3) 출고 행 업데이트 (shipment_no + inventory_no 조건)
	    int upd = mapper.editOutInven(in);
	    if (upd == 0) return "fail";

	    // 4) 재고 반영(원자적) : quantity = quantity - delta, 음수 방지
	    if (delta != 0) {
	        int affected = mapper.updateInventoryQuantity(in); 
	        if (affected == 0) return "out_of_stock";
	    }

	    // 5) 정정분(Δ) 재무/세금/저작권료 — Δ가 0이면 스킵
	    if (delta != 0) {
	        // (a) 금액 계산(부가세 제외 diff)
	        int unitPrice  = old.getPrice();           // 기존 단가 기준
	        int diffAmount = unitPrice * delta;        // ± 가능
	        int vat        = (int) Math.floor(diffAmount * 0.1);
	        int totalIncl  = diffAmount + vat;

	        // (b) 메타 1쿼리: author_no / contract_no / royalty_rate
	        Map<String, Object> meta = mapper.getBookMeta(in.getBookNo());
	        Integer authorNo      = (Integer) meta.get("author_no");         // null 가능
	        Integer contractNo    = (Integer) meta.get("contract_no");       // null 가능
	        BigDecimal royaltyRate = meta.get("royalty_rate") == null ? null : (BigDecimal) meta.get("royalty_rate");
/*
			Integer authorNo = mapper.getAuthorNoByBookNo(bookNo);
			Integer contractNo = mapper.getContractNoByBookNo(bookNo);
			BigDecimal royaltyRate = mapper.getRoyaltyRateByBookNo(bookNo);
*/
	        // (c) 재무 정정(수익)
	        Financial fi = new Financial();
	        fi.setType("REVENUE");
	        fi.setCategory("도서 판매");
	        fi.setRelatedNo(in.getShipmentNo());
	        fi.setTotalPrice(totalIncl);
	        fi.setTransactionDate(LocalDate.now());
	        fi.setDescription("출고 수정 (shipmentNo=" + in.getShipmentNo() + ")");
	        financeMapper.insertFinance(fi);

	        // (d) VAT 정정
	        Tax tax = new Tax();
	        tax.setCategory("VAT");
	        tax.setRelatedTable("shipment");
	        tax.setRelatedNo(in.getShipmentNo());
	        tax.setTaxAmount(vat);
	        tax.setTaxRate(10.00);
	        tax.setTaxDate(LocalDate.now());
	        tax.setDescription("출고 수정 (shipmentNo=" + in.getShipmentNo() + ") VAT 정정");
	        taxMapper.insertTax(tax);

	        // (e) 저작권료 정정 (메타 있을 때만)
	        if (authorNo != null && royaltyRate != null) {
	            int royaltyAmount = BigDecimal.valueOf(diffAmount)
	                    .multiply(royaltyRate)
	                    .divide(BigDecimal.valueOf(100), 0, RoundingMode.DOWN)
	                    .intValue();

	            Royalty r = new Royalty();
	            r.setAuthorNo(authorNo);
	            r.setBookNo(in.getBookNo());
	            r.setContractNo(contractNo);
	            r.setTotalSales(diffAmount);
	            r.setRoyaltyRate(royaltyRate);
	            r.setRoyaltyPrice(royaltyAmount);
	            r.setRoyaltyDate(LocalDate.now());
	            r.setDescription("출고 수정 (shipmentNo=" + in.getShipmentNo() + ") 인세 정정");
	            royaltyMapper.insertRoyalty(r);

	            // 인세 지출(정정)
	            Financial expense = new Financial();
	            expense.setType("EXPENSE");
	            expense.setCategory("저작권료");
	            expense.setRelatedNo(in.getShipmentNo());
	            expense.setTotalPrice(royaltyAmount);
	            expense.setTransactionDate(LocalDate.now());
	            expense.setDescription("출고 수정 (shipmentNo=" + in.getShipmentNo() + ") 인세 정정");
	            financeMapper.insertFinance(expense);
	        }
	    }

	    return "success";
	}
	@Transactional  // ← 이 메서드 전체가 1개의 트랜잭션 = 커밋 1회
	public String updateOutInvenBulk(List<ShipmentDTO> list) {
	    if (list == null || list.isEmpty()) return "fail";

	    for (ShipmentDTO in : list) {
	        // 기존 단건 메서드를 재사용 (메서드/변수명 변경 없음)
	        String res = updateOutInven(in);

	        // 단건이 실패/재고부족 등이면 전체 롤백시키기 위해 예외 던짐
	        if (!"success".equals(res)) {
	            throw new RuntimeException("bulk fail: " + res);
	        }
	    }
	    return "success"; // 모두 성공하면 커밋 1회
	}
	
	public ShipmentDTO getShipmentByInvenNo(int inventoryNo) {
		return mapper.getShipmentByInvenNo(inventoryNo);
	}
	public void increaseInventory(int inventoryNo, int quantity) {
	    mapper.increaseInven(inventoryNo, quantity);
	}
	public Integer findPriceByInventoryNo(int inventoryNo) {
		return mapper.findPriceByInventoryNo(inventoryNo);
	}
	


}
