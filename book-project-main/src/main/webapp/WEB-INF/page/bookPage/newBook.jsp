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
    <h1>도서 등록</h1>
    <form action="/newBook" method="post">
      제목 : <input type="text" id="title" name="title" placeholder="제목을 입력해주세요"></br>
      작가 : <input type="text" id="author" name="author" placeholder="작가 이름을 입력해주세요"></br>   
      출간일 : <input type="date"id="publishDate" name="publishDate" placeholder="출간일 입력하세요"></br>
      판매 가격 : <input type="text" id="price" name="price" placeholder="판매 가격을 입력하세요"></br>
      <label for="genre" style="display: block;">장르 선택 : 
        <select id="genre" name="genre">
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
     <input type="submit" value="등록">
	
	 <button id="cancel" type="button" value="취소">취소</button>
	
	<script>
		$("#cancel").click(() => {
			const title = ${"title"}
			$.ajax({
				type: "POST",
				url: "/newBook",
				data: fromdata,
				processData: false,
				contentType: false,
				success: function(result)
				{
					if (result === "success") {
						alert("등록이 완료되었습니다.");
						location.href = "/allBook";
					} else 	{
						alert("등록 실패!");
					}
				}
			})
		});
	</script>
	
    </form>
  </body>
</html>



