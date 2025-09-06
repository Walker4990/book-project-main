<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/evaluation.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<section class="promoCandi">
		<div class="box">
	<h1>진급 대상자 목록</h1><br>
	
	<div class="tableWrapper">
	<table class="table">
		<thead>
		<tr>
			<th>사원 번호</th>
			<th>이름</th>
			<th>부서</th>
			<th>평가 등급</th>
			<th>등록일</th>
		</tr>
		</thead>
		
		<tbody>
		<c:forEach var="promoCandi" items="${promoCandi}">
		<tr>
			<td>${promoCandi.candidateNo}</td>
			<td>${promoCandi.memberName}</td>
			<td>${promoCandi.deptName}</td>
			<td>${promoCandi.grade}</td>
			<td>${promoCandi.registeredAt}</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	</div>
	</section>
		
</body>

</html>