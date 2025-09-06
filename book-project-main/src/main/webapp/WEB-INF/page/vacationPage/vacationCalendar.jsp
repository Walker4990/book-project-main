<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <!-- FullCalendar -->
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/locales/ko.global.min.js"></script>
  <title>달력</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar.css" />
</head>
<body>
	
	<section class="vacationCal">
	  <div class="box calendar-box">
	    <div class="calendar-scroll">
	      <div id="calendar"></div>
	    </div>
	  </div>
	</section>

  <!-- Modal -->
  <div id="vacationModal" class="modal-overlay">
    <div class="modal-box">
        <div class="modal-header">
          <h5 class="modal-title">휴가 등록</h5>
          <button type="button" class="close-btn" onclick="closeModal()">✕</button>
        </div>
		
		<div class="modal-body">
		<form id="vacationForm" method="post" action="/vacation">
			<div class="form-grid">	
				
            <div class="input">
              <label class="label">신청일</label>
              <input type="date" id="startDate" name="startDate" class="form-control">
            </div>
			
            <div class="input">
              <label class="label">휴가 종료일</label>
              <input type="date" id="endDate" name="endDate" class="form-control">
            </div>
			
            <div class="input">
              <label class="label">신청 사유</label>
              <textarea id="reason" name="reason" class="form-control"></textarea>
            </div>
			</div>
			</div>
			
            <div class="modal-footer">
              <button type="submit" id="saveVacation" >신청</button>
              <button type="button" id="cancelBtn" >취소</button>
            </div>
          </form>
        </div>
      </div>

<script>
	
    // 모달 열닫
	function openModal() {
	  document.getElementById("vacationModal").style.display = "flex";
	}
	
	function closeModal() {
			document.getElementById("vacationModal").style.display = "none";
	}
	
  $.ajax({
    url: '/vacationCalendarData',   // JSON 배열 반환하는 API
    type: 'get',
    dataType: 'json',
    success: function(list) {
      const calendarEl = document.getElementById('calendar');
      const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'today',
          center: 'title',
          right: 'prev,next'
        },
        locale: 'ko',
        events: list,    // ✅ list는 JSON 배열이어야 함
		eventDidMount: function(info) {
		  const dept = info.event.extendedProps.dept_name;
		  console.log("부서:", dept);
		  if (dept === '마케팅팀') {
		    info.el.style.backgroundColor = '#D1C4E9'; // 연보라
		    info.el.style.borderColor = '#B39DDB';
		  } else if (dept === '인사팀') {
		    info.el.style.backgroundColor = '#F8BBD0'; // 연핑크
		    info.el.style.borderColor = '#F48FB1';
		  } else if (dept === '회계/재무팀') {
		    info.el.style.backgroundColor = '#B2DFDB'; // 민트
		    info.el.style.borderColor = '#80CBC4';
		  } else if (dept === '물류(재고 관리)팀') {
		    info.el.style.backgroundColor = '#FFF59D'; // 연노랑
		    info.el.style.borderColor = '#FFF176';
		  } else if (dept === '영업팀') {
		    info.el.style.backgroundColor = '#FFCCBC'; // 살구색
		    info.el.style.borderColor = '#FFAB91';
		  }
		},
        editable: false,
        selectable: true,
        select(info) {
          $("#startDate").val(info.startStr.slice(0,10));
		  $("#endDate").val((info.endStr || info.startStr).slice(0,10));
		    openModal();
          calendar.unselect();
        }
      });
      calendar.render();

      // 취소 버튼 → 폼 초기화
      $("#cancelBtn").off('click').on('click', function(){
        $("#vacationForm")[0].reset();
		closeModal();
      });

      // 신청 버튼 → Ajax submit
	  $("#vacationForm").off('submit').on('submit', function(e){
	        e.preventDefault();

        const startDate = $("#startDate").val();
        const endDate = $("#endDate").val();
        const reason = $("#reason").val();

        if (!startDate) {
          alert("시작 날짜를 입력해주세요");
          return;
        }
        if (!endDate) {
          alert("끝 날짜를 입력해주세요");
          return;
        }
        if (!reason) {
          alert("사유를 입력해주세요");
          return;
        }

        const formData = $(this).serialize();

        $.ajax({
          url: "/vacation",   // 서버 컨트롤러 매핑에 맞게 수정
          type: "post",
		  data: formData,
		      success: function(res){
		        if (res === "success") {
				alert("휴가 신청이 완료 되었습니다. 승인 후 반영될 예정입니다.")
				$("#vacationForm")[0].reset();
		          closeModal();
            } else if (res === "startDateAfter") {
              alert("시작 날짜가 끝 날짜보다 뒤에 있습니다.");
            } else if (res === "dateAfter") {
              alert("휴가 날짜가 이미 지났습니다.");
            } else if (res === "enough") {
              alert("연차가 부족합니다.");
            } else if (res === "empty") {
              alert("연차가 없습니다.");
            } else {
              alert("알 수 없는 오류");
            }
          },
          error: function () {
            alert("서버 오류 발생");
          }
        });
      });
    },
    error: function(xhr) {
      console.error("캘린더 이벤트 로드 실패:", xhr.responseText);
    }
  });
</script>
</body>
</html>
