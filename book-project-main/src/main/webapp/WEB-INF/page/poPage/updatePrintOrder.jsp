<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>발주 수정</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h1>발주 수정</h1>

<form action="/updatePrintOrder" method="post" id="updateOrder">
  <input type="hidden" name="orderNo" value="${po.orderNo}" required/>

  <c:forEach var="detail" items="${po.detailList}" varStatus="status">
     <div>
       <input type="hidden" name="detailList[${status.index}].bookNo" value="${detail.bookNo}" required/>

       <label>제품명:</label>
       <input type="text" name="detailList[${status.index}].productName" value="${detail.productName}" id="productName" required/><br>

       <label>발주 수량:</label>
       <input type="number" name="detailList[${status.index}].quantity" value="${detail.quantity}" min="0" id="quantity" required/><br>

       <label>홍보 수량:</label>
       <input type="number" name="detailList[${status.index}].promotionQuantity" value="${detail.promotionQuantity}" min="0" id="promotionQuantity" required/><br>
     </div>
   </c:forEach>

  <div>
    <label>담당자:</label>
    <input type="text" name="manager" value="${po.manager}" id="manager" required/><br>

    <label>발행일자:</label>
    <input type="date" name="issueDate" value="${po.issueDate}" id="issueDate" required/><br>
	
    <label>납품일자:</label>
    <input type="date" name="deliveryDate" value="${po.deliveryDate}" id="deliveryDate" required/><br>
  </div>
  <input type="hidden" name="orderDate" value="${po.orderDate}" required/><br>


  
  

  <button type="submit" id="update">수정</button>
  <button type="button" onclick="location.href='/allPrintOrder'">취소</button>
</form>

<script>
  $("#update").click((e)=>{
    e.preventDefault();
	//만약 값이 null이라면 반환
	const productName = $("#productName").val();
	const quantity = $("#quantity").val();
	const promotionQuantity = $("#promotionQuantity").val();
	const manager = $("#manager").val();
	const issueDate = $("#issueDate").val();
	const deliveryDate = $("#deliveryDate").val();
	
	if(!productName || !quantity|| !promotionQuantity || 
		!manager || !issueDate || !deliveryDate)
		{
			alert("수정할 값이 비어있습니다.");
			return;
		}
	
	
   const formData = $("#updateOrder").serialize(); 

  $.ajax({
    url: "/updatePrintOrder",  // ← 여기에 실제 전송할 URL을 입력
    method: "POST",
    data: formData,
    success: function(result) 
    {
      if(result == "success")
    {
      alert("성공적으로 수정되었습니다!");
	  location.href = "/allPrintOrder";
	  
    }
    else
    {
      alert("수정 실패");
    }
    },
    error: function(xhr, status, error) {
      alert("에러 발생: " + error);
    }
  });
});
</script>

</body>
</html>