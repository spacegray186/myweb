<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>      
<!-- 본문시작 findID.jsp -->
<h3>* 아이디/비번 찾기 *</h3>
<form method="post" action="findIDProc.jsp" onsubmit="return findIDCheck()"><!-- myscript.js -->
    <!-- 
    이름 : <input type="text" name="mname" id="mname" maxlength="15" autofocus>
    이메일 : <input type="email" name="email" id="email" maxlength="30" autofocus>
    <input type="submit" value="아이디 찾기">
     -->
    <table class="table">
	<tr>
	   <th>이름</th>
	   <td>
	      <input type="text" name="mname" id="mname" placeholder="이름" maxlength="20" required>
	   </td>
	</tr>
	<tr>
	   <th>이메일</th>
	   <td>
	      <input type="email" name="email" id="email" placeholder="이메일" required>
	   </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="아이디/비번찾기"  class="btn btn-primary"/>
			<input type="reset"  value="취소"  class="btn btn-primary"/>
		</td>
	</tr>
	</table>
</form>
<!--     
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
 -->
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>