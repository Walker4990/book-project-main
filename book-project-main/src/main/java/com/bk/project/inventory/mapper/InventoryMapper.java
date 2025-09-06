package com.bk.project.inventory.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bk.project.inventory.dto.InventoryDTO;
import com.bk.project.inventory.vo.Inventory;


@Mapper
public interface InventoryMapper {
	void insertInven(Inventory vo);
	// 재고 < 출고량 -> 출고 불가
	
	void insertInven(List<Inventory> outList);
	
	List<Inventory> allInven();
	
	List<Inventory> searchInven(InventoryDTO dto);
	
	List<Inventory> searchInvenTest(InventoryDTO dto);
	Inventory findInvenNo(int inventoryNo);
	
	List<Inventory> selectInOnly();
	
	void deleteByBookNo(int bookNo);
	
	void updateInventoryStatus(int inventoryNo, String status);

	int checkInvenByInventoryNo(int inventoryNo);

	List<Map<String, Object>> getInventoryBook();

	void deleteInventory(Integer inventoryNo);
	List<Inventory> searchInventory(InventoryDTO dto);
	List<Inventory> allInventory(InventoryDTO dto);
	int countAllInventory();
	int countInventory(InventoryDTO dto);
	
	Inventory findInventoryByDefectNo(int defectNo);
}

