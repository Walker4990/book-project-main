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
		
		<section class="contractExp">
		<div class="box">
				
	    <h1>만료/해지된 계약 작가 정보 검색</h1><br>
	    
			<form action="/allContractExpired" method="get" class="searchForm">
				<div class="form-inline">
				<select name="select">
					<option value="authorName">작가명</option>
					<option value="genre">장르</option>
					<option value="contractNo">계약 번호</option>
				</select>
				<input type="text" name="keyword" value="${param.keyword}">
				
				<div class="btn-wrap">
				<button type="submit" value="조회" class="btnNavy">조회</button>
				</div>
				</div>
			</form>
		
			<h1> 계약 만료/해지 작가 조회 </h1>
			<div class="tableWrapper">
		    <table class="table">
			<thead>
			<tr>
				<th>작가명</th>
				<th>국적</th>
				<th>생년월일</th>
				<th>성별</th>
				<th>도서명</th>
				<th>장르</th>
				<th>계약금</th>
				<th>인세</th>
				<th>계약 일자</th>
				<th>계약 만료 일자</th>
				<th>종료 유형</th>
				<th>종료 사유</th>
				<th>만료 처리 일자</th>
			</tr>
			</thead>
			
			<tbody>
			<c:forEach items="${expiredList}" var="list">				
			<tr>
				<td>${list.authorName}</td>
				<td>${list.nationality}</td>
				<td>${list.birthDate}</td>
				<td>${list.gender}</td>
				<td>${list.bookTitle}</td>
				<td>${list.genre}</td>
				<td>${list.contractAmount}</td>
				<td>${list.royaltyRate}</td>
				<td>${list.startDate}</td>
				<td>${list.endDate}</td>
				<td>${list.closeType}</td>
				<td>${list.closeReason}</td>
				<td>${list.expiredDate}</td>			
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
			
			<script>
				$("#update").click(() => {
				  const contractNo = $("input[name='contractNo']:checked").val();
				  if (contractNo) {
				    location.href = "/updateContract?contractNo=" + contractNo;
				  } else {
				    alert("수정할 계약을 선택해주세요.");
				  }
				});		
				
				$("#delete").click(() => {
					const contractNo = $("input[name='contractNo']:checked").val();
					if (!contractNo) {
					      alert("삭제할 계약을 선택해주세요.");
					      return;
					    }
				$.ajax({
					type:"POST",
					url:"/insertExpired",
					data: {
						contractNo: contractNo
					},
					success: function(result) {
						if (result=="success"){
							alert("삭제완료");
							location.href = "/allContract"
						} else alert("삭제 실패")
					}
				});
					
				});
			</script>	
	  </body>
	</html>