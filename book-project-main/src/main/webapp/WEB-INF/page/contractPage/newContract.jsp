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
	
	
   	<div class="newContract">
	<h1>신규 작가 계약 등록</h1>

			작가명 : <input type="text" id="authorName" name="authorName" required></input><br>
			생년월일 : <input type="date" id="birthDate" name="birthDate" required></input><br>	
			성별 : 
			     <input type="radio" name="gender" value="남" id="man" checked  required/>
			     <label for="man">남</label>
			     <input type="radio" name="gender" value="여" id="woman"  />
				 <label for="woman">여</label>			 
	      
			<label for="nationality" style="display: block;">국적 : 
				<select id = "nationality" name="nationality" required>
					<option value="" disabled selected>국적 선택</option>
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
			</label>
			도서명 : <input type="text" id="bookTitle" name="bookTitle" required /><br>
			
			<label for="genre" style="display: block;">장르 : 
			        <select id="genre" name="genre" required>
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
			        </label>
			계약금 : <input type="number" id="contractAmount" name="contractAmount" required/><br>
			인세 : <input type="number" id="royaltyRate" name="royaltyRate" required /><br>
			판매가 : <input type="number" id="price" name="price" required /><br> 
			계약 일자 : <input type="date" id="startDate" name="startDate" required /><br>
			계약 만료 일자 : <input type="date" id="endDate" name="endDate" required /><br>
			원고 마감 일자 : <input type="date" id="manuscriptDue" name="manuscriptDue" required /><br>
			인쇄 예정 일자 : <input type="date" id="printDate" name="printDate" required /><br>
			출판 예정 일자 : <input type="date" id="publishDate" name="publishDate" required /><br>
			
			<button id="register" type="button">등록</button>
			<button id="cancel" type="button">취소</button>
			
			<script>
				$("#register").click(() => {
					const authorName = $("#authorName").val();
					const birthDate = $("#birthDate").val();
					const gender = $("input[name='gender']:checked").val();
					const nationality = $("#nationality").val();
					const bookTitle =$("#bookTitle").val();
					const genre = $("#genre").val();
					const contractAmount = $("#contractAmount").val();
					const royaltyRate = $("#royaltyRate").val();
					const price = $("#price").val();
					const startDate = $("#startDate").val();
					const endDate = $("#endDate").val();
					const manuscriptDue = $("#manuscriptDue").val();
					const printDate = $("#printDate").val();
					const publishDate = $("#publishDate").val();
					
					if (!authorName || !birthDate || !gender || !nationality || !bookTitle ||
					    !genre || !contractAmount || !royaltyRate || !price ||
					    !startDate || !endDate || !manuscriptDue || !printDate || !publishDate) {
					    alert("입력하지 않은 항목이 있습니다.");
					    return;
					}
					
					if (startDate && endDate && startDate > endDate) {
					  alert("계약 시작일은 계약 만료일보다 이전이어야 합니다.");
					  return;
					}

					if (manuscriptDue && endDate && manuscriptDue > endDate) {
					  alert("원고 마감일은 계약 만료일보다 이전이어야 합니다.");
					  return;
					}

					if (manuscriptDue && printDate && manuscriptDue > printDate) {
					  alert("원고 마감일은 인쇄일보다 이전이어야 합니다.");
					  return;
					}

					if (printDate && publishDate && publishDate < printDate) {
					  alert("출판일은 인쇄일 이후여야 합니다.");
					  return;
					}
					if(parseInt(royaltyRate) <= 0|| parseInt(contractAmount)<=0) {
						alert("금액을 정확히 입력해주세요.");
						return;
					}
					if(parseInt(royaltyRate) > 20) {
						alert("인세율은 1~20% 사이로 입력해주세요.");
						return;
					}
					
					
					
					
					$.ajax({
						type: "POST",
						url: "/newContract",
						data: {
							authorName: authorName,
							birthDate: birthDate,
							gender: gender,
							nationality: nationality,
							bookTitle: bookTitle,
							genre: genre,
							contractAmount: contractAmount,
							royaltyRate: royaltyRate,
							price: price,
							startDate: startDate,
							endDate: endDate,
							manuscriptDue: manuscriptDue,
							printDate: printDate,
							publishDate: publishDate
						},
				
						success: function(result) {
						       if (result === "success") {
						           alert("등록 완료되었습니다.");
						           location.href = "/allContract";
						       } else if (result === "fail") {
						           alert("등록 실패. 다시 시도해주세요.");
						       }
						   },
						      error: function(xhr) {
						        console.error(xhr.responseText || xhr);
						        alert("서버 오류 발생");
						      }
					});
				});
				
				$("#cancel").click(() => {
					location.href="/main"
				});
				
			</script>
	</div>
  </body>
</html>