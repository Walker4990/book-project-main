<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>출고 등록</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h2>출고 등록</h2>

<!-- 숨겨진 옵션 복제용 select -->
<select id="inventoryOptions" style="display:none">
  <option value="" disabled selected>도서 선택</option>
  <c:forEach var="inven" items="${invenList}">
    <option value="${inven.inventoryNo}">
      ${inven.bookTitle} / 재고: ${inven.quantity} / 위치: ${inven.location}
    </option>
  </c:forEach>
</select>

<select id="partnerOptions" style="display:none">
  <c:forEach var="p" items="${partnerList}">
    <option value="${p.partnerNo}">${p.name}</option>
  </c:forEach>
</select>

<select id="deliveryOptions" style="display:none">
  <c:forEach var="d" items="${deliveryList}">
    <option value="${d.deliveryNo}">${d.name}</option>
  </c:forEach>
</select>

<table id="outTable" border="1">
  <thead>
    <tr>
      <th>도서 (재고 기준)</th>
      <th>출고 수량</th>
      <th>단가</th>
      <th>출고 위치</th>
      <th>거래처</th>
      <th>운송사</th>
      <th>삭제</th>
    </tr>
  </thead>
  <tbody id="detailBody">
    <!-- 기본 1행 -->
    <tr>
      <td>
        <select name="outList[0].inventoryNo" class="inventoryNo" required>
			<c:forEach var="inven" items="${invenList}">
			  <option value="${inven.inventoryNo}">
			    ${inven.bookTitle} / 재고: ${inven.quantity} / 위치: ${inven.location}
			  </option>
			</c:forEach>
        </select>
      </td>
      <td><input type="number" name="outList[0].quantity" class="quantity" min="1" required /></td>
      <td><input type="number" name="outList[0].price" class="price" min="0" required /></td>
      <td><input type="text" name="outList[0].location" class="location" value="창고" required /></td>
      <td>
        <select name="outList[0].partnerNo" class="partnerNo" required>
          <c:forEach var="p" items="${partnerList}">
            <option value="${p.partnerNo}">${p.name}</option>
          </c:forEach>
        </select>
      </td>
      <td>
        <select name="outList[0].deliveryNo" class="deliveryNo" required>
          <c:forEach var="d" items="${deliveryList}">
            <option value="${d.deliveryNo}">${d.name}</option>
          </c:forEach>
        </select>
      </td>
      <td><button type="button" class="removeRow">삭제</button></td>
    </tr>
  </tbody>
</table>

<br>
<button type="button" id="addRow">행 추가</button>
<button type="button" id="submitBtn">출고 등록</button>

<script>
let rowCount = 1;

// ✅ 행 추가
$("#addRow").click(() => {
  const newRow = $("<tr>");

	const inventorySelect = $("<select>")
	  .addClass("inventoryNo")
	  .attr("name", `outList[${rowCount}].inventoryNo`) // ✅ 인덱스 추가
	  .attr("required", true);
	$("#inventoryOptions option").each(function () {
	  inventorySelect.append($(this).clone());
	});

	const partnerSelect = $("<select>")
	  .addClass("partnerNo")
	  .attr("name", `outList[${rowCount}].partnerNo`) // ✅ 인덱스 추가
	  .attr("required", true);
	$("#partnerOptions option").each(function () {
	  partnerSelect.append($(this).clone());
	});

	const deliverySelect = $("<select>")
	  .addClass("deliveryNo")
	  .attr("name", `outList[${rowCount}].deliveryNo`) // ✅ 인덱스 추가
	  .attr("required", true);
	$("#deliveryOptions option").each(function () {
	  deliverySelect.append($(this).clone());
	});
  newRow.append($("<td>").append(inventorySelect));
  newRow.append($("<td>").append(`<input type="number" name="outList[${rowCount}].quantity" class="quantity" min="1" required>`));
  newRow.append($("<td>").append(`<input type="number" name="outList[${rowCount}].price" class="price" min="0" required>`));
  newRow.append($("<td>").append(`<input type="text" name="outList[${rowCount}].location" class="location" value="창고" required>`));
  newRow.append($("<td>").append(partnerSelect));
  newRow.append($("<td>").append(deliverySelect));
  newRow.append($("<td>").append(`<button type="button" class="removeRow">삭제</button>`));

  $("#outTable tbody").append(newRow);
  rowCount++;
});

// ✅ 삭제
$(document).on("click", ".removeRow", function () {
	const rowCount = $("#detailBody tr").length;
	if (rowCount > 1) {
		$(this).closest("tr").remove();
	} else {
		alert("최소 1개의 출고 항목은 유지해야 합니다.");
	}
});

// ✅ 출고 등록
$("#submitBtn").click(() => {
  let isValid = true;
  const outList = [];

  $("#outTable tbody tr").each((i, row) => {
    const inventoryNo = Number($(row).find(".inventoryNo").val());
    const quantity = Number($(row).find(".quantity").val());

    console.log(`✔️ [${i}] inventoryNo =`, inventoryNo); // 🔍 확인용 로그

    if (!inventoryNo || inventoryNo === 0) {
      alert(`[${i + 1}행] 도서를 선택하지 않았습니다.`);
      isValid = false;
      return false;
    }

    if (!quantity || quantity <= 0) {
      alert(`[${i + 1}행] 출고 수량이 올바르지 않습니다.`);
      isValid = false;
      return false;
    }

    outList.push({
      inventoryNo: inventoryNo,
      quantity: quantity,
      price: Number($(row).find(".price").val()),
      location: $(row).find(".location").val(),
      partnerNo: Number($(row).find(".partnerNo").val()),
      deliveryNo: Number($(row).find(".deliveryNo").val())
    });
  });

  if (!isValid) return;

  console.log("📦 최종 전송 데이터: ", outList);

  $.ajax({
    url: "/newOutInven",
    method: "POST",
    contentType: "application/json",
    data: JSON.stringify(outList),
    success: function (result) {
      if (result === "success") {
        alert("출고 등록 완료");
        location.reload();
      } else {
        alert("출고 등록 실패");
      }
    },
    error: function () {
      alert("출고 등록 실패 (서버 오류)");
    }
  });
});

// ✅ 단가 자동 조회
$(document).on("change", ".inventoryNo", function () {
  const $row = $(this).closest("tr");
  const inventoryNo = $(this).val();

  if (inventoryNo) {
    $.ajax({
      url: "/getBookPrice",
      method: "GET",
      data: { inventoryNo },
      success: function (price) {
        if (price != null) {
          $row.find(".price").val(price);
        } else {
          $row.find(".price").val("");
          alert("단가 정보를 가져올 수 없습니다.");
        }
      },
      error: function () {
        alert("단가 조회 실패 (서버 오류)");
      }
    });
  }
});
</script>

</body>
</html>