package com.bk.project.inventory.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.inventory.dto.InventoryDTO;
import com.bk.project.inventory.mapper.InventoryMapper;
import com.bk.project.inventory.vo.Inventory;

@Service
public class InventoryService {

	@Autowired
	private InventoryMapper mapper;
	
	public void insertInven(Inventory vo) {
		
		mapper.insertInven(vo);
	}
	
	
//	public boolean insertInven(List<Inventory> outList) {
//	    for (Inventory inven : outList) {
//	        try {
//	            // 1. 현재 재고 확인
//	            int status = mapper.checkInven(inven.getBookNo());
//	            int quantity = inven.getQuantity();
//
//	            System.out.println(">> 받은 bookNo = " + inven.getBookNo());
//	            System.out.println(">> checkInven 조회 결과 = " + status);
//	            
//	            System.out.println(">> 출고 요청 도서번호: " + inven.getBookNo());
//	            System.out.println(">> 현재 재고량: " + status + ", 출고 요청 수량: " + quantity);
//
//	            // 2. 재고 부족 시 실패 처리
//	            if (status < quantity) {
//	                System.out.println(">> 재고 부족으로 출고 실패");
//	                return false;
//	            }
//
//	            // 3. 출고 처리
//	            inven.setActionType("OUT");
//	            inven.setActionDate(LocalDate.now());
//
//	            // 4. 출고 등록
//	            mapper.insertInven(inven);
//	            System.out.println(">> 출고 등록 성공");
//	        } catch (Exception e) {
//	            System.out.println(">> 출고 등록 중 예외 발생: " + e.getMessage());
//	            e.printStackTrace();
//	            return false;
//	        }
//	    }
//
//	    return true;
//	}
	
	
	public List<Inventory> allInven(){
		return mapper.allInven();
		
	}
	public List<Inventory> searchInven(InventoryDTO dto){
		return mapper.searchInven(dto);
	}
	
	public List<Inventory> searchInvenTest(InventoryDTO dto)
	{
		return mapper.searchInvenTest(dto);
	}
	
	public List<Inventory> selectInOnly(){
		return mapper.selectInOnly();
	}
	public Inventory findInvenNo(int inventoryNo) {
		return mapper.findInvenNo(inventoryNo);
	}
	
	public List<Map<String, Object>> getInventoryBook(){
		return mapper.getInventoryBook();
	}
	
	// 클레임 수정에서 수정 완료 버튼을 누르면 재고 현황에 반품 재고 추가하기
	public List<Inventory> allInventory(InventoryDTO paging) {
	    return mapper.allInventory(paging);
	}
	public int countAllInventory() {
	    return mapper.countAllInventory();
	}
	public List<Inventory> searchInventory(InventoryDTO paging) {
	    return mapper.searchInventory(paging);
	}
	public int countInventory(InventoryDTO paging) {
	    return mapper.countInventory(paging);
	}
	public Inventory findInventoryByDefectNo(int defectNo)
	{
		return mapper.findInventoryByDefectNo(defectNo);
	}


	
	
	
}