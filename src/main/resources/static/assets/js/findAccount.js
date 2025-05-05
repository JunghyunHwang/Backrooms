/**
 * 
 */

function openChildFindId()
{
	$("#findId").val(opener.$("#find_id_parent").val());
}
$(document).ready(function(){
	$("#btn_id_search").on("click", function(){
		//let sendData = "username="+$('input[name=username]').val();   //폼의 이름 값을 변수 안에 담아줌
		var memberName = $('#id').children("input[name=memberName]").val();
		var phone = $('#id').children("input[name=phone]").val();
		$.ajax({
			type:'post',   //post 방식으로 전송
			url:'FindAccount',   //데이터를 주고받을 파일 주소
			data:{
				"memberName" : memberName,
				"phone" : phone
			},   //위의 변수에 담긴 데이터를 전송해준다.
			dataType:'text',   //html 파일 형식으로 값을 담아온다.
			success :  function(data, status, xhr){
				 
				 window.name = "findAccount";
				 
				 $("#find_id_parent").val(data);
				 var openWin = window.open("FindId", "findId", "width=570, height=350, resizable = no, scrollbars = no");
			},
			error:function(xhr, status, error){
				window.name = "findAccount";
				var openWin = window.open("ErrorToFind", "findId", "width=570, height=350, resizable = no, scrollbars = no");
			}
		});
	});
	
	$("#btn_pw_search").on("click", function(){
		//let sendData = "username="+$('input[name=username]').val();   //폼의 이름 값을 변수 안에 담아줌
		
		var memberName = $('#pw').children("input[name=memberName]").val();
		var phone = $('#pw').children("input[name=phone]").val();
		var memberId = $('#pw').children("input[name=memberId]").val();
		$.ajax({
			type:'post',   //post 방식으로 전송
			url:'FindAccount',   //데이터를 주고받을 파일 주소
			data:{				
				"memberId" : memberId,
				"memberName" : memberName,
				"phone" : phone
			},   //위의 변수에 담긴 데이터를 전송해준다.
			dataType:'text',   //html 파일 형식으로 값을 담아온다.
			success :  function(data, status, xhr){
				window.name = "findAccount";
								 
				 var openWin = window.open("FindPw", "findId", "width=570, height=350, resizable = no, scrollbars = no");
			},
			error:function(xhr, status, error){
				var openWin = window.open("ErrorToFind", "findId", "width=570, height=350, resizable = no, scrollbars = no");
			}
		});
	});
});