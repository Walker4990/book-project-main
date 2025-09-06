<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>도서 조회 페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
   
    <section class="book"> 
		<div class="box">
			
		<h1>도서 검색/조회</h1><br>
		
      <form action="/allBook" method="get" class="searchForm"">
		<div class="form-inline">
        <select name="select">
          <option value="author">작가명</option>
          <option value="title">도서명</option>
        </select>
        <input type="text" name="keyword" value="${param.keyword}" placeholder="검색할 도서명을 입력하세요"/>
        <input type="submit" value="조회" class="btnNavy" />
		</div>
      </form>
	  
      <h1>전체 도서 목록 조회</h1>
	  
	  <div class="tableWrapper">
      <table class="table">
		<thead>
        <tr>
          <th>도서 번호</th>
          <th>도서명</th>
          <th>작가명</th>
          <th>출간일</th>
          <th>가격</th>
          <th>장르</th>
        </tr>
		</thead>
		<tbody>
        <c:forEach items="${bookList}" var="book">
          <tr>
            <td>${book.bookNo}</td>
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.publishDate}</td>
            <td>${book.price}</td>
            <td>${book.genre}</td>
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
	  
		</div>
		</div>
	</section>
	
  </body>
</html>
