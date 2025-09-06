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
    <h1>유통 관리 수정</h1>

	<div>
      <input type="hidden" id="deliveryNo" name="deliveryNo" value="${delivery.deliveryNo}" />
      업체명 : <input type="text" id="name" name="name" value="${delivery.name}" /><br />
      주소 : <input type="text" id="address" name="address" value="${delivery.address}" /><br />
      계약금 : <input type="number" id="contractAmount" name="contractAmount" value="${delivery.contractAmount}" /><br />
      계약 날짜 : <input type="date" id="contractDate" name="contractDate" value="${delivery.contractDate}" /><br />
	 </div>

    <button id="update" type="button">수정</button>
    <button id="cancel" type="button">취소</button>

    <script>
      $("#update").click(() => {
        const deliveryNo = $("#deliveryNo").val();
        const name = $("#name").val();
        const address = $("#address").val();
        const contractAmount = $("#contractAmount").val();
        const contractDate = $("#contractDate").val();

        const formData = new FormData();
        formData.append("deliveryNo", deliveryNo);
        formData.append("name", name);
        formData.append("address", address);
        formData.append("contractAmount", contractAmount);
        formData.append("contractDate", contractDate);

        $.ajax({
          type: "POST",
          url: "/updateDelivery",
          data: formData,
          processData: false,
          contentType: false,
          success: function (result) {
            if (result === "success") {
              alert("수정이 완료되었습니다.");
              location.href = "/allDelivery";
            } else alert("수정 실패!");
			console.log(result);
			
			},
			error: function(){
				alert("좋구나");
			}
        });
      });

      $("#cancel").click(() => {
        location.href = "/allDelivery";
      });
    </script>
  </body>
</html>
