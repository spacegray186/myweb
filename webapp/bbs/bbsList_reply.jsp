<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 bbsList.jsp -->
<h3>* 글 목록 *</h3>
<p><a href="bbsForm.jsp">[글쓰기]</a></p>

<table class="table table-hover">
<thead>
	<tr class=info>
		<th>제목</th>
	</tr>
</thead>
<tbody>
<%

ArrayList<BbsDTO> list=dao.replyCnt();
if(list==null){ 
    out.println("<tr>");
    out.println("  <td colspan='4'>");
    out.println("    <strong>관련자료 없음!!</strong>");
    out.println("  </td>");
    out.println("</tr>");
}else{
    
	for(int i=0; i<list.size(); i++){
	    dto=list.get(i);
%>
		<tr>
			<td style="text-align: left">
				<a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><%=dto.getSubject()%></a>
			</td>
		</tr>
<%		    
	}//for end
}//if end
%>

</tbody>
</table>

<!-- 본문끝 -->
<%@ include file="../footer.jsp" %>
