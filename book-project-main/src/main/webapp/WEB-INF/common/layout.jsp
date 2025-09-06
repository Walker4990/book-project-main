<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>달의 서재</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/updateInfo.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/contract.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shipment.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/po.css" />
	<!--<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/quit.css" /> -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<jsp:include page="overtimeModal.jsp" />
	<jsp:include page="side.jsp" />
	  <div class="main">
	    <jsp:include page="header.jsp" />
	    <jsp:include page="/WEB-INF/page/${page}" />
	 </div>
         <script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
		 <script>
			$(document).ready(function() {
			    $(".toggle-submenu").click(function(e) {
			        e.preventDefault();
			        $(this).next(".submenu-2").slideDown();
			    });
			});
		 </script>
  </body>
</html>