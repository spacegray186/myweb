<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 bbsList.jsp -->
<h3>* 글 목록 *</h3>
<p><a href="bbsForm.jsp">[글쓰기]</a></p>
<div class="container">
	<table class="table table-hover">
	<thead>
		<tr class="success">
			<th>제목</th>
			<th>조회수</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody>
<%
	ArrayList<BbsDTO> list=dao.list();
	if(list==null){
	    out.println("<tr>");
	    out.println("  <td colspan='4'>");
	    out.println("    <strong>관련자료 없음!!</strong>");
	    out.println("  </td>");
	    out.println("</tr>");
	}else{
	    
	    //오늘 날짜를 문자열 "2022-10-22" 만들기
	    String today=Utility.getDate();	    
	    
		for(int i=0; i<list.size(); i++){
		    dto=list.get(i);
%>
			<tr>
				<td style="text-align: left">
				
					<a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>"><%=dto.getSubject()%></a>
					
<%
					//오늘 작성한 글제목 뒤에 new 이미지 출력
					//작성일(regdt)에서 "년월일"만 자르기
					String regdt=dto.getRegdt().substring(0, 10);
					if(regdt.equals(today)){//작성일과 오늘 날짜가 같다면
					    out.println("<img src='../images/new.gif'>");
					}//if end

					//조회수가 10이상이면 hot이미지 출력
					if(dto.getReadcnt()>=10){
					    out.println("<img src='../images/hot.gif'>");
					}//if end 
%>					
				</td>
				<td><%=dto.getReadcnt()%></td>
				<td><%=dto.getWname()%></td>
				<td><%=dto.getRegdt().substring(0, 10)%></td>
			</tr>
<%		    
		}//for end
		
		//글 개수
		int totalRecord=dao.count(); 
	    out.println("<tr>");
	    out.println("	<td colspan='4' style='text-align:center;'>");
	    out.println("		글 개수 : <strong> " + totalRecord +" </strong>");
	    out.println("	</td>");
	    out.println("</tr>");		
	}//if end
%>	
	</tbody>
	</table>
</div>
<!-- 본문끝 -->
<%@ include file="../footer.jsp" %>
