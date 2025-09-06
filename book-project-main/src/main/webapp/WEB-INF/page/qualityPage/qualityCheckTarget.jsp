<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>품질검수 대상 조회</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/defect.css"
    />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
      .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        justify-content: center;
        align-items: center;
        z-index: 1000;
      }
      .modal-content {
        background: #fff;
        padding: 20px;
        border-radius: 6px;
        width: 80%;
        max-width: 900px;
      }
      .close {
        float: right;
        cursor: pointer;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <section class="printOrder">
      <div class="box">
        <h1>품질검수 대상 조회</h1>
        <br />

        <!-- 검색 -->
        <form class="searchForm" action="/qualityCheckTarget" method="get">
          <div class="form-inline">
            <input
              type="text"
              name="keyword"
              value="${param.keyword}"
              placeholder="담당자 또는 발주번호를 입력하세요."
            />
            <div class="btn-wrap">
              <button type="submit" value="조회" class="btnNavy">조회</button>
            </div>
          </div>
        </form>

        <!-- 테이블 -->
        <div class="tableWrap">
          <table class="table">
            <thead>
              <tr>
                <th>발주번호</th>
                <th>발주일자</th>
                <th>담당자</th>
                <th>납품일자</th>
                <th>발행일자</th>
                <th>구분</th>
                <th>배송상태</th>
                <th>품질검수</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="qcList" items="${targetList}">
                <tr class="order-summary">
                  <td>${qcList.orderNo}</td>
                  <td>${qcList.orderDate}</td>
                  <td>${qcList.manager}</td>
                  <td>${qcList.deliveryDate}</td>
                  <td>${qcList.issueDate}</td>
                  <td>${qcList.category}</td>
                  <td>${qcList.status}</td>
                  <td>
                    <c:choose>
                      <c:when
                        test="${qcList.status eq '배송 완료' && qcList.qualityChecked==1}"
                      >
                        <span style="color: green; font-weight: bold"
                          >검수 완료</span
                        >
                      </c:when>
                      <c:when test="${qcList.status eq '배송 완료'}">
                        <button class="btnNavy"
                          type="button"
                          onclick="openQualityModal('${qcList.orderNo}')"
                        >
                          검수 등록
                        </button>
                      </c:when>
                    </c:choose>

                    <!-- 🔽 detailList hidden -->
                    <div id="detailData${qcList.orderNo}" style="display: none">
                      <c:forEach var="detail" items="${qcList.detailList}">
                        <div
                          class="detailRow"
                          data-product="${detail.productName}"
                          data-price="${detail.regularPrice}"
                          data-qty="${detail.quantity}"
                          data-detailno="${detail.detailNo}"
                          data-bookno="${detail.bookNo}"
                          data-printDate="${detail.printDate}"
                        ></div>
                      </c:forEach>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
		
        </div>
      </div>

      <!-- 페이지네이션 -->
      <nav>
        <ul class="pagination">
          <c:choose>
            <c:when test="${paging.page == 1}">
              <li class="disabled"><span>이전</span></li>
            </c:when>
            <c:otherwise>
              <li>
                <a href="?page=${paging.page - 1}&keyword=${paging.keyword}"
                  >이전</a
                >
              </li>
            </c:otherwise>
          </c:choose>

          <c:forEach
            var="i"
            begin="${paging.startPage}"
            end="${paging.endPage}"
          >
            <li class="${i == paging.page ? 'active' : ''}">
              <a href="?page=${i}&keyword=${paging.keyword}">${i}</a>
            </li>
          </c:forEach>

          <c:choose>
            <c:when test="${paging.page == paging.lastPage}">
              <li class="disabled"><span>다음</span></li>
            </c:when>
            <c:otherwise>
              <li>
                <a href="?page=${paging.page + 1}&keyword=${paging.keyword}"
                  >다음</a
                >
              </li>
            </c:otherwise>
          </c:choose>
        </ul>
      </nav>
    </section>

    <!-- ✅ 단일 모달 -->
    <div id="qcModal" class="modal-overlay">
      <div class="modal-box">
		<div class="modal-header">
			<h5 class="modal-title">품질검수 등록 (발주번호: <span id="qcOrderNo"></span>)</h5>
        <button class="close-btn" onclick="closeQualityModal()">✕</button>
        </div>

		<div class="modal-body">
        <form action="/qualityCheck/register" method="post">
				
          <input type="hidden" name="orderNo" id="qcOrderNoInput" />

          <table class="table">
            <thead>
              <tr>
                <th>제품명</th>
                <th>정가</th>
                <th>발주수량</th>
                <th>출판일</th>
                <th>검수수량</th>
                <th>회수품 사유</th>
              </tr>
            </thead>
            <tbody id="qcDetailBody"></tbody>
          </table>
		  </div>

          <div class="modal-footer" style="margin-top: 10px">
            <button type="button" onclick="closeQualityModal()">취소</button>
            <button type="button" onclick="insertQualityCheck()">
              검수 완료
            </button>
          </div>
        </form>
      </div>
    </div>

    <script>
      function openQualityModal(orderNo) {
        $("#qcOrderNo").text(orderNo);
        $("#qcOrderNoInput").val(orderNo);
        $("#qcDetailBody").empty();

        $("#detailData" + orderNo + " .detailRow").each(function () {
          const productName = $(this).data("product");
          const regularPrice = $(this).data("price");
          const quantity = $(this).data("qty");
          const detailNo = $(this).data("detailno");
          const bookNo = $(this).data("bookno");
          const printDate = $(this).data("printdate");
          console.log(
            "👉 price 디버깅:",
            regularPrice,
            "bookNo:",
            bookNo,
            "printDate : ",
            printDate
          );

          var row =
            "<tr data-detailno='" +
            detailNo +
            "' data-bookno='" +
            bookNo +
            "' data-qty='" +
            quantity +
            "' data-printDate='" +
            printDate +
            "' data-productName='" +
            productName +
            "'>" +
            "<td>" +
            productName +
            "</td>" +
            "<td>" +
            regularPrice +
            "</td>" +
            "<td>" +
            quantity +
            "</td>" +
            "<td>" +
            printDate +
            "</td>" +
            "<input type='hidden' name='detailList[" +
            detailNo +
            "].productName' value='" +
            productName +
            "'>" +
            "<input type='hidden' name='detailList[" +
            detailNo +
            "].printDate' value='" +
            printDate +
            "'>" +
            "<input type='hidden' name='detailList[" +
            detailNo +
            "].quantity' value='" +
            quantity +
            "'>" +
            "<input type='hidden' name='detailList[" +
            detailNo +
            "].bookNo' value='" +
            bookNo +
            "'>" +
            "<input type='hidden' name='detailList[" +
            detailNo +
            "].regularPrice' value='" +
            regularPrice +
            "'>" +
            "<td><input type='number' name='detailList[" +
            detailNo +
            "].checkQuantity' value='" +
            quantity +
            "'required min='0'></td>" +
			"<td>" +
			  "<div class='status-inline' id='editStatusWrap'>" +
			    "<label class='cbox'>" +
			      "<input type='checkbox' name='detailList["+detailNo+ "].defectReason' value='인쇄 불량' required>" +
			      "<span>인쇄 불량</span>" +
			    "</label>" +
			    "<label class='cbox'>" +
			      "<input type='checkbox' name='detailList["+detailNo+ "].defectReason' value='오타'>" +
			      "<span>오타</span>" +
			    "</label>" +
			    "<label class='cbox'>" +
			      "<input type='checkbox'  name='detailList["+detailNo+ "].defectReason' value='찢어짐'>" +
			      "<span>찢어짐</span>" +
			    "</label>" +
			  "</div>" +
			"</td>" +
            "</tr>";
          $("#qcDetailBody").append(row);
        });

        $("#qcModal").css("display", "flex");
      }
      // required check
      $("#qcDetailBody input[required]").each(function () {
        if (!$(this).val()) {
          alert("필수 입력값을 모두 입력해주세요!");
          $(this).focus();
          return false;
        }
      });

      function closeQualityModal() {
        $("#qcModal").hide();
      }

      function insertQualityCheck() {
        let valid = true;
        const orderNo = $("#qcOrderNoInput").val();

        var data = {
          orderNo: orderNo,
          detailList: [],
        };

        $("#qcDetailBody tr").each(function () {
          const orderQty = $(this).data("qty"); // ✅ 여기서 발주수량 가져옴
          const checkQty = $(this).find("input[name*='.checkQuantity']").val();
          const defectReason = $(this)
            .find("input[name*='.defectReason']")
            .val();

          // 검증
          if (Number(orderQty) < Number(checkQty)) {
            alert("총 수량보다 검수 수량이 많을 수 없습니다.");
            valid = false;
            return false; // break
          }
          if (Number(orderQty) > Number(checkQty) && !defectReason) {
            alert("불량 수량이 있는 경우 반드시 사유를 입력해야 합니다.");
            valid = false;
            return false; // break
          }
		  
		  var defectReasons = [];
		  $(this).find("input[type='checkbox'][name*='.defectReason']:checked").each(function () {
		    defectReasons.push($(this).val());
		  });
		  console.log("확인");
		  console.log(defectReasons);

          var detail = {
            detailNo: $(this).data("detailno"),
			orderNo:orderNo,
            bookNo: $(this).data("bookno"),
            productName: $(this).find("input[name*='.productName']").val(),
            printDate: $(this).find("input[name*='.printDate']").val(),
            quantity: orderQty, // ✅ undefined 대신 orderQty 사용
            checkQuantity: checkQty,
			defectReasons: defectReasons,
            regularPrice: $(this).find("input[name*='.regularPrice']").val(),
          };

          data.detailList.push(detail);
        });

        if (!valid) return;

        $.ajax({
          url: "/insertQualityCheck",
          type: "POST",
          contentType: "application/json",
          data: JSON.stringify(data),
          success: function (res) {
            if (res === "success") {
              alert("검수 등록 완료!");
              closeQualityModal();
              $("button[onclick=\"openQualityModal('" + orderNo + "')\"]")
                .parent()
                .html(
                  "<span style='color:green; font-weight:bold;'>검수 완료</span>"
                );
            } else {
              alert("검수 등록 실패!");
            }
          },
          error: function () {
            alert("서버 오류 발생");
          },
        });
      }
    </script>
  </body>
</html>
