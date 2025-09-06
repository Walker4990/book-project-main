function closeEditModal() {
    document.getElementById("overtimeModal").style.display = "none";
}
$(document).on("click", "#saveOvertimeSubmit", function() {
			
	
			let name = $("#overTimeName").val();
			let overTimeDate = $("#overTimeDate").val();
			let reason = $("#overTimeReason").val();
			let memberNo = $("#memberNo").val();
			console.log(name);
			console.log(overTimeDate);
			console.log(reason);
			console.log(memberNo);
			
			if(name == "" || reason == "")
			{
				alert("이름 및 사유를 입력하세요.");
				return;
			}
		$.ajax({
			type:"POST",
			url:"/newOverTime",
			data:{
					name : name,
					date: overTimeDate,
					reason: reason,
					memberNo : memberNo
			},
			success: function(result){
				if(result =="success"){
					alert("등록 완료");
					location.href = "/main"
				}
				else if(result == "already")
				{
					alert("이미 오늘 야근신청을 완료했습니다.");
				}
				else{
					alert("등록할 수 없습니다.");
				}
			},
			error: function(){
				alert("실패");
			}
	});
});
