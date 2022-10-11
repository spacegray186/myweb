<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import="net.bbs.*"%>

<jsp:useBean id="dao" class="net.bbs.BbsDAO" scope="page"></jsp:useBean>
<jsp:useBean id="dto" class="net.bbs.BbsDTO" scope="page"></jsp:useBean>

<%@ include file="../header.jsp"%>
<!-- 본문시작 bbsList.jsp -->
	<h3>* 글목록 *</h3>
	<p><a href="bbsForm.jsp">[글쓰기]</a></p>
	
	<table class="table table-hover">
    <tr class="success">
		<th>작성자</th>
		<th>글제목</th>
		<th>글내용</th>
		<th>글작성일</th>
    </tr>
<%
    ArrayList<BbsDTO> list=dao.list();
	if(list==null){
	    out.println("<tr>");
	    out.println("  <td colspan='5'>글없음!!</td>");
	    out.println("</tr>");
	}else{
		for(int i=0; i<list.size(); i++){
		    dto=list.get(i);
%>
			<tr>
				<td><a href="bbsRead.jsp?sno=<%=dto.getBbsno()%>"><%=dto.getWname()%></a></td>
				<td><%=dto.getSubject()%></td>
				<td><%=dto.getContent()%></td>
				<td><%=dto.getRegdt().substring(0, 10)%></td>
			</tr>
<%		    
		}//for end
	}//if end
%>    
    </table>
	
<!-- 본문끝 -->
<%@ include file="../footer.jsp"%>

