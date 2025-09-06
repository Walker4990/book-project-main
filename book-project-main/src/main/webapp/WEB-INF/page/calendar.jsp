<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/locales/ko.global.min.js"></script>
  <title>달력</title>
 


</head>
<body>
	<section class="vacationCal">
		  <div class="box calendar-box">
		    <div class="calendar-scroll">
		      <div id="calendar"></div>
		    </div>
		  </div>
		</section>

  <div id="contractModal" class="modal-overlay">
    <div class="modal-box">
      <div class="modal-header">
        <h5 class="modal-title">계약 등록</h5>
        <button class="close-btn" id="closeModal">✕</button>
      </div>
	  
      <div class="modal-body">
        <form id="contractForm">
          <div class="form-grid">
			
            <div class="input">
              <label class="label" for="authorName">작가 이름</label>
              <input type="text" name="authorName" id="authorName" required>
            </div>
			
            <div class="input">
              <label class="label" for="birthDate">생년월일</label>
              <input type="date" name="birthDate" id="birthDate" required>
            </div>

            <div class="input">
              <label class="label">성별</label>
              <div class="radio-group">
                남<input type="radio" name="gender" value="남" id="man" checked>
                여<input type="radio" name="gender" value="여" id="woman">
              </div>
            </div>
            <div class="input">
              <label class="label" for="nationality">국적</label>
              <select name="nationality" id="nationality" required>
                <option value="" disabled selected >국적 선택</option>
				<option>그리스</option>
				<option>네덜란드</option>
				<option>노르웨이</option>
				<option>대만</option>
				<option>대한민국</option>
				<option>덴마크</option>
				<option>독일</option>
				<option>멕시코</option>
				<option>미국</option>
				<option>바누아투</option>
				<option>스웨덴</option>
				<option>스페인</option>
				<option>영국</option>
				<option>오스트레일리아</option>
				<option>오스트리아</option>
				<option>인도</option>
				<option>일본</option>
				<option>포르투갈</option>
				<option>프랑스</option>
              </select>
            </div>

            <div class="input">
              <label class="label" for="bookTitle">도서 명</label>
              <input type="text" name="bookTitle" id="bookTitle" required>
            </div>
			
            <div class="input">
              <label class="label" for="genre">장르</label>
              <select name="genre" id="genre" required>
                <option value="" disabled selected>장르 선택</option>
                <option>소설</option>
                <option>시</option>
                <option>전기</option>
                <option>에세이</option>
                <option>만화</option>
                <option>심리학</option>
                <option>논픽션</option>
                <option>기타</option>
              </select>
            </div>

            <div class="input">
              <label class="label" for="contractAmount">계약금</label>
              <input type="number" name="contractAmount" id="contractAmount" min="0" required>
            </div>
            <div class="input">
              <label class="label" for="royaltyRate">인세</label>
              <input type="number" name="royaltyRate" id="royaltyRate" min="0" required>
            </div>

            <div class="input">
              <label class="label" for="price">판매가</label>
              <input type="number" name="price" id="price" min="0" required>
            </div>
            <div class="input">
              <label class="label" for="startDate">계약일자</label>
              <input type="date" name="startDate" id="startDate" required>
            </div>

            <div class="input">
              <label class="label" for="endDate">계약 만료 일자</label>
              <input type="date" name="endDate" id="endDate" required>
            </div>
            <div class="input">
              <label class="label" for="manuscriptDue">원고 마감 일자</label>
              <input type="date" name="manuscriptDue" id="manuscriptDue" required>
            </div>

            <div class="input">
              <label class="label" for="printDate">인쇄 예정 일자</label>
              <input type="date" name="printDate" id="printDate"  required>
            </div>
            <div class="input">
              <label class="label" for="publishDate">출판 예정 일자</label>
              <input type="date" name="publishDate" id="publishDate"  required>
            </div>
          </div>
      </div>
	  
      <div class="modal-footer">
        <button type="submit" id="saveContract">저장</button>
        <button type="button" id="closeModalFooter">닫기</button>
      </div>
      </form>
    </div>
  </div>

  <!-- 계약 상세 모달 -->
  <div id="contractDetailModal" class="modal-overlay">
    <div class="modal-box">
      <div class="modal-header">
		<h5 class="modal-title">계약 상세</h5>
        <button class="close-btn" id="closeDetail">✕</button>
      </div>
      <div class="modal-body detail-body">
        <table class="detail-table">
          <tr><td>작가</td><td><span id="detailAuthor"></span></td></tr>
          <tr><td>도서명</td><td><span id="detailBook"></span></td></tr>
          <tr><td>장르</td><td><span id="detailGenre"></span></td></tr>
          <tr><td>계약 시작일</td><td><span id="detailStart"></span></td></tr>
          <tr><td>계약 종료일</td><td><span id="detailEnd"></span></td></tr>
          <tr><td>계약금</td><td><span id="detailAmount"></span></td></tr>
          <tr><td>인세율</td><td><span id="detailRoyalty"></span></td></tr>
        </table>
      </div>
      <div class="modal-footer">
        <button class="btn-secondary" id="closeDetailBtn">닫기</button>
      </div>
    </div>
  </div>


  <script>
    $(function () {
      $.ajax({
        url: '/calendar',
        type: 'GET',
        dataType: 'json',
		success: function (list) {
		  const calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
		    initialView: 'dayGridMonth',
		    locale: 'ko',
		    events: list,
			eventDidMount: function(info) {
			  const genre = info.event.extendedProps.genre;
			  switch (genre) {
			    case '소설':
			      info.el.style.backgroundColor = "#FFCDD2";
			      break;
			    case '시':
			      info.el.style.backgroundColor = "#E1BEE7";
			      break;
			    case '전기':
			      info.el.style.backgroundColor = "#C5CAE9";
			      break;
			    case '에세이':
			      info.el.style.backgroundColor = "#B2DFDB";
			      break;
			    case '만화':
			      info.el.style.backgroundColor = "#FFF59D";
			      break;
			    case '심리학':
			      info.el.style.backgroundColor = "#FFECB3";
			      break;
			    case '논픽션':
			      info.el.style.backgroundColor = "#B3E5FC";
			      break;
			    default:
			      info.el.style.backgroundColor = "#CFD8DC";
			      break;
			  }
			
		    }, // ← 이 괄호 위치 중요
		    selectable: true,
		    select: function(info) {
		      $('#startDate').val(info.startStr.slice(0, 10));
		      $('#contractModal').fadeIn();
		      calendar.unselect();
		    },
		    eventClick: function(info) {
		      const contractId = info.event.id.replace("CONTRACT-", "");
		      $.ajax({
		        url: "/detail/" + contractId,
		        type: "get",
		        success: function(data) {
		          $("#detailAuthor").text(data.authorName);
		          $("#detailBook").text(data.bookTitle);
		          $("#detailGenre").text(data.genre);
		          $("#detailStart").text(data.startDate);
		          $("#detailEnd").text(data.endDate);
		          $("#detailAmount").text(data.contractAmount);
		          $("#detailRoyalty").text(data.royaltyRate + "%");
		          $("#contractDetailModal").fadeIn();
		        },
		        error: function() {
		          alert("상세 조회 실패");
		        }
		      });
		    }
		  });
		  calendar.render();

          $("#closeModal, #closeModalFooter" ).on("click", function(){
            $("#contractModal").fadeOut();
            $("#contractForm")[0].reset();
          });
          $("#closeDetail, #closeDetailBtn").on("click", function(){
            $("#contractDetailModal").fadeOut();
          });

			$("#contractForm").on("submit", function(e){
				e.preventDefault();
			  const authorName    = $('#authorName').val();
			  const birthDate     = $('#birthDate').val() || null;
			  const gender        = $('input[name="gender"]:checked').val() || null;
			  const nationality   = $('#nationality').val() || null;
			  const bookTitle     = $('#bookTitle').val();
			  const genre         = $('#genre').val() || null;
			  const contractAmount= $('#contractAmount').val() || null;
			  const royaltyRate   = $('#royaltyRate').val() || null;
			  const price         = $('#price').val() || null;
			  const startDate     = $('#startDate').val();
			  const endDate       = $('#endDate').val() || null;
			  const manuscriptDue = $('#manuscriptDue').val() || null;
			  const printDate     = $('#printDate').val() || null;
			  const publishDate   = $('#publishDate').val() || null;

			  // 유효성 검증
			  if(!authorName) return alert("작가명을 입력해주세요");
			  if(!birthDate) return alert("생년월일을 입력해주세요");
			  if(!gender) return alert("성별을 입력해주세요");
			  if(!nationality) return alert("국적을 입력해주세요");
			  if(!bookTitle) return alert("제목을 입력해주세요");
			  if(!genre) return alert("장르를 입력해주세요");
			  if(!contractAmount) return alert("계약금을 입력해주세요");
			  if(!royaltyRate) return alert("인세율(저작권료)을 입력해주세요");
			  if(!price) return alert("판매가를 입력해주세요");
			  if(!startDate) return alert("계약 시작일을 입력해주세요");				
			  if(!endDate) return alert("계약 종료일을 입력해주세요");
			  if(!manuscriptDue) return alert("원고 마감일을 입력해주세요");
			  if(!printDate) return alert("인쇄 예정일을 입력해주세요");
			  if(!publishDate) return alert("출판 예정일을 입력해주세요");

			  if (contractAmount < 0) return alert("계약금은 0 이상이여야합니다.");
			  if (royaltyRate < 0) return alert("인세가 0 이상이여야합니다.");
			  if (manuscriptDue && endDate && manuscriptDue > endDate)
			    return alert("원고 마감일은 계약 만료일보다 늦을 수 없습니다.");
			  if (manuscriptDue && printDate && manuscriptDue > printDate)
			    return alert("원고 마감일은 인쇄일보다 늦을 수 없습니다.");
			  if (publishDate && printDate && publishDate < printDate)
			    return alert("출판일은 인쇄일보다 이전일 수 없습니다.");	
			  if (startDate && endDate && startDate > endDate)
			    return alert("계약 시작일이 계약종료일보다 이전일 수 없습니다.");	
			  if (royaltyRate < 0 || royaltyRate > 100) 
				return alert("인세율은 0 ~ 100 사이여야 합니다.");
				
			  // 최종 formData
			  const formData = {
				authorName: $('#authorName').val().trim(),
				birthDate:  $('#birthDate').val(),
				gender:     $('input[name="gender"]:checked').val(),
				nationality:$('#nationality').val(),
				bookTitle:  $('#bookTitle').val().trim(),
				genre:      $('#genre').val(),
				contractAmount: $('#contractAmount').val(),
				royaltyRate:    $('#royaltyRate').val(),
				price:          $('#price').val(),
				startDate:  $('#startDate').val(),
				endDate:    $('#endDate').val(),
				manuscriptDue: $('#manuscriptDue').val(),
				printDate:  $('#printDate').val(),
				publishDate:$('#publishDate').val()
			  };

			  // Ajax 호출은 여기 안에서 실행
			  $.ajax({
			    type: 'POST',
			    url: '/calendar',
			    contentType: 'application/json',
			    data: JSON.stringify(formData),
			    success: function (created) {
			      calendar.addEvent(created);
			      $("#contractModal").fadeOut();
			      $("#contractForm")[0].reset();
			    },
			    error: function () { alert('저장 실패'); }
			  });
			});
        }
      });
    });
  </script>
</body>
</html>
