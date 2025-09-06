package com.bk.project.shipment.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.book.service.BookService;
import com.bk.project.book.vo.Book;
import com.bk.project.delivery.service.DeliveryService;
import com.bk.project.delivery.vo.Delivery;
import com.bk.project.financial.service.FinancialService;
import com.bk.project.inventory.service.InventoryService;
import com.bk.project.inventory.vo.Inventory;
import com.bk.project.partner.service.PartnerService;
import com.bk.project.partner.vo.Partner;
import com.bk.project.shipment.dto.ShipmentDTO;
import com.bk.project.shipment.service.ShipmentService;
import com.bk.project.shipment.vo.Shipment;

@Controller
public class ShipmentController {

	@Autowired
	private ShipmentService service;
	
	@Autowired
	private InventoryService invenService;
	
	@Autowired
	private DeliveryService deliveryService;
	
	@Autowired
	private PartnerService partnerService;
	
	@Autowired
	private FinancialService financialService;
	
	@Autowired
	private BookService bookService;
	
	@GetMapping("/newOutInven")
	public String bookList(Model model ) {
		List<Inventory> invenList = invenService.selectInOnly();
		List<Partner> partnerList = partnerService.allPartner();
		List<Delivery> deliveryList = deliveryService.allDeliveryShipment();
		model.addAttribute("invenList", invenList);
		model.addAttribute("partnerList", partnerList);
		model.addAttribute("deliveryList", deliveryList);
		model.addAttribute("page", "shipmentPage/newOutInven.jsp");
		
		return "common/layout";
	}
	
	@ResponseBody
	@PostMapping("/newOutInven")
	public String insertShipment(@RequestBody List<ShipmentDTO> outList) {
	    for (ShipmentDTO dto : outList) {
	        System.out.println(">>> inventoryNo: " + dto.getInventoryNo());
	    }

	    try {
	        boolean result = service.insertShipment(outList);

	        if (!result) {
	            // ❌ 서비스 단에서 false → 재고 부족 같은 케이스라고 가정
	            return "out_of_stock";
	        }

	        return "success";

	    } catch (Exception e) {
	        System.err.println("❌ 출고 등록 중 오류: " + e.getMessage());
	        return "error";
	    }
	}
	@GetMapping("/allShipment")
	public String allShipment(Model model, ShipmentDTO paging) {

		int total;
		if(paging.getKeyword() !=null && !paging.getKeyword().isEmpty()) {
			total = service.countShipment(paging);
		} else {
			total = service.countAll();
		}
		
		ShipmentDTO fixedPaging = new ShipmentDTO(paging.getPage(), total);
		fixedPaging.setKeyword(paging.getKeyword());
		fixedPaging.setSelect(paging.getSelect());
		
		List<Shipment> shipmentList;
		if(paging.getKeyword()!=null && !paging.getKeyword().isEmpty()) {
			shipmentList = service.searchShipment(fixedPaging);
		} else {
			shipmentList = service.allShipment(fixedPaging);
		}
		model.addAttribute("shipmentList", shipmentList);
		model.addAttribute("invenList", invenService.selectInOnly());
		model.addAttribute("partnerList", partnerService.allPartner());
		model.addAttribute("deliveryList", deliveryService.allDeliveryShipment());
		model.addAttribute("page", "shipmentPage/allShipment.jsp");
		model.addAttribute("paging", fixedPaging);
		model.addAttribute("param", paging);
		return "common/layout";
	}
	
	@GetMapping("/deleteShipment")
	public String deleteShipment(int shipmentNo, Model model) {
		ShipmentDTO dto = service.selectShipment(shipmentNo);
		service.deleteShipment(shipmentNo);
		model.addAttribute("page", "shipmentPage/allShipment.jsp");
		return "redirect:/allShipment";
	}
	
	@GetMapping("/updateOutInven")
	public String updateOutInven(int shipmentNo, Model model) {
		ShipmentDTO shipment = service.selectShipment(shipmentNo);
		model.addAttribute("shipment", shipment);
		model.addAttribute("partnerList", partnerService.allPartner()); 
		model.addAttribute("deliveryList", deliveryService.allDelivery());
		model.addAttribute("page", "shipmentPage/updateOutInven.jsp");
		return "common/layout";
	}
	
	@ResponseBody
	@PostMapping("/updateOutInven")
	public String updateOutInven(ShipmentDTO dto) {
		//해당 책일 실제로 있는지 찾기
		   System.out.println("[updateOutInven] DTO = " + dto);

		

		    return service.updateOutInven(dto);
		
}
	// 기존 컨트롤러에 추가 (기존 단건 API는 그대로 유지)
	@PostMapping("/updateOutInven/bulk")
	@ResponseBody
	public String updateOutInvenBulk(@RequestBody List<ShipmentDTO> list) {
	    return service.updateOutInvenBulk(list);
	}
	@GetMapping("/getBookPrice")
	@ResponseBody
	public Integer getBookPrice(int inventoryNo) {
	    // InventoryNo → Book 단가 조회
	    return service.findPriceByInventoryNo(inventoryNo);
	}
	
	@ResponseBody
	@GetMapping("/getShipment")
	public ShipmentDTO getShipment(int shipmentNo) {
		   System.out.println("조회 요청 shipmentNo = " + shipmentNo);
		return service.selectShipment(shipmentNo);
		
	}
}
 