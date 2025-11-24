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
