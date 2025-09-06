package com.bk.project.shipment.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.shipment.dto.ShipmentDTO;
import com.bk.project.shipment.vo.Shipment;

@Mapper
public interface ShipmentMapper {
	void insertShipment(ShipmentDTO dto);
	// 페이징 처리
	List<Shipment> allShipment(ShipmentDTO dto);
	List<Shipment> searchShipment(ShipmentDTO dto);
	
	int countAll();
	int countShipment(ShipmentDTO dto);
	
	Map<String, Object> getBookMeta(int bookNo);
	
	int decreaseInven(ShipmentDTO dto);
	
	void deleteShipment(int shipmentNo);
	
	void increaseInven(int inventoryNo, int quantity);
	
	ShipmentDTO selectShipment(int shipmentNo);
	
	void insertInvenOut(ShipmentDTO dto);
	
	int editOutInven(ShipmentDTO dto);
	
	ShipmentDTO getShipmentByInvenNo(int inventoryNo);
	
	int updateInventoryQuantity(int inventoryNo, int editQuantity);
	
	int updateInventoryQuantity(ShipmentDTO newOut);
	
	Integer findPriceByInventoryNo(int inventoryNo);
	int checkInven(int inventoryNo);
}
