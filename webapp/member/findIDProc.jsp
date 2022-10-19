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
<%
		String mname=request.getParameter("mname").trim();
		String email=request.getParameter("email").trim();
		String id=dao.findID(mname, email);
		
		//out.println("입력ID : <strong>" + id + "</strong>");
		if(id!=null){
		    out.println("일치하는 ID는 " + id + " 입니다");
%>
		<form action="tempPW.jsp">
			<br>
            <input type="submit" value="임시 비밀번호 받기">
        </form>
        <form action="tempPWProc.jsp"></form>
<%
		}else{
		    out.println("<p style='color:red'>일치하는 정보가 없습니다</p>");
		}//if end
%> 
		<br>
		<hr>
		<a href="javascript:history.back()">[다시검색]</a>
		&nbsp;&nbsp;
		<a href="javascript:window.close()">[창닫기]</a>       
    </div>
</body>
</html>