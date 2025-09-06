<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>거래처 정보 수정</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
   	
	<div class="container">
	<h1>거래처 정보 수정</h1>
	<input type="hidden" name="partnerNo" id="partnerNo" value="${partner.partnerNo}"/>
	거래처 명 : <input type="text"id ="name" name="name" placeholder="${partner.name}"></br>
	
	거래 종료일 :<input type="date" id ="endDate" name="endDate" value="${partner.endDate}" /></br>
	
	<button id="update" type="button">수정</button>
	<button id="cancel" type="button">취소</button>
	</div>
	
	<script>
		
		$("#update").click(() => {
				const partnerNo = $("#partnerNo").val();
				const name = $("#name").val();
				const startDate = $("#startDate").val();
				const endDate = $("#endDate").val();
				
				const parsedStartDate = new Date(startDate);
				if(parsedStartDate <= startDate ){
					return;
				}
				const formData = new FormData();
				formData.append("partnerNo", partnerNo);
				formData.append("name", name);
				formData.append("startDate", startDate);
				formData.append("endDate", endDate);

				$.ajax({
					type: "POST",
					url: "/updatePartner",
					data: formData,
					processData: false,
					contentType: false,
					success: function (result) {
					if (result === "success") {
					  alert("수정이 완료되었습니다.");
					  location.href = "/allPartner";
					}else if (result == "startDateAfter"){
						alert("날짜를 잘못 입력하셨습니다.")
					}else 
					alert("수정 실패!");
					},
				});
			});
		
		$("#cancel").click(() => {
			location.href="/allPartner"
		});
	</script>
	
  </body>
</html>