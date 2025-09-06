<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>출고 수정</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
  <h2>출고 수정</h2>

  <form action="/updateOutInven" method="post" id="updateInven">
    <input type="hidden" name="shipmentNo" id="shipmentNo" value="${shipment.shipmentNo}" />
    <input type="hidden" name="inventoryNo" id="inventoryNo" value="${shipment.inventoryNo}" />
    <input type="hidden" name="bookNo" value="${shipment.bookNo}" />
	
    도서명: <input type="text" name="bookTitle" id="bookTitle" value="${shipment.bookTitle}" required><br>
    현재 위치: <input type="text" name="location" id= "location" value="${shipment.location}" required><br>
    
    출고 수량: <input type="number" name="quantity" id="quantity"value="${shipment.quantity}" min="0" required><br>
    
    출고 단가: <input type="number" name="price" id="price" value="${shipment.price}" min="0" required><br>

    거래처:
    <select name="partnerNo">
      <c:forEach var="p" items="${partnerList}">
        <option value="${p.partnerNo}"
		 <c:if test="${p.partnerNo == shipment.partnerNo}">selected</c:if>>${p.name}</option>
      </c:forEach>
    </select><br>

    운송사:
    <select name="deliveryNo">
      <c:forEach var="d" items="${deliveryList}">
        <option value="${d.deliveryNo}" 
		<c:if test="${d.deliveryNo == shipment.deliveryNo}">selected</c:if>>${d.name}</option>
      </c:forEach>
    </select><br><br>

    <button type="button" id="submitUpdateOutInven">출고 수정</button>
    <button type="button" id ="cancelUpdateOutInven">취소</button>
  </form>
  
  <script>
	$("#submitUpdateOutInven").click((e) =>{
		e.preventDefault();
		const bookTitle = $("#bookTitle").val();
		const location = $("#location").val();
		const quantity = $("#quantity").val();
		const price = $("#price").val();
		if(!bookTitle){
			alert("책 제목을 입력해주세요.");
			return;
		}
		if(!location){
			alert("주소를 입력해주세요.");
			return;
		}
		if(!quantity){
			alert("출고 수량을 입력해주세요.");
			return;
		}
		if(!price){
			alert("출고 수량을 입력해주세요.");
			return;
		}if(parseInt(quantity) < 0){
			alert("출고 수량은 0개 이상부터 가능합니다.");
			return;
		}if(parseInt(price) < 0){
			alert("출고 단가는 0원 이상부터 가능합니다.");
			return;
		}
		const formData = $("#updateInven").serialize(); 
		
		$.ajax({
		     url: "/updateOutInven",  // ← 여기에 실제 전송할 URL을 입력
		     method: "POST",
		     data: formData,
		     success: function(result) 
		     {
		       if(result == "success")
		     {
		       alert("성공적으로 수정되었습니다!");
			   location.href = "/allShipment";
		       
		     }
		     else if(result == "emptyBook")
		     {
		       alert("해당 책은 존재하지 않습니다.");
		     }else if(result == "fail")
			 {
				alert("수정 실패");
			 }
		     },
		     error: function(xhr, status, error) {
		       alert("에러 발생: " + error);
		     }
		   });
	});
	
	$("#cancelUpdateOutInven").click(()=> {
		location.href = "/allShipment";
	})
	
	
	
  </script>
  
  
</body>
</html>