<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>품의서 상세</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<section class="viewRequest">
	<h2>품의서 상세</h2>
	<p><strong>제목:</strong> ${request.title}</p>
	<p><strong>작성자:</strong> ${request.memberName}</p>
	<p><strong>작성일자:</strong> ${request.writeDate}</p>
	<p><strong>결재자:</strong> ${request.approverName}</p>
	<p><strong>결재 상태:</strong> ${request.approvalStatus}</p>
	<p><strong>내용:</strong><br/>${request.content}</p>
	<c:if test="${not empty request.filePath}">
	  <p><a href="${request.filePath}" download>첨부파일 다운로드</a></p>
	</c:if>

	<c:if test="${isWriter}">
	  <form action="/updateRequest" method="post">
		<!-- 작성자가 아니면 내용 수정 불가함 -->
	    <input type="hidden" name="requestNo" value="${request.requestNo}" />
	    제목: <input type="text" name="title" value="${request.title}" required/><br/>
	    내용:<br/><textarea name="content" rows="10" cols="50">${request.content}</textarea><br/>
	    <button type="submit">수정</button>
	  </form>
	</c:if>
	
	<c:if test="${isApprover && request.approvalStatus ne '승인'}">
	  <form action="/approveRequest" method="post">
	    <input type="hidden" name="no" value="${request.requestNo}" />
	    <button type="submit">승인</button>
	  </form>
	</c:if>
	</section>
  </body>
</html>