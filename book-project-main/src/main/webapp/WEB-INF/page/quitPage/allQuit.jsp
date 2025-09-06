<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>퇴사사원 관리</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<section class="quit">
		<div class="box">
			
			<h1>퇴사한 사원 검색</h1><br>

			<form class="searchForm" action="/allQuit" method="get">
			<div class="form-inline">
			<input type="text" name="keyword" value="${param.keyword}" placeholder="사원정보를 입력해주세요.">
					
			<div class="btn-wrap">
			<button type="submit" value="조회" class="btnNavy">조회</button>
			</div>
			</div>
		</form>		
			
			
	<h1>퇴사 사원 조회</h1><br>
	
	<div class="tableWrapper">
	   <table class="table">
		<thead>
	     <tr>
	       <th>이름</th>
	       <th>직급</th>
	       <th>부서</th>
	       <th>주소</th>
	       <th>이메일</th>
	       <th>입사일</th>
	       <th>퇴사일</th>
	       <th>출근수(급여일 기준)</th>
	       <th>초과근무 급여</th>
	       <th>기본 급여</th>
	       <th>직책수당</th>
	       <th>세금</th>
	       <th>총 급여</th>
	       <th>보너스</th>
	     </tr>
		 </thead>
			<tbody>
	     <c:forEach items="${quitList}" var="quit">
	     <tr>
	       <td>${quit.name}</td>
	       <td>${quit.position}</td>
	       <td>${quit.deptName}</td>
	       <td>${quit.addr}</td>
	       <td>${quit.email}</td>
	       <td>${quit.joinDate}</td>
	       <td>${quit.quitDate}</td>
	       <td>${quit.attendance}</td>
	       <td>${quit.otRate}</td>
	       <td>${quit.baseSalary}</td>
	       <td>${quit.positionAllowance}</td>
	       <td>${quit.tax}</td>
	       <td>${quit.totalSalary}</td>
	       <td>${quit.bonus}</td>
	     </tr>
		 </c:forEach>
		 </tbody>
	   </table>
	   <nav>
	   	  <ul class="pagination">
	   <!-- 이전 버튼 -->
	   	<c:choose>
	   	  <c:when test="${paging.page <= 1}">
	   	    <li class="disabled"><span>이전</span></li>
	   	  </c:when>
	   	  <c:otherwise>
	   	    <li>
	   	      <a href="?page=${paging.page - 1}&select=${param.select}&keyword=${param.keyword}">이전</a>
	   	    </li>
	   	  </c:otherwise>
	   	</c:choose>

	       <!-- 페이지 번호 -->
	       <c:forEach
	         var="i"
	         begin="${paging.startPage}"
	         end="${paging.endPage}"
	       >
	         <li class="${i == paging.page ? 'active' : ''}">
	           <a
	             href="?page=${i}&select=${param.select}&keyword=${param.keyword}"
	             >${i}</a
	           >
	         </li>
	       </c:forEach>

	   	<!-- 다음 버튼 -->
	   	<c:choose>
	   	  <c:when test="${paging.page >= paging.lastPage}">
	   	    <li class="disabled"><span>다음</span></li>
	   	  </c:when>
	   	  <c:otherwise>
	   	    <li>
	   	      <a href="?page=${paging.page + 1}&select=${param.select}&keyword=${param.keyword}">다음</a>
	   	    </li>
	   	  </c:otherwise>
	   	</c:choose>
	   	  </ul>
	   	</nav>
	

	</body>
</html>	