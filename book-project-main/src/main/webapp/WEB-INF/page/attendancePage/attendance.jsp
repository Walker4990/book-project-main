<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>출근 / 퇴근 조회</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/member.css"
    />
  </head>
  <body>
    <section class="attendance">
      <div class="box">
        <h1>사원 조회</h1>
        <br />
        <form
          action="/searchAttendanceInfo"
          method="get"
          class="searchForm"
        >
          <div class="form-inline">
            <input
              type="text"
              name="keyword"
              placeholder="이름을 입력하세요."
            />
            <input type="submit" value="조회" class="btnNavy" />
          </div>
        </form>

        <div class="tableWrapper">
          <table class="table">
            <thead>
              <tr>
                <th>날짜</th>
                <th>사원</th>
                <th>부서</th>
                <th>출근</th>
                <th>퇴근</th>
                <th>연차개수</th>
              </tr>
            </thead>

            <tbody>
              <c:forEach items="${allAttendance}" var="item">
                <tr>
                  <td>${item.date}</td>
                  <td>${item.name}</td>
                  <td>${item.deptName}</td>
                  <td>${item.checkIn}</td>
                  <td>${item.checkOut}</td>
                  <td>${item.annual}</td>
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
