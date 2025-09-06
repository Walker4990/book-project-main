<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css" />
</head>
<body>

	<div class="registerCard">
	      <img src="${pageContext.request.contextPath}/resources/assets/logo.png" alt="" />
	      <h1>REGISTER</h1>

	      
	        <div class="inputGroup">
	          <input type="text" name="id" id="id" placeholder="사용하실 아이디를 입력하세요" required />
	        </div>

	        <div class="inputGroup">
	          <input type="text" name="name" id="name" placeholder="이름을 입력하세요" required />
	        </div>

	        <div class="inputGroup">
	          <input
	            type="password"
	            name="password"
				id="password"
	            placeholder="비밀번호를 입력하세요"
	            required
	          />
	        </div>
			<!--
	        <div class="inputGroup">
	          <input
	            type="password"
	            name="passwordConfirm"
	            placeholder="비밀번호 확인"
	            required
	          />
	        </div>-->

			<div class="inputGroup">
			        <select name="deptNo" id="deptNo">
			          <option value="" disabled selected>
			            본인이 속한 부서를 선택하세요
			          </option>
			          <option value="1">마케팅</option>
			          <option value="2">인사팀</option>
			          <option value="3">회계/재무팀</option>
			          <option value="4">물류(재고 관리)팀</option>
			          <option value="5">영업팀</option>
			        </select>
			</div>
				  
			<div class="inputGroup">
				<select name="position" id="position">
				<option value="" disabled selected>
				  	본인의 직급을 선택하세요
				</option>
				<option value="사원">사원</option>
				<option value="주임">주임</option>
				<option value="대리">대리</option>
				<option value="과장">과장</option>
				<option value="차장">차장</option>
				<option value="부장">부장</option>
				<option value="팀장">팀장</option>
				<option value="이사">이사</option>
				<option value="상무">상무</option>
				<option value="전무">전무</option>
				<option value="대표이사">대표이사</option>
				
				</select>
			</div>

	        <div class="inputGroup">
	          <input type="text" name="addr" id="addr" placeholder="주소" required />
	        </div>

	        <div class="inputGroup">
	          <input type="email" name="email" id="email" placeholder="이메일" required />
	        </div>

	        <div class="inputGroup">
	          <input type="date" name="joinDate" id="joinDate" placeholder="입사일" required />
	          <p>※ 본인의 입사일을 입력해주세요</p>
	        </div>
			<div class="inputGroup">
				<select name="role" id="role">
				<option value="" disabled selected>
				  	본인의 권한을 선택하세요
				</option>
				<option value="USER">USER</option>
				<option value="ADMIN">ADMIN</option>
				</select>
			</div>

	        <button type="submit" class="register" id="registerBtn">회원가입</button>
			<button type="button" class="cancel" id="cancelBtn">취소</button>

	        <div class="to-login">
	          <a href="/login">이미 계정이 있으신가요? 로그인</a>
	        </div>
	      
	    </div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


<script>
	$("#cancelBtn").click(() => {
	    location.href = "/login";
	  });
	  
	  $("#registerBtn").click(() => {
	  	    const id = $("#id").val();
	  	    const password = $("#password").val();
	  	    const name = $("#name").val();
			const position =$("#position").val();
	  	    const deptNo = $("#deptNo").val();
	  	    const address = $("#addr").val();
	  	    const email = $("#email").val();
			const joinDate = $("#joinDate").val();
			const role = $("#role").val();

	  	    if (!id || !password || !name || !position || !deptNo || !address || !email|| !joinDate||!role) {
	  	      alert("모든 값을 입력해주세요.");
	  	      return;
	  	    }

	  	    const formData = new FormData();
	  	    formData.append("id", id);
	  	    formData.append("password", password);
	  	    formData.append("name", name);
			formData.append("position", position);
	  	    formData.append("deptNo", deptNo); 
	  	    formData.append("addr", address);   
	  	    formData.append("email", email);
			formData.append("joinDate", joinDate);
			formData.append("role",role);
	  	    $.ajax({
	  	      type: "POST",
	  	      url: "/register",
	  	      data: formData,
	  	      processData: false,
	  	      contentType: false,
	  	      success: function (result) {
	  	        if (result === "success") {
	  	          alert("회원가입 성공!");
	  	          location.href = "/login";
	  	        } else if (result === "duplicate") {
	  	          alert("아이디 또는 이메일 중복입니다.");
	  	        } else {
	  	          alert("알 수 없는 오류");
	  	        }
	  	      },
	  	      error: function () {
	  	        alert("서버 오류 발생");
	  	      },
	  	    });
	  	  });

/*	
$("#registerBtn").click(function(e){
 

   // const form = $("#registerForm")[0];
    const formData = new FormData(form);

    $.ajax({
        type: "POST",
        url: "/register",
        data: formData,
        processData: false, 
        contentType: false, 
        success: function(result){
            if(result === "success"){
                alert("회원가입 성공!");
                location.href = "/login";
            } else if(result === "duplicate"){
                alert("아이디 또는 이메일이 중복됩니다.");
            }
        },
        error: function(){
            alert("오류 발생");
        }
    });
});
	*/
</script>
</body>
</html>