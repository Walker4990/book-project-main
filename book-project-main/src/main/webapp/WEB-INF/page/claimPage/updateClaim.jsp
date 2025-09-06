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
    <h1>클레임 수정</h1>
   <form action="/updateClaim" method="post">
	
	클레임 번호 : 
	<input type="number" name="claimNo" value="${claim.claimNo}" readonly ><br>
	
	업체명 : 
	<input type="text" name="name" value="${claim.name}" readonly ><br>
	
	<input type="hidden" name="bookNo" value="${claim.bookNo}" />
	
	도서명 : 
	<input type="text" name="title" value="${claim.title}" readonly ><br>
	가격 : 
	<input type="number" name="price" value="${claim.price}" readonly ><br>
	
	수량 : 
	<input type="number" name="quantity" value="${claim.quantity}" ><br>
	
	총 금액 : 
	<input type="number" name="totalAmount" value="${claim.totalAmount}" ><br>
	
	제품 상태 : 
	<input type="checkbox" name="defectTypeList" value="인쇄 불량"
	  ${claim.defectTypeList.contains("인쇄 불량") ? "checked" : ""}/> 인쇄 불량

	<input type="checkbox" name="defectTypeList" value="오타"
	  ${claim.defectTypeList.contains("오타") ? "checked" : ""}/> 오타

	<input type="checkbox" name="defectTypeList" value="찢어짐"
	  ${claim.defectTypeList.contains("찢어짐") ? "checked" : ""}/> 찢어짐<br />
	  
	클레임 내용 : 
	<br>
	<textarea id="claimContent" name="content" Cols="70" rows="5">${claim.content}</textarea><br />
	
	회수 가능 여부 : 
	<input type="radio" name="recall" value="회수가능"
	  ${claim.recall == '회수가능' ? 'checked' : ''} /> 회수가능
	<input type="radio" name="recall" value="회수불가능"
	  ${claim.recall == '회수불가능' ? 'checked' : ''} /> 회수불가능<br>
	회수 상태 : 
	<select name="recallStatus">
	  <option value="접수중" ${claim.recallStatus == '접수중' ? 'selected' : ''}>접수중</option>
	  <option value="처리중" ${claim.recallStatus == '처리중' ? 'selected' : ''}>처리중</option>
	  <option value="완료" ${claim.recallStatus == '완료' ? 'selected' : ''}>완료</option>
	</select><br>
	등록 날짜 :  <input type="date" name="claimDate" value="${claim.claimDate}"><br>
	
	<button type="submit">수정 완료</button>
	
	</form>
  </body>
</html>
