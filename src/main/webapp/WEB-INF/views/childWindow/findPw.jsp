<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<script src="../assets/js/findAccount.js"></script>
<script type="text/javascript">
	function viewPw()
	{
		$("new_pw").css("type", "text");
		setTimeut(function(){
			$("new_pw").css("type", "password");	
		});
	}
	function viewPwChk()
	{		
		$("new_pw_chk").css("type", "text");
		setTimeut(function(){
			$("new_pw_chk").css("type", "password");	
		});
	}
	function check() {
	
	  var pw = $("#new_pw"); 
	  var chk = $("#new_pw_chk"); 
	
			
   		return pw.val().length > 0 && pw.val()==chk.val();
  	}
	$(function(){
		var id = opener.$('#pw').children("input[name=memberId]").val();
		$("#memberId").val(id);
		
	 	var pw = $("#new_pw"); 
	  	var chk = $("#new_pw_chk");
	  	function checkSame()
	  	{
	  		if(check() == false)
  			{
  				$("#check").text("비밀번호와 비밀번호 확인이 다릅니다.");
  			}
	  		else
  			{
  				$("#check").text("");	  			
  			}
	  		
	  	}
	  	pw.on("keyup", checkSame);
	  	chk.on("keyup", checkSame);
	})
</script>
</head>
<body>
비밀번호를 재설정합니다.<br>
<form action="UpdatePasswd" method="post" onsubmit="return check()">
<table>
<tr>
<td>비밀번호</td>
<td>
	<input type="password" id="new_pw" name = "passwd"/><button>보기</button>
</td>
</tr>
<tr>
<td>비밀번호 확인</td>
<td>
	<input type="password" id="new_pw_chk"/><button>보기</button>
</td>
</tr>
</table>
	<input type="hidden" id="memberId" name = "memberId">
	<p id="check"></p>
	<br><br>
	<input type="submit" value="전송">
</form>

</body>
</html>