package com.bk.project.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bk.project.delivery.dto.DeliveryPagingDTO;
import com.bk.project.delivery.vo.Delivery;

@Mapper
public interface DeliveryMapper 
{
	int newDelivery(Delivery delivery);
	List<Delivery> searchDelivery(DeliveryPagingDTO dto);
	List<Delivery> allDelivery();
	List<Delivery> allDeliveryShipment();
	
	int deleteDelivery(int deliveryNo);
	int updateDelivery(Delivery delivery);
	Delivery getDeliveryByNo(int deliveryNo);
	
	
	int countDelivery(DeliveryPagingDTO paging);
	Delivery getDeliveryCompanyByNo(Delivery delivery);

	
	
}
