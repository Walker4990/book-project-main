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

    <h1>외주 업체 정보 수정</h1>
	<div>
		<input type="hidden" id="eventNo" name="eventNo" value="${marketing.eventNo}" />
			업체명 : <input type="text" id="companyName" name="companyName" value="${marketing.companyName}" /><br>
		    등록일 : <input type="date" id="createdAt"name="createdAt" value="${marketing.createdAt}" /><br>
			담당자 : <input type="text" id="createdBy" value="${marketing.createdBy}" /><br>
			<label for="department" style="display: block;"> 담당부서 : 
			<select id = "department" name="department" value="${marketing.department}">
				<option>마케팅팀</option>
				<option>인사팀</option>
				<option>회계팀</option>
				<option>재고관리팀</option>
				<option>영업팀</option>
				</select>
				</label>
			<label for="eventType" style="display: block;"> 프로모션 유형 :
				<select id ="eventType" name="eventType" value="${marketing.eventType}">
					<option>인스타그램 홍보</option>
					<option>유튜브 홍보</option>
					<option>블로그 홍보</option>
					<option>틱톡 홍보</option>
					<option>사인회</option>
					<option>복콘서트</option>
				</select><br>
			프로젝트명 : <input type="text" id="eventName" name="eventName" value="${marketing.eventName}"/><br>
			프로모션 시작일 : <input type="date" id="durationStart" name="durationStart" value="${marketing.durationStart}"/><br>
			프로모션 종료일 : <input type="date" id="durationEnd" name="durationEnd" value="${marketing.durationEnd}" /><br>
			비용 : <input type="text" id="cost" name="cost" value="${marketing.cost}"/><br>
			
	<div>
		<button id="update" type="button">수정</button>
		<button id="cancel" type="button">취소</button>
		
		<script> 
				$("#update").click(()=>{
					const eventNo = $("#eventNo").val();
					const companyName = $("#companyName").val();
					const createdAt = $("#createdAt").val();
					const createdBy = $("#createdBy").val();
					const department = $("#department").val();
					const eventType = $("#eventType").val();
					const eventName = $("#eventName").val();
					const durationStart = $("#durationStart").val();
					const durationEnd = $("#durationEnd").val();
					const cost = $("#cost").val();
					
					const formData = new FormData();
					 formData.append("eventNo", eventNo);
					 formData.append("companyName", companyName);
					 formData.append("createdAt", createdAt);
					 formData.append("createdBy", createdBy);
					 formData.append("department", department);
					 formData.append("eventType", eventType);
					 formData.append("eventName", eventName);
					 formData.append("durationStart", durationStart);
					 formData.append("durationEnd", durationEnd);
					 formData.append("cost", cost);

				$.ajax({
					type:"POST",
					url:"/updateMarketing",
					data: formData,
					processData: false,
					contentType: false,
					success: function(result){
						if(result ==="success"){
							alert("등록 완료");
							location.href = "/allMarketing";
						} else alert("수정 실패!");
						console.log(result);
									
					},
					error: function(){
						alert("실패");
					}
				});
				});
				$("#cancel").click(() => {
	        location.href = "/allMarketing";
	      });
		</script>
  </body>
</html>