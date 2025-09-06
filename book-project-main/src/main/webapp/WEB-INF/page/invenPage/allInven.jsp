<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>출고 등록</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<section class="inventory">
		<div class="box">
	<h1>재고 목록</h1><br>
	
	<form action="/allInven" method="get" class="searchForm">
		<div class="form-inline">
		  <select name="select">
		  				<option value="all">제품명 또는 책 번호</option>
		  				<option value="bookTitle">책 이름</option>
		  				<option value="bookNo">책 번호</option>
		  			</select>
					
		 <input type="text" name="keyword" placeholder="정보를 입력하세요." value="${dto.keyword}">
		 
		 <div class="btn-wrap">
		 <input type="submit" value="조회" class="btnNavy">
		 </div>
		 </div>
		 	</form>
			
			<h1>재고 현황 조회</h1>
			
			<div class="tableWrapper">
	<table class="table">
		<thead>
		<tr>			
			<th>책 번호</th>
			<th>책 이름</th>
			<th>유형</th>
			<th>수량</th>
			<th>장소</th>			
		</tr>
		</thead>
		
		<tbody>
		<c:forEach var="inven" items="${invenList}">
		<tr>		
			<td>${inven.bookNo}</td>
			<td>${inven.bookTitle}</td>
			<td>${inven.actionType}</td>
			<td>${inven.quantity}</td>
			<td>${inven.location}</td>			
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
	</div>
	</section>
</body>
</html>