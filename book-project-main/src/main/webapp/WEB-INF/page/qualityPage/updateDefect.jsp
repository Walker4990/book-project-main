<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<section>
    <h1>품질 검사 보고서 수정</h1>

    <form method="post" action="/updateDefect" id="updateForm">
      품질 보고 번호 :
      <input
        type="text"
        name="defectNo"
        value="${defect.defectNo}"
        readonly
      /><br />
      도서명 :
      <input type="text" name="title" value="${defect.title}" readonly /><br />
      인쇄 날짜 : <input type="date" name="printDate""
      value="${defect.printDate}" readonly /><br />
      품질 상태 :
	  <input type="checkbox" name="status" value="인쇄 불량"
	  	  ${defect.status.contains("인쇄 불량") ? "checked" : ""}/> 인쇄 불량

	  <input type="checkbox" name="status" value="오타"
	  	  ${defect.status.contains("오타") ? "checked" : ""}/> 오타

	  <input type="checkbox" name="status" value="찢어짐"
	  	  ${defect.status.contains("찢어짐") ? "checked" : ""}/> 찢어짐<br />
		  
      상세 설명 :
      <br>
      <textarea id="defectContent" cols="70" name="content" rows="5">${defect.content}</textarea><br>
      수량:
      <input type="number" name="quantity" value="${defect.quantity}" /><br>
      단가 :
      <input type="number" name="price" value="${defect.price}" readonly /><br>  
      총 가격 :
      <input
        type="number"
        id="totalAmount"
        name="totalAmount"
        value="${defect.totalAmount}" readonly/><br />
	  등록 날짜 : <input type="date" id="defectDate" name="defectDate" value="${defect.defectDate}"><br>
      
	  <button type="submit">수정 완료</button>
	  
   </form>
   </section>
   
   <script>
	// 등록 시 품질상태 체크 확인
	  $("#updateForm").on("submit", function (e) {
	    const statusChecked = $("input[name='status']:checked").length > 0;
	    if (!statusChecked) {
	      alert("품질 상태를 최소 한 개 이상 선택해주세요.");
	      e.preventDefault();
	    } else {
	      alert("등록 완료");
	    }
	  });
   </script>
  </body>
</html>
