		<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/member.css"
    />
    <title>사원 조회</title>
  </head>
  <body>
    <section class="member">
      <div class="box">
        <h1>사원 조회</h1>
        <br />
        <form action="/allMember" method="get" class="searchForm">
          <div class="form-inline">
            <select name="select">
              <option value="all">이름 또는 사원번호</option>
              <option value="memberNo">사원번호</option>
              <option value="name">이름</option>
            </select>
            <input
              type="text"
              name="keyword"
              placeholder="정보를 입력하세요."
              value="${dto.keyword}"
            />
            <div class="btn-wrap">
              <input type="submit" value="조회" class="btnNavy" />
            </div>
          </div>
        </form>

        <div class="tableWrapper">
          <table class="table">
            <thead>
              <tr>
                <th>선택</th>
                <th>부서</th>
                <th>이름</th>
                <th>아이디</th>
                <th>이메일</th>
                <th>입사일</th>
                <th>상태</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${list}" var="item">
                <tr>
                  <td>
                    <input
                      type="checkbox"
                      name="memberNo"
                      value="${item.memberNo}"
                    />
                  </td>
                  <td>${item.dept_name}</td>
                  <td>${item.name}</td>
                  <td>${item.id}</td>
                  <td>${item.email}</td>
                  <td>${item.joinDate}</td>
                  <td>${item.type}</td>
                </tr>
              </c:forEach>
            </tbody>
			
          </table>
		  
		  <div class="bottomBtn">		  
          <button type="button" name="quit" id="quit" class="quit adminAccess">
            퇴사 처리
          </button>
		  </div>
		  
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
		  <br>
	
		  
      </div>
	  </div>
	
    </section>

    <script>
      $("#quit").click(() => {
        const memberNos = document.querySelectorAll(
          'input[name="memberNo"]:checked'
        );
        const checked = Array.from(memberNos).map((cb) => Number(cb.value));
        if (checked.length === 0) {
          alert("선택된 회원이 없습니다.");
          return; // 아무것도 선택되지 않았으면 여기서 종료
        }

        $.ajax({
          url: "/quitMember",
          method: "POST",
          contentType: "application/json",
          data: JSON.stringify(checked),

          success: function (result) {
            if (result == "success") {
              alert("퇴사 처리 하였습니다.");
              location.href = "/allMember";
            } else if (result == "fail") {
              alert("실패");
            }
          },
          error: function (error) {
            alert("에러가 발생했습니다");
            console.error(error);
          },
        });
      });
    </script>
  </body>
</html>
