/**
 * 
 */

function checkLoginStatus() {
	    const isLoggedIn = localStorage.getItem("loggedIn");
		console.log(isLoggedIn);
	    if (isLoggedIn) {
	        document.getElementById("guest").style.display = "none";
	        document.getElementById("user").style.display = "block";
	    } else {
	        document.getElementById("guest").style.display = "block";
	        document.getElementById("user").style.display = "none";
	    }
	}
	
function login() {
		const userId = document.getElementById('userId').value.trim();
	   const password = document.getElementById('passWard').value.trim();

	   
	   if (!userId || !password) {
	       alert('아이디와 비밀번호를 모두 입력해주세요.');
	       return;
	   }
	
	
	    localStorage.setItem("loggedIn", "true");
		location.href='index.html';
	    checkLoginStatus();
	}
	
function logout() {
	    localStorage.removeItem("loggedIn");
	    checkLoginStatus();
	}
	
	checkLoginStatus();