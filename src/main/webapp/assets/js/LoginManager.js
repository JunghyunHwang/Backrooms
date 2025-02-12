/**
 * 
 */

function checkLoginStatus() {
	    const isLoggedIn = localStorage.getItem("loggedIn");
	    if (isLoggedIn) {
	        document.getElementById("guest").style.display = "none";
	        document.getElementById("user").style.display = "block";
	    } else {
	        document.getElementById("guest").style.display = "block";
	        document.getElementById("user").style.display = "none";
	    }
	}
	
function login() {
	    localStorage.setItem("loggedIn", "true");
	    checkLoginStatus();
	}
	
function logout() {
	    localStorage.removeItem("loggedIn");
	    checkLoginStatus();
	}
	
	checkLoginStatus();