<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>휴가 신청</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	
    <h1>휴가 관리</h1>
	시작 날짜<br>
	<input type="date" name="startDate" id="startDate" required><br>
	끝 날짜<br>
	<input type="date" name="endDate" id="endDate" required>
	<br>
	사유 <br>
	<input type="text" name="reason" id="reason" required>
	<br><br>
	<button type="button" id="submit">등록</button>
		 
		 <script>

		    $("#submit").click(() => {
				
		     const startDate = $("#startDate").val();
		     const endDate = $("#endDate").val();
			 const reason = $("#reason").val();
			
			if(!startDate)
			{
				alert("시작 날짜를 입력해주세요");
				return;
			}
			if(!endDate)
			{
				alert("끝 날짜를 입력해주세요");
				return;
			}
			if(reason == '')
			{
				alert("사유를 입력해주세요");
				return;
			}
			 
			 
			 
		     const formData = new FormData();

		     formData.append("startDate",startDate);
		     formData.append("endDate", endDate);
			 formData.append("reason", reason);
		     $.ajax({
		        type: "POST",
		 	  	url: "/vacation",
		 	  	data: formData,
		 	  	processData: false,
		 	  	contentType: false,
		 	  	success: function (result) {
		 	  	if (result == "success") {
		 	  	    alert("휴가 등록이 완료되었습니다!");
		 	  	    location.href = "/main";
		 	  	} else if (result == "startDateAfter") {
		 	  	    alert("시작 날짜가 끝 날짜보다 뒤에 있습니다.");
		 	  	} else if (result == "dateAfter") {
					alert("휴가 날짜가 이미 지났습니다.");	
				} else if(result == "enough"){
					alert("연차가 부족합니다.");	
				} else if(result == "empty"){
					alert("연차가 없습니다.");	
				} 
				else {
		 	  	    alert("알 수 없는 오류");
		 	  	 }
		 	  	},
		 	  	    error: function () {
		 	  	       alert("서버 오류 발생");
		 	  	 },
		      })
			})
		</script>	 
  </body>
</html>
