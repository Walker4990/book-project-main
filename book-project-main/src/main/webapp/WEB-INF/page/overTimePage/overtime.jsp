<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>야근 신청</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<sec:authentication var="member" property="principal" />
	<h1>야근 신청</h1>
	<input type="hidden" name="memberNo" id="memberNo" value="<sec:authentication property='principal.memberNo'/>" />
	<input type="hidden" name="name" id="name" value="<sec:authentication property='principal.name'/>" />
	    등록일 : <input type="date" id="overTimeDate"name="overTimeDate"value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"readonly/><br>
		사유 : <input type="text" id="reason" name="reason" /><br>
		<button type="button" id="submit">등록</button>
	
	<script> 
		$(document).ready(function() {
		$("#submit").click(()=>{
			const name = $("#name").val();
			const overTimeDate = $("#overTimeDate").val();
			const reason = $("#reason").val();
			const memberNo = $("#memberNo").val();
			
			if(name == "" || reason == "")
			{
				alert("이름 및 사유를 입력하세요.");
				return;
			}
		$.ajax({
			type:"POST",
			url:"/newOverTime",
			data:{
					name : name,
					date: overTimeDate,
					reason: reason,
					memberNo : memberNo
			},
			success: function(result){
				if(result =="success"){
					alert("등록 완료");
					location.href = "/main"
				}
				else if(result == "already")
				{
					alert("이미 오늘 야근신청을 완료했습니다.");
				}
				else{
					alert("등록할 수 없습니다.");
				}
			},
			error: function(){
				alert("실패");
			}
		});
	});
});
	</script> 
  </body>
  </html>