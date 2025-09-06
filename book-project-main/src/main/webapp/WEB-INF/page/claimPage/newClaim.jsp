<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
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
	
	<section class="claimBox">
    <h1>클레임 등록</h1>
    <form action="/newClaim" method="post" id="claimForm">
		<div class="form-section">
		  <label class="label" for="partnerSelect">업체명</label>
		  <select name="partnerNo" id="partnerSelect" required>
		    <c:forEach var="partner" items="${partnerList}">
		      <option value="${partner.partnerNo}">${partner.name}</option>
		    </c:forEach>
		  </select> <br>

		  <label class="label" for="bookSelect">도서명</label>
		  <select name="bookNo" id="bookSelect" required>
		    <c:forEach var="book" items="${bookList}">
		      <option value="${book.bookNo}" data-price="${book.price}">
		        ${book.title}
		      </option>
		    </c:forEach>
		  </select> <br>

		  <label class="label">가격 :</label>
		  <input type="text" id="price" name="price" readonly />
	  수량 : <input type="number" id="quantity" name="quantity" min="0" required>
	  총 금액 : <input type="number" id="totalAmount" name="totalAmount" readonly><br>
     
	   
	  클레임 유형 : 
	  <input type="checkbox" name="defectType" value="인쇄 불량">
	  <label for="printingDefect">인쇄 불량</label>
	  <input type="checkbox" name="defectType" value="오타" />
	  <label for="typo">오타</label>
	  <input type="checkbox" name="defectType" value="찢어짐" />
	  <label for="torn">찢어짐</label><br />
      클레임 내용 : 
	  <br>
      <textarea id="claimContent" name="content" Cols="70" rows="5" placeholder="내용을 입력하세요" required></textarea><br />
	  회수 가능 여부 : 
	  <input type="radio" name="recall" value="회수가능" id="recallY" />
	  <label for="recallY">회수가능</label>
	  <input type="radio" name="recall" value="회수불가능" id="recallN" />
	  <label for="recallN">회수불가</label><br>
	  회수 상태 : 
	  <select name="recallStatus" required>
	  <option value="접수중" ${claim.recallStatus == '접수중' ? 'selected' : ''}>접수중</option>
	  <option value="처리중" ${claim.recallStatus == '처리중' ? 'selected' : ''}>처리중</option>
	  <option value="완료" ${claim.recallStatus == '완료' ? 'selected' : ''}>완료</option>
	  </select><br>
	  등록 날짜 : <input type="date" name="claimDate" required><br >
     
      <input type="submit" id="submit" value="등록" />
    </div>
    </form>
	</section>
	
	<script>
		     $("#claimForm").on("submit", function (e) {
		       // 체크박스 최소 하나 선택 확인
		       const defectChecked = $("input[name='defectType']:checked").length > 0;
			   const recallChecked = $("input[name='recall']:checked").length > 0;

		       if (!defectChecked) {
		         alert("클레임 유형을 최소 한 개 이상 선택해주세요.");
		         e.preventDefault(); // 제출 막기
		         return;
		       } else if (!recallChecked) {
				alert("회수 가능 여부를 선택해주세요.")
				e.preventDefault();
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
