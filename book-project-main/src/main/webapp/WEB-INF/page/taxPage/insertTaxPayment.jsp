<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>전직원 급여 일괄 지급</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/tax.css"
    />
  </head>
  <body>
    <h2>세금 납부 등록</h2>
    <form action="/insertTaxPayment" method="post" class="mt-4" id="insertTax">
      <div class="mb-3">
        <label class="form-label">세금 선택</label>
        <select id="taxNo" name="taxNo" class="form-select" required>
          <option value="">세금 선택</option>
          <c:forEach var="tax" items="${unpaidTaxes}">
            <option
              value="${tax.taxNo}"
              data-amount="${tax.remainingAmount}"
              data-taxdate="${tax.taxDate}"
            >
              ${tax.category} - 남은 금액: ${tax.remainingAmount}원 (총 세액:
              ${tax.taxAmount}원, ${tax.taxDate})
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">납부 금액</label>
        <input
          type="number"
          id="amount"
          name="amount"
          class="form-control"
          value="${tax.taxAmount}"
          required
        />
        <input
          type="hidden"
          id="getAmount"
          name="getAmount"
          class="form-control"
          value="${tax.taxAmount}"
          required
        />
      </div>

      <div class="mb-3">
        <label class="form-label">납부일</label>
        <input type="date" name="paymentDate" class="form-control" required />
      </div>

      <div class="mb-3">
        <label class="form-label">납부 방법</label>
        <select name="paymentMethod" class="form-control">
          <option>카드</option>
          <option>계좌이체</option>
          <option>현금</option>
          <option>기타</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">납부 상태</label>
        <select name="status" class="form-select" required>
          <option value="PENDING">미납</option>
          <option value="PARTIAL">일부 납부</option>
          <option value="PAID">완납</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">비고</label>
        <textarea name="description" class="form-control"></textarea>
      </div>

      <button type="button" class="btn btn-primary" id="submitTax">등록</button>
    </form>

    <script>
      $("#taxNo").on("change", function () {
        let amount = $(this).find("option:selected").data("amount");
        console.log("선택된 금액:", amount); // 디버그
        $("#amount").val(amount || "");
      });

      $("#submitTax").click((e) => {
        e.preventDefault();
        const formData = $("#insertTax").serialize();
        // 개별 필드 값 확인
        const taxNo = $("#taxNo").val();
        const amount = $("#amount").val();
        const paymentDate = $("input[name='paymentDate']").val();
        const paymentMethod = $("select[name='paymentMethod']").val();
        const status = $("select[name='status']").val();
        const taxDate = $("#taxNo option:selected").data("taxdate");
        console.log(paymentDate);
        console.log(taxDate);
        // 필수값 확인 (비었으면 return)
        if (!taxNo) {
          alert("세금을 선택해주세요.");
          return;
        }

        if (!amount || parseInt(amount) <= 0) {
          alert("납부 금액을 정확히 입력해주세요.");
          return;
        }

        if (!paymentDate) {
          alert("납부일을 입력해주세요.");
          return;
        }

        if (!paymentMethod) {
          alert("납부 방법을 선택해주세요.");
          return;
        }

        if (!status) {
          alert("납부 상태를 선택해주세요.");
          return;
        }
        if (taxDate && paymentDate) {
          const taxDateObj = new Date(taxDate);
          const paymentDateObj = new Date(paymentDate);

          if (paymentDateObj < taxDateObj) {
            alert("납부일은 세금 발생일 이후여야 합니다.");
            return;
          }
        }

        $.ajax({
          url: "/insertTaxPayment", // ← 여기에 실제 전송할 URL을 입력
          method: "POST",
          data: formData,
          success: function (result) {
            if (result == "success") {
              alert("세금 납부 등록이 완료되었습니다.");
              location.href = "/taxPaidList";
            } else if (result == "fail") {
              alert("세금 등록 실패");
            } else if (result == "overfullAmount") {
              alert("납부할 금액이 초과되었습니다.");
            }
          },
          error: function (xhr, status, error) {
            alert("에러 발생: " + error);
            console.log(error);
          },
        });
      });
    </script>
  </body>
</html>
