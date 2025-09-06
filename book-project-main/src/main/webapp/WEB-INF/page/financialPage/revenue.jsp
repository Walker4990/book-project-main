<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/revenue.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
  </head>
  <body>
	<section class="revenue">
	<div class="box">
    <h1>수입 내역</h1><br>
	
	<form method="get" action="/revenue" class="searchForm">
	<input type="hidden" name="revenuePage" value="${revenuepaging.page}">	
	<input type="hidden" name="expensepaging" value="${expensepaging.page}">
		<div class="input">
		<label class="label" for="month">월별 조회</label>
		</div>
		
		<div class="form-inline-revenue">
		
		<div class="input">
		<input type="month" name="month" value="${selectedMonth}">
		</div>
		
		<div class="btn-wrap-revenue">
		<button type ="submit" class="btnNavy">조회</button>
		</div>
	
		</div>
		</form>
		
		<div class="tableWrapper">
	  <table class="table">
	    <thead>
	      <tr>
	        <th>관리 번호</th>
	        <th>카테고리</th>
	        <th>금액</th>
	        <th>지급 일자</th>
	        <th>상세정보</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:forEach var="rl" items="${revenueList}">
	        <tr>
	          <td>${rl.transactionNo}</td>
			  <td>${rl.category}</td>
	          <td>${rl.totalPrice}</td>
	          <td>${rl.transactionDate}</td>
	          <td>${rl.description}</td>
	        </tr>
	      </c:forEach>
	    </tbody>
	 </table>
	 </div>
	 
	  <nav>
	    <ul class="pagination">
	      <!-- 이전 버튼 -->
	      <c:choose>
	        <c:when test="${revenuepaging.page <= 1}">
	          <li class="disabled"><span>이전</span></li>
	        </c:when>
	        <c:otherwise>
	          <li>
				<a href="?revenuePage=${revenuepaging.page - 1}&expensePage=${expensepaging.page}&month=${selectedMonth}">이전</a>
	          </li>
	        </c:otherwise>
	      </c:choose>

	      <!-- 페이지 번호 -->
	      <c:forEach var="i" begin="${revenuepaging.startPage}" end="${revenuepaging.endPage}">
	        <li class="${i == revenuepaging.page ? 'active' : ''}">
	          <a href="?revenuePage=${i}&expensePage=${expensepaging.page}&month=${selectedMonth}">${i}</a>
			  
	        </li>
	      </c:forEach>

	      <!-- 다음 버튼 -->
	      <c:choose>
	        <c:when test="${revenuepaging.page >= revenuepaging.lastPage}">
	          <li class="disabled"><span>다음</span></li>
	        </c:when>
	        <c:otherwise>
	          <li>
				<a href="?revenuePage=${revenuepaging.page + 1}&expensePage=${expensepaging.page}&month=${selectedMonth}">다음</a>
	          </li>
	        </c:otherwise>
	      </c:choose>
	    </ul>
	  </nav>

	  	
	        <h1>지출 내역</h1><br>
	 	    <form method="get" action="/revenue"  class="searchForm">	
			<input type="hidden" name="revenuePage" value="${revenuepaging.page}">	
			<input type="hidden" name="expensepaging" value="${expensepaging.page}">
			
			<div class="input">
			<label class="label" for="month">월별 조회</label>
			</div>
			
			<div class="form-inline-expense">
			
			<div class="input">
			<input type="month" name="months" value="${selectMonth}">
			</div>
		
			
			<div class="btn-wrap-expense">
			<button type ="submit" class="btnNavy">조회</button>
	  		</div>
			
			</div>
			</form>
				
			<div class="tableWrapper">
	  	  <table class="table">
	  	    <thead>
	  	      <tr>
	  	        <th>관리 번호</th>
	  	        <th>카테고리</th>
	  	        <th>금액</th>
	  	        <th>지급 일자</th>
	  	        <th>상세정보</th>
	  	      </tr>
	  	    </thead>
	  	    <tbody>
	  	      <c:forEach var="el" items="${expenseList}">
	  	        <tr>
	  	          <td>${el.transactionNo}</td>
	  			  <td>${el.category}</td>
	  	          <td>${el.totalPrice}</td>
	  	          <td>${el.transactionDate}</td>
	  	          <td>${el.description}</td>
	  	        </tr>
	  	      </c:forEach>
	  	
	  	    </tbody>
	  		
	  	  </table>
		  </div>
		  
		  <nav>
		    <ul class="pagination">
		      <!-- 이전 버튼 -->
		      <c:choose>
		        <c:when test="${expensepaging.page <= 1}">
		          <li class="disabled"><span>이전</span></li>
		        </c:when>
		        <c:otherwise>
		          <li>
					<a href="?expensePage=${expensepaging.page - 1}&revenuePage=${revenuepaging.page}&months=${selectMonth}">이전</a>
		          </li>
		        </c:otherwise>
		      </c:choose>

		      <!-- 페이지 번호 -->
		      <c:forEach var="i" begin="${expensepaging.startPage}" end="${expensepaging.endPage}">
		        <li class="${i == expensepaging.page ? 'active' : ''}">
		       <a href="?expensePage=${i}&revenuePage=${revenuepaging.page}&months=${selectMonth}">${i}</a>
		        </li>
		      </c:forEach>

		      <!-- 다음 버튼 -->
		      <c:choose>
		        <c:when test="${expensepaging.page >= expensepaging.lastPage}">
		          <li class="disabled"><span>다음</span></li>
		        </c:when>
		        <c:otherwise>
		          <li>
					<a href="?expensePage=${expensepaging.page + 1}&revenuePage=${revenuepaging.page}&months=${selectMonth}">다음</a>
		          </li>
		        </c:otherwise>
		      </c:choose>
		    </ul>
		  </nav>
		 
		  </form> 
	  </div>
		  </section>
					
  </body>
</html>
