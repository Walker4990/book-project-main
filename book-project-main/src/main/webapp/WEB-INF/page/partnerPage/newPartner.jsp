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
   	
	<div class="container">
	<h1>신규 거래처(서점) 등록</h1>
	거래처명 : <input type="text" id="name" name="name" required/><br>	
	온/오프라인 : 
	<input type="radio" name="type" id="online" value="온라인" checked />
	<label for ="online">온라인</label>	
	<input type="radio" name="type" id=offline value="오프라인" />
	<label for ="offline">오프라인</label>	<br>
	거래 시작일 : <input type="date" id="startDate" name="startDate" required/><br>
	거래 종료일 : <input type="date" id="endDate" name="endDate" required/>
	<button id="submit" type="button">등록</button>
	<button id="cancel" type="button">취소</button>
	</div>
	
	<script>
		
	$("#submit").click(() => {
			// required 검사
			let allValid = true;
	$("input:required").each(function () {
		if (!this.checkValidity()) { //required, type, pattern 등의 유효성 검사를 실행
			this.reportValidity(); // 브라우저 기본 알림 띄우기
		allValid = false;
		return false; // break
		}
		});
			if (!allValid) return;
					
			const name = $("#name").val();
			const type = $("input[name='type']:checked").val();
			const startDate = $("#startDate").val();
			const endDate = $("#endDate").val();
			if (startDate && endDate && startDate > endDate){
				alert("거래시작일이 더 빨라야합니다.");
				return;
			}
			
			$.ajax({
				type:"POST",
				url:"/newPartner",
				data: {
				name: name,
				type: type,
				startDate: startDate,
				endDate: endDate
				},
				success: function(result) {
				if (result=="success"){
				alert("등록 완료");
				location.href = "/main"
				}
				else if(result==="fail")
				alert("등록 실패")	;
				},
				error:function(){
					alert("서버오류");
				}
				
			});	 					
		});
							
		$("#cancel").click(() => {
			location.href="/main"
		});
	
	</script>
	
  </body>
</html>