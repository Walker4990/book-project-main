<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>반품 등록</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h2>반품 등록</h2>

<table id="returnTable" border="1">
  <thead>
    <tr>
      <th>도서</th>
      <th>수량</th>
      <th>보관 위치</th>
      <th>사유</th>
      <th>삭제</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <select class="bookSelect">
          <c:forEach var="book" items="${bookList}">
            <option value="${book.bookNo}">${book.title}</option>
          </c:forEach>
        </select>
      </td>
      <td><input type="number" class="quantity" min="1" required /></td>
      <td><input type="text" class="location" value="창고" required /></td>
      <td><input type="text" class="reason" placeholder="반품 사유 입력" required /></td>
      <td><button type="button" class="removeRow">삭제</button></td>
    </tr>
  </tbody>
</table>

<br>
<button type="button" id="addRow">행 추가</button>
<button type="button" id="submitBtn">반품 등록</button>

<script>
let rowCount = 1;

$("#addRow").click(() => {
  const newRow = `
    <tr>
      <td>
        <select class="bookSelect">
          <c:forEach var="book" items="${bookList}">
            <option value="${book.bookNo}">${book.title}</option>
          </c:forEach>
        </select>
      </td>
      <td><input type="number" class="quantity" min="1" required /></td>
      <td><input type="text" class="location" value="창고" required /></td>
      <td><input type="text" class="reason" placeholder="반품 사유 입력" required /></td>
      <td><button type="button" class="removeRow">삭제</button></td>
    </tr>`;
  $("#returnTable tbody").append(newRow);
  rowCount++;
});
// $("#removeBtn").click()...이면 작동 안함.
//그래서 document에 이벤트를 위임하는 식으로 처리:
// "document가 .removeRow를 감시하다가 클릭되면 처리"하는 구조.
$(document).on("click", ".removeRow", function () {
  $(this).closest("tr").remove();
});

$("#submitBtn").click(() => {
  const returnList = [];

  $("#returnTable tbody tr").each((_, row) => {
    const bookNo = $(row).find(".bookSelect").val();
    const quantity = $(row).find(".quantity").val();
    const location = $(row).find(".location").val();
    const reason = $(row).find(".reason").val();

    returnList.push({
      bookNo,
      quantity,
      location,
      reason,
      actionType: "RETURN",
    });
  });

  $.ajax({
    url: "/inventory/return",
    method: "POST",
    contentType: "application/json",
    data: JSON.stringify(returnList),
    success: (res) => {
      if (res === "success") {
        alert("반품 등록 완료");
        location.reload();
      } else {
        alert("반품 등록 실패");
      }
    },
    error: () => alert("에러 발생"),
  });
});

// inventory action_type -> in, out, return으로 변경
// ALTER TABLE inventory ADD COLUMN reason VARCHAR(255);
</script>

</body>
</html>