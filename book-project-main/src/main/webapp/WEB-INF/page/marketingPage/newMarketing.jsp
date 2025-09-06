<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	
	<h1>신규 외주업체 등록</h1>
	<form action="/newMarketing" method="post">
		업체명 : <input type="text" id="companyName" name="companyName"/><br>
	    등록일 : <input type="date" id="createdAt"name="createdAt"/><br>
		담당자 : <input type="text" id="createdBy" name="createdBy"/><br>
		<label for="department" style="display: block;"> 담당부서 : 
		<select id = "department" name="department">
			<option>마케팅팀</option>
			<option>인사팀</option>
			<option>회계팀</option>
			<option>재고관리팀</option>
			<option>영업팀</option>
			</select>
			</label>
		<label for="eventType" style="display: block;"> 프로모션 유형 :
			<select id ="eventType" name="eventType">
				<option>인스타그램 홍보</option>
				<option>유튜브 홍보</option>
				<option>블로그 홍보</option>
				<option>틱톡 홍보</option>
				<option>사인회</option>
				<option>복콘서트</option>
			</select><br>
		프로젝트명 : <input type="text" id="eventName" name="eventName" /><br>
		프로모션 시작일 : <input type="date" id="durationStart" name="durationStart"/><br>
		프로모션 종료일 : <input type="date" id="durationEnd" name="durationEnd" /><br>
		비용 : <input type="number" id="cost" name="cost" min="0"/><br>
		<input type="submit"id="submit" value="등록"/>
	</form>
	
	<script> 
		$("#submit").click((e)=>{
			e.preventDefault();
			
			const companyName = $("#companyName").val();
			const createdAt = $("#createdAt").val();
			const createdBy = $("#createdBy").val();
			const department = $("#department").val();
			const eventType = $("#eventType").val();
			const eventName = $("#eventName").val();
			const durationStart = $("#durationStart").val();
			const durationEnd = $("#durationEnd").val();
			let cost = $("#cost").val();
			
			if(!companyName||!createdAt||!createdBy|| 
				!department||!eventType||!eventName|| 
				!durationStart||!durationEnd||cost === null || cost.trim() === "")
				{
					alert("등록할 내용을 입력해주세요.");
					return;
				}
			if(!companyName)
			{
				alert("엽체명을 입력해주세요.");
				return;
			}	
			if(!createdAt)
			{
				alert("등록일을 입력해주세요.");
				return;
			}
			if(!createdBy)
			{
				alert("담당자를 입력해주세요.");
				return;
			}		
			if(!eventName)
			{
				alert("프로젝트명을 입력해주세요.");
				return;
			}
			if(cost.trim() === "")
			{
				alert("비용을 입력해주세요.");
				return;
			}
				
			//시작 날짜가 종료 날짜보다 뒤일때 반환	
			if (new Date(durationStart) > new Date(durationEnd)) 
			{
					alert("시작 날짜와 종료날짜가 맞지 않습니다.");
					return;
			}	
			if (cost < 0) 
			{
				alert("비용은 마이너스가 될 수 없습니다.");
				return;
			}	
				
				
			const formData = new FormData();
			formData.append("companyName",companyName);
			formData.append("createdAt",createdAt);
			formData.append("createdBy",createdBy);
			formData.append("department",department);
			formData.append("eventType",eventType);
			formData.append("eventName",eventName);	
			formData.append("durationStart",durationStart);
			formData.append("durationEnd",durationEnd);
			formData.append("cost",cost);
			
			
		$.ajax({
			type:"POST",
			url:"/newMarketing",
			data:formData,
			processData: false,
			contentType: false,
			success: function(result){
				if(result =="success"){
					alert("신규 마케팅 등록 완료!");
					location.href = "/main";
				}
				else if(result == "notMem")
				{
					alert("담당 직원이 존재하지 않습니다.");
				}
				else if(result == "dateError")
				{
					alert("시작 날짜는 종료 날짜보다 이전이어야 합니다.");
				}
			
				
			},
			error: function(error){
				console.error("오류 발생:", error); // 콘솔에 오류 내용 출력
				alert("오류가 발생했습니다.");
			}
		});
		});
	</script>
	
  </body>
  </html>