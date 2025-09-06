<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>발주서 등록 페이지</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
    
    <h1>신규 발주서 등록</h1>
    <div>
      발주 일자 :
      <input type="date" id="orderDate" name="orderDate" required/><br />
      담당자 :
      <input
        type="text"
        id="manager"
        name="manager"
        placeholder="담당자 이름"
      required /><br />
      납품일자 :
      <input type="date" id="deliveryDate" name="deliveryDate" required  /><br />
      발행 일자 :
      <input type="date" id="issueDate" name="issueDate" required/><br />
      구분 : 
	  <select id="category" name="category" required>
		<option>도서</option>
		<option>비도서</option>
	  </select>
	
	  
	  <table border="1">
	     <thead>
	       <tr>
	         <th>제품명</th>
	         <th>정가</th>
	         <th>수량</th>
			 <th>총 금액</th>
	         <th>홍보 부 수</th>
	         <th>삭제</th>
	       </tr>
	     </thead>
		 <tbody id="detailBody">
		   <tr>
		     <td>
		       <select class="bookSelect" required>
				<option value="">-- 선택 --</option>
				<c:forEach var="book" items="${bookList}">
				  <option value="${book.bookNo}">${book.title}</option>
				</c:forEach>
		       </select>
		     </td>
		     <td><input type="number" class="regularPrice"  required /></td>
		     <td><input type="number" class="quantity" required /></td>
			 <td><input type="number" class="totalAmount" readonly></td>
		     <td><input type="number" class="promotionQuantity" /></td>
		     <td><button type="button" class="delRow">삭제</button></td>
		   </tr>
		 </tbody>
	   </table>

	   <br/>
	   <button type="button" id="addRow">행 추가</button>
	   <button type="button" id="poBtn">등록</button>
	   <button type="button" id="cancel">취소</button>
	  
    </div>
	
	
	<script>
		const bookMap = {
		  <c:forEach var="book" items="${bookList}" varStatus="vs">
		    "${book.bookNo}": ${book.price}<c:if test="${!vs.last}">,</c:if>
		  </c:forEach>
		};
	  // 행 추가 버튼 클릭 시
	  $("#addRow").click(() => {
		const newRow = `
		  <tr>
		    <td>
		      <select class="bookSelect" required>
		        ` + $("#detailBody select.bookSelect:first").html() + `
		      </select>
		    </td>
		    <td><input type="number" class="regularPrice" required /></td>
		    <td><input type="number" class="quantity" required/></td>
			<td><input type="number" class="totalAmount" readonly/></td>
		    <td><input type="number" class="promotionQuantity" required /></td>
		    <td><button type="button" class="delRow">삭제</button></td>
		  </tr>`;
		  // 추가 항목들 추가된 행에 추가
	    $("#detailBody").append(newRow);
	  });

	  // 삭제 버튼 클릭 시 해당 행 제거
	  //$(부모요소).on("이벤트", "대상선택자", function() { ... });
	  $(document).on("click", ".delRow", function () {
		const rowCount = $("#detailBody tr").length;
		 if (rowCount > 1) {
		   $(this).closest("tr").remove();
		 } else {
		   alert("최소 1개의 발주 항목은 유지해야 합니다.");
		 }
	  });
	
	  //정가 입력
	  $(document).on("change",".bookSelect", function(){
		const bookNo = $(this).val();
		  const price = bookMap[bookNo] || 0;
		  const row = $(this).closest("tr");
		  row.find(".regularPrice").val(price).trigger("input");
	  })
	  
	  //$(document) - HTML 전체문서 , 동적으로 추가된 요소에도 이벤트 바인딩 가능
	  // $(this) - 현재 이벤트(클릭)에만 동작하기 위해 사용
	  
	  // 취소 버튼
	  $("#cancel").click(() => {
	    location.href = "/main";
	  });

	  // 등록 버튼
	  $("#poBtn").click(() => {
	    let isValid = true;
		
		let allValid = true;
		$("input:required, select:required").each(function () {
		  if (!this.checkValidity()) {
		    this.reportValidity(); // 브라우저 기본 오류 표시
		    allValid = false;
		    return false; // break
		  }
		});
		if (!allValid) return;
	    // 수량 유효성 검사
	    $(".quantity").each(function () {
	      if (parseInt($(this).val()) < 0) {
	        alert("수량은 0 이상이어야 합니다.");
	        isValid = false;
	        return false;
	      }
	    });

	    // 홍보 부수 유효성 검사
	    $(".promotionQuantity").each(function () {
	      if (parseInt($(this).val()) < 0) {
	        alert("홍보 부수는 0 이상이어야 합니다.");
	        isValid = false;
	        return false;
	      }
	    });

	    if (!isValid) return; // 유효성 실패 시 AJAX 중단

	    const data = {
	      orderDate: $("#orderDate").val(),
	      manager: $("#manager").val(),
	      deliveryDate: $("#deliveryDate").val(),
	      issueDate: $("#issueDate").val(),
	      category: $("#category").val(),
	      detailList: []
	    };
		if(orderDate && deliveryDate && orderDate > deliveryDate){
			alert("발주일을 납품일자보다 빨라야합니다.")
			return;
		}
		if (deliveryDate && issueDate && issueDate > deliveryDate) {
		  alert("발행일은 납품일보다 빠르거나 같아야 합니다.");
		  return;
		}
		if(orderDate && issueDate && orderDate > issueDate){
			alert("발주일은 발행일보다 빨라야합니다.")
			return;
		}
		

	    //$("selector").each() -> jQuery 반복문
	    // $(selector).each(function(index, element) {
	    // index: 현재 순서 (0부터 시작)
	    // element: 현재 순회 중인 요소 (DOM 객체)
	    // 여기서 row는 <tr> 요소 하나, index는 그 순번
	    $("#detailBody tr").each((_, row) => {
			
	      const detail = {
	        bookNo: $(row).find(".bookSelect").val(),
			productName: $(row).find(".bookSelect option:selected").text(),
	        regularPrice: $(row).find(".regularPrice").val(),
	        quantity: $(row).find(".quantity").val(),
	        promotionQuantity: $(row).find(".promotionQuantity").val()
	      };
	      data.detailList.push(detail);
	    });
	    // $(row) -

	    $.ajax({
	      type: "POST",
	      url: "/newPrintOrder",
	      contentType: "application/json", // JSON 전송 명시
	      data: JSON.stringify(data), // JS 객체 → JSON 문자열
	      success: function (result) {
	        if (result === "success") {
	          alert("발주 등록 완료");
	          location.href = "/allPrintOrder";
	        } else {
	          alert("등록 실패");
	        }
	      },
	      error: function () {
	        alert("서버 오류 발생");
	      }
	    });
	  });
	  // 정가, 수량 입력 시 총 금액 자동 계산
	  $(document).on("input", ".regularPrice, .quantity", function () {
	    const row = $(this).closest("tr");
	    const price = parseInt(row.find(".regularPrice").val()) || 0;
	    const quantity = parseInt(row.find(".quantity").val()) || 0;
	    row.find(".totalAmount").val(price * quantity);
	  });
	  
	</script>
  </body>
</html>