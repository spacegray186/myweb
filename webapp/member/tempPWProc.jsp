<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문시작 tempPWProc.jsp -->
<h3>* 아이디, 임시 비밀번호 메일로 보내기 결과 *</h3>
<%
		String passwd	=request.getParameter("passwd").trim();
		String id		=request.getParameter("id").trim();
		
		dto.setPasswd(passwd);
		dto.setId(id);
		
		/*
		int cnt=dao.updatePW(dto);
		if(cnt==0){
			out.println("<p>메일 보내기 실패</p>");
	        out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
		}else{
			out.println("<script>");
	        out.println("    alert('메일 보내기 완료');");
	        out.println("    location.href='loginForm.jsp';");
	        out.println("</script>");
		}//if end
		*/
%>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>
