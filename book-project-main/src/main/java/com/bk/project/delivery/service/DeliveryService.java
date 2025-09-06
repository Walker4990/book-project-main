package com.bk.project.delivery.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bk.project.delivery.dto.DeliveryPagingDTO;
import com.bk.project.delivery.mapper.DeliveryMapper;
import com.bk.project.delivery.vo.Delivery;
import com.bk.project.financial.mapper.FinancialMapper;
import com.bk.project.financial.vo.Financial;

@Service
public class DeliveryService {

	@Autowired
	private DeliveryMapper mapper;
	@Autowired
	private FinancialMapper financeMapper;
	
	@Transactional
	public int newDelivery(Delivery delivery) 
	{
		Delivery delivelyNo = mapper.getDeliveryCompanyByNo(delivery);
		if(delivelyNo != null)
		{
			System.out.println("이미 해당 업체가 존재합니다.");
			return -3;
		}
		System.out.println(delivery);
		//업체명, 계약날짜, 계약금으로 찾기
		int result = mapper.newDelivery(delivery);
		Delivery insertFinancial = mapper.getDeliveryCompanyByNo(delivery);
		
		Financial fi = new Financial();
		fi.setType("EXPENSE");
		fi.setCategory("마케팅 비용 지급");
		fi.setRelatedNo(insertFinancial.getDeliveryNo());
		fi.setTotalPrice(insertFinancial.getContractAmount());
		fi.setTransactionDate(LocalDate.now());
		fi.setDescription("마케팅 비용 : " + insertFinancial.getDeliveryNo() + " 마케팅 비용 납부");
		financeMapper.insertFinance(fi);
		return result;
		
	}
	
	public List<Delivery> allDelivery(){
		return mapper.allDelivery();
	}
	
	public List<Delivery> allDeliveryShipment()
	{
		return mapper.allDeliveryShipment();
	}


	public List<Delivery> searchDelivery(DeliveryPagingDTO  dto) {
		
		return mapper.searchDelivery(dto);
	}

	
	public int deleteDelivery(int deliveryNo) {
		return mapper.deleteDelivery(deliveryNo);
	}

	public int updateDelivery(Delivery delivery) {
	  return mapper.updateDelivery(delivery);
	}



	public Delivery getDeliveryByNo(Integer deliveryNo) {
		return mapper.getDeliveryByNo(deliveryNo);
	}
	
	public int countDelivery(DeliveryPagingDTO paging) {
		return mapper.countDelivery(paging);
	}


	


}
