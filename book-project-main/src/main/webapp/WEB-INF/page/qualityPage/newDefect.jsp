<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
    
    <form action="/newDefect" method="post" id= defectForm>
		
	<div class="form-section">
	<h1>품질 검수 보고 등록</h1>
	
	<div class="input">
	<label class="label" for="bookSelect">도서명</label>
	<select name="bookNo" id="bookSelect" required>
	  <c:forEach var="book" items="${bookList}">
		<option value="${book.bookNo}" data-price="${book.price}">${book.title}</option>
	  </c:forEach>
	</select>
		  
      인쇄 날짜 : <input type="date" id="printDate" name="printDate" required><br>
	 </div>
	  
	  <div class="status">
      품질 상태 :
      <input type="checkbox" name="status" value="인쇄 불량">
      <label for="printingdefect">인쇄 불량</label>
      <input type="checkbox" name="status" value="오타">
      <label for="typo">오타</label>
      <input type="checkbox" name="status" value="찢어짐">
      <label for="torn">찢어짐</label><br>
	  </div>
	  
	  <div class="input">
      상세 설명 :
      <br><textarea name="content" Cols="70" rows="5" placeholder="내용을 입력하세요" required></textarea><br>
	  </div>
	  
	  <div class="input">
      수량 : <input type="number" id="quantity" name="quantity" min="0" required>
	
      단가 : <input type="text" id="price" name="price" readonly>
	 
      총 가격 : <input type="number" id="totalAmount" name="totalAmount" readonly><br>
	  </div>
	  
	  <div class="input">
	  등록 날짜 : <input type="date" name="defectDate" required><br>
	  </div>

	  <div class="submit">
      <input type="submit" id="submit" value="등록">
	  </div>
	  
	  </div>
    </form>
	
	<script>
		
	     $("#defectForm").on("submit", function (e) {
	       // 체크박스 최소 하나 선택 확인
	       const statusChecked = $("input[name='status']:checked").length > 0;

	       if (!statusChecked) {
	         alert("품질 상태를 최소 한 개 이상 선택해주세요.");
	         e.preventDefault(); // 제출 막기
	         return;
	       }

	       alert("등록 완료");
	     });
		 
		 selectBook(1);
		 
		 $('#bookSelect').change(function() {
			selectBook($(this).val());
		 })
		 
		 function selectBook(bookNo) {
			$.ajax({
				url: '/selectBook',
				type: 'get',
				data: {bookNo},
				success: function(data) {
					
					$('#price').val(data.price);
				}
			})
		 }
		 
		 $('#quantity').on('input', function() {
			$('#totalAmount').val($(this).val() * $('#price').val());
		 })
	   </script>
	
  </body>
</html>
