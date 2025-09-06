$(document).ready(function () {
  let memberNo;
  let role;
  let memberList = []; //
	
  // 메뉴 토글
  $(".menu-title").click(function () {
    $(this).next(".submenu").toggleClass("show");
  });

  // 2차 서브메뉴 (인사 평가 관리)
  $(".toggle-submenu").click(function () {
    $(this).next(".submenu1").toggleClass("show");
  });

  $.ajax({
    url: "/getMember",
    type: "GET",
    success: function (member) {
      const { memberNo: no, role: role2 } = member;
      memberNo = no;
      role = role2;
	
      console.log("사용자 번호:", memberNo);
      console.log("사용자 역할:", role);

      getRole(role);
      getDate(memberNo);
    },
    error: function () {
      console.error("🚫 사원 번호 요청 실패");
    },
  });
  function getRole(role) {
    if (role == "USER") {
      $(".adminAccess").hide();
    } else if (role == "ADMIN") {
      $(".adminAccess").show();
    }
  }

  function getDate(memberNo) {
    // 브라우저 로드 시 서버에서 오늘 날짜 받아오기
    $.ajax({
      url: "/getOverTime",
      type: "GET",
      success: function (overTimeList) {
        memberList = overTimeList;
        //날짜 받기
        const now = new Date(); //현재 시간
        const resetHour = 5;
        const todayReset = new Date();
        todayReset.setHours(resetHour, 0, 0, 0); //오늘 오전 5시
        const lastReset = localStorage.getItem(`${memberNo}` +"lastReset");
		
		let nowTime = now.toTimeString().split(" ")[0];
		$("#clock").text(nowTime);
        $("#time").text(now.toISOString().split("T")[0]);
		$("#times").text(now.toISOString().split("T")[0]);
        const dayNames = [
          "Sunday",
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
        ];
        const dayOfWeek = dayNames[now.getDay()];
        console.log(dayOfWeek); // 👉 오늘 요일 출력 (예: "수요일")
        $("#date").text(dayOfWeek);
		
		const dayweek = [
		          "일",
		          "월",
		          "화",
		          "수",
		          "목",
		          "금",
		          "토",
		        ];
		const dayOfWeekKo = dayweek[now.getDay()];
		$("#dateKo").text(dayOfWeekKo);		
		

        // 날짜가 다르면 localStorage 초기화
        if (
          !lastReset ||
          (now >= todayReset && new Date(lastReset) < todayReset)
        ) {
          localStorage.setItem(`${memberNo}` + "_checkedIn", "false");
          localStorage.setItem(`${memberNo}` + "_checkedOut", "false");
          localStorage.removeItem(`${memberNo}` + "_checkInTime");
          localStorage.removeItem(`${memberNo}` + "_checkOutTime");
          //초기화 날짜 저장
          localStorage.setItem(`${memberNo}` +"lastReset", now.toISOString());
        }

        if (localStorage.getItem(`${memberNo}` + "_checkedIn") === "true") {
          $("#checkIn").prop("disabled", true).text("출근 완료");
        }
        //출근 시간
        const checkInTime = localStorage.getItem(
          `${memberNo}` + "_checkInTime"
        );
        if (checkInTime) {
          $("#checkInDisplay").text(checkInTime);
        }
        //퇴근 시간
        const checkOutTime = localStorage.getItem(
          `${memberNo}` + "_checkOutTime"
        );
        if (checkOutTime) {
          $("#checkOutDisplay").text(checkOutTime);
        }
      },
      error: function () {
        console.error("🚫 서버 날짜 요청 실패");
      },
    });
  }
  
 setInterval(() => {
   const nowTime = new Date().toTimeString().split(" ")[0];
   $("#clock").text(nowTime); // 시간 표시만 갱신
 }, 1000);
 
 
 
  $("#checkIn").click(function () {
    if (!memberNo) return alert("사원 번호가 아직 로드되지 않았습니다.");
    //오늘 날짜와 Controller날짜와 비교
    localStorage.setItem(`${memberNo}` + "_checkedIn", "true");

    //찍은 시간 저장
    const now = new Date();
    const timeString = now.toTimeString().split(" ")[0]; // "HH:mm:ss"
    localStorage.setItem(`${memberNo}` + "_checkInTime", timeString);
    $("#checkInDisplay").text(timeString);
    $.ajax({
      url: "/checkIn",
      type: "POST",
      success: function (result) {
        if (parseInt(result) > 0) {
          alert("출근 체크 완료");
          location.href = "/main";
        } else if (parseInt(result) == -1) {
          alert("이미 출근하였습니다.");
        }
      },
      error: function () {
        alert("출근 체크 실패");
      },
    });
  });

  $("#checkOut").click(function () {
    if (!memberNo) return alert("사원 번호가 아직 로드되지 않았습니다.");
    if (localStorage.getItem(`${memberNo}` + "_checkedIn") === "false") {
      alert("아직 출근하지 않았습니다.");
      return;
    }

    //12시부터 5시까지
    const now = new Date();
    const hour = now.getHours(); //시간 ex: 17
    // memberNo가 야근 신청 리스트에 없는 경우 반환
    if (!memberList.includes(memberNo) && hour >= 0 && hour < 5) {
      alert("야근 신청을 하지 않았습니다.");
      return;
    }

    const timeString = now.toTimeString().split(" ")[0]; // "HH:mm:ss"
    localStorage.setItem(`${memberNo}` + "_checkOutTime", timeString);
    $("#checkOutDisplay").text(timeString);
    $.ajax({
      url: "/checkOut",
      type: "POST",
      success: function (result) {
        if (parseInt(result) > 0) {
          alert("퇴근 체크 완료");
        } else if (parseInt(result) == -1) {
          alert("출근 상태가 아닙니다.");
        }
      },
      error: function () {
        alert("퇴근 체크 실패");
      },
    });
  });
  
  $("#request").click(() => {
    location.href = "/allRequest";
  });
  
  $("#openOvertimeModalBtn").click((e) => {
    e.preventDefault();
	$("#overtimeModal").show();
  });
  
  // 모달 닫기
  $("#closeOvertimeSubmit").on("click", function () {
       $("#overtimeModal").hide();
  });
  
  
  
});
