<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>      
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>findID.jsp</title>
</head>
<body>
	<div style="text-align: center">
        <h3>* 아이디/비번 찾기 *</h3>
        <form action="findIDProc.jsp" onsubmit="return blankCheck()">
            이름 : <input type="text" name="mname" id="mname" maxlength="15" autofocus>
            이메일 : <input type="text" name="email" id="email" maxlength="30" autofocus>
            <input type="submit" value="아이디 찾기">
        </form>
    </div>
    
    <script>
    function blankCheck() {
    	let mname=document.getElementById("mname").value;
        mname=mname.trim();
        if(mname.length<2){
            alert("이름 2글자 이상 입력해 주세요");
            document.getElementById("mname").focus();
            return false;
        }//if end
		
		let email=document.getElementById("email").value;
	    email=email.trim();
	    if(email.length<5){
	        alert("이메일 5글자 이상 입력해 주세요");
	        document.getElementById("email").focus();
	        return false;
	    }//if end
	    
		return true;
	    
	}//blankCheck() end
    </script>
</body>
</html>