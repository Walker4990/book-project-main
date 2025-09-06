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
    <h1>유통 관리 등록</h1>
      회사명 : <input type="text" id="name" name="name" /><br />
      주소 : <input type="text" id="address" name="address" /><br />
      계약금 : <input type="number" id="contractAmount" name="contractAmount" /><br />
      계약 날짜 : <input type="date" id="contractDate" name="contractDate" /><br />
	  <button id="submit" type="button">등록</button>
	  <button id="cancel" type="button">취소</button>
    </div>
	
	<script>
		
		$("#submit").click(() =>{
			const name = $("#name").val();
			const address = $("#address").val();
			const contractAmount = parseInt( $("#contractAmount").val(),10);
			const contractDate = $("#contractDate").val();
			
			if(!name){
				alert("이름을 입력해주세요");
				return;
			}
			if(!address){
				alert("주소를 입력해주세요");
				return;
			}
			if(!contractAmount){
				alert("계약금을 입력해주세요");
				return;
			}
			if(!contractDate){
				alert("날짜를 입력해주세요");
				return;
			}
			if(contractAmount < 0)
			{
				alert("계약금은 0 이상이여야합니다.");
				return;
			}
		$.ajax({
			type:"POST",
			url:"/newDelivery",
			data:{
			name: name,
			address: address,
			contractAmount: contractAmount,
			contractDate: contractDate
			},
			success: function(result) {
				if (result=="success"){
					alert("등록 완료");
					location.href = "/allDelivery"
				}
			},
			error: function() {
				alert("등록 실패");
			}
		});
		});
					
		$("#cancel").click(() => {
			location.href="/main"
		});
		</script>
  </body>
</html>
