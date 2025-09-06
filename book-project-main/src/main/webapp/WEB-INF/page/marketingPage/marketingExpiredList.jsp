<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">-->
    <title>Document</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	
	<section class="marketing">
	<div class="box">
	<h1>만료 외주업체 검색 조회</h1><br>
	
	<form action="/SearchmarketingExpiredList" method="get" class="searchForm">
		<div class="form-inline">
		<input type="text" name="keyword" value="${param.keyword}">
		
		<div class="btn-wrap">		
		<button type="submit" value="조회" class="btnNavy">조회</button>
		</div>	
		
		</div>
    </form>	
	
	
		<h1>만료 프로모션 조회</h1>
		<div class="tableWrapper">
		<table class="table">
			<tr>
				<th>선택</th>
				<th>프로모션 번호</th>
				<th>업체명</th>
				<th>등록일</th>
				<th>담당자</th>
				<th>담당부서</th>
				<th>프로모션 유형</th>
				<th>프로젝트명</th>
				<th>프로모션 시작일</th>
				<th>프로모션 종료일</th>
				<th>비용</th>
			</tr>
			
			<c:forEach items="${expiredList}" var="expired">
			
			<tr>
				<td><input type="checkbox" name="eventNo" value="${expired.eventNo}"></td>
				<td>${expired.eventNo}</td>
				<td>${expired.companyName}</td>
				<td>${expired.createdAt}</td>
				<td>${expired.createdBy}</td>
				<td>${expired.department}</td>
				<td>${expired.eventType}</td>
				<td>${expired.eventName}</td>
				<td>${expired.durationStart}</td>
				<td>${expired.durationEnd}</td>
				<td>${expired.cost}</td>
			</tr>
		</c:forEach>
		</table>
		
	<div class="bottomBtn">
	<button id="delete" type="button" class="delete adminAccess">삭제</button>
	</div>
	
		<nav>
	  <ul class="pagination">
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

	
	</section>
	

	<script>
		
		$("#delete").click(() => {
			const eventNo = $("input[name='eventNo']:checked").val();
			if(!eventNo){
				alert("삭제할 내용을 선택하세요");
				return;
			}
			$.ajax({
				type:"POST",
				url:"/deleteMarketing",
				data:{
					eventNo: eventNo
				},
				success: function(result){
					if(result=="success"){
						alert("삭제 완료");
						location.href="/marketingExpiredList"
					}
				},
				error: function(){
					alert("삭제 실패")
				}
			});
			
		});
	</script>
	
	
  </body>
  </html>