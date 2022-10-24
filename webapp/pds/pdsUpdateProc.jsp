<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>    
<%@ include file="../header.jsp" %>    
<!-- 본문시작 pdsUpdateProc.jsp -->
<!-- pdsIns.jsp 참조-->
<div class="container">
	<h3>* 포토 갤러리 수정 결과  *</h3>
<%
	try{
	    String saveDirectory=application.getRealPath("/storage");
	    int maxPostSize=1024*1024*10;
	    String encodeing="UTF-8";	    
	    MultipartRequest mr=new MultipartRequest(request, saveDirectory, maxPostSize, encodeing, new DefaultFileRenamePolicy());

		String item="";      //name="filename"
		String fileName="";  //파일명
		long fileSize=0;     //파일크기
		File file=null;      //실제 파일 담기
		
		Enumeration files=mr.getFileNames();      //mr에서 <input type=file>을 전부 수거하기
		while(files.hasMoreElements()){           //여러개의 파일을 첨부하는 경우에 한개씩 처리하기
		    item=(String)files.nextElement();     //name="filename"
		    fileName=mr.getFilesystemName(item);  //mr객체에서 item이 가지고 있는 실제 파일명(sky.png) 가져오기
		    if(fileName!=null){                   //실제 파일명을 가져왔다면
		        file=mr.getFile(item);            //mr에서 실제 파일 가져오기
		        if(file.exists()){                //실제 파일이 존재한다면
		            fileSize=file.length();       //파일크기 가져오기
		        }//if end
		    }//if end
		}//while end	    
	    
	    
		String wname  =mr.getParameter("wname").trim();
		String subject=mr.getParameter("subject").trim();
		String passwd =mr.getParameter("passwd").trim();
		int pdsno=Integer.parseInt(mr.getParameter("pdsno"));
		
		dto.setPdsno(pdsno);
		dto.setWname(wname);
		dto.setSubject(subject);
		dto.setPasswd(passwd);
		dto.setFilename(fileName);
		dto.setFilesize(fileSize);
		
		int cnt=dao.updateProc(dto); 
	    if(cnt==0){
	        out.println("<p>포토갤러리 수정 실패했습니다</p>");
	        out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
	    }else{
	        out.println("<script>");
	        out.println("    alert('포토갤러리 수정 되었습니다');");
	        out.println("    location.href='pdsList.jsp';");//목록페이지 이동
	        out.println("</script>");
	    }//if end 		
		
    }catch(Exception e){
        out.print(e);
        out.print("<p>사진 올리기 실패!!</p>");
        out.print("<a href='javascript:history.back();'>[다시시도]</a>");
    }//end
%>	
</div>
<!-- 본문끝 -->
<%@ include file="../footer.jsp" %>    