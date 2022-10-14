/**
 * myscript.js
 */
 
function bbsCheck(){ //게시판 유효성 검사
    //1)작성자 2글자 이상 입력
    let wname=document.getElementById("wname").value; //작성자 가져오기
    wname=wname.trim();
    if(wname.length<2){
        alert("작성자 2글자 이상 입력해 주세요");
        document.getElementById("wname").focus();//작성자칸에 커서 생성
        return false;//전송하지 않음
    }//if end    

	//2)제목 2글자 이상 입력
	var subject=document.getElementById("subject").value;
	subject=subject.trim();                               
	if(subject.length<2){
	    alert("제목 2글자 이상 입력해 주세요");
    	document.getElementById("subject").focus();     
    	return false;                                 
	}//if end
	
	//3)내용 2글자 이상 입력
	var content=document.getElementById("content").value;
	content=content.trim();                               
	if(content.length<2){
	    alert("내용 2글자 이상 입력해 주세요");
    	document.getElementById("content").focus();    
    	return false;                                 
	}//if end
    
    //4)비밀번호는 4글자 이상이면서, 숫자형 기호만 입력
    let passwd=document.getElementById("passwd").value; 
    passwd=passwd.trim();
    if(passwd.length<4 || isNaN(passwd)){
        alert("비밀번호 4글자 이상 숫자로 입력해 주세요");
        document.getElementById("passwd").focus();
        return false;
    }//if end

	return true; //onsubmit이벤트에서 서버로 전송

}//bbsCheck() end


function pwCheck(){
	let passwd=document.getElementById("passwd").value; 
    passwd=passwd.trim();
    if(passwd.length<4 || isNaN(passwd)){
        alert("비밀번호 4글자 이상 숫자로 입력해 주세요");
        document.getElementById("passwd").focus();
        return false;
    }//if end
    
    let message="진행된 내용은 복구되지 않습니다\n계속 진행할까요?";
    if(confirm(message)){ //확인true, 취소false
		return true; //서버로 전송
	}else{
		return false
	}//if end
}//pwCheck() end


function searchCheck(){
	//검색어를 입력해야만 서버로 전송
	let word=document.getElementById("word").value;
	word=word.trim();
	if(word.length==0){
		alert("검색어를 입력해 주세요");
		return false;
	}//if end
	
	return true;
}//searchCheck()end

function lotto(){
	
	let lotto=[];
	
	for(let i=0; i<6; i++) {
        lotto[i]=parseInt(Math.random()*45)+1;
        for(let j=0; j<i; j++) {
            if(lotto[i]==lotto[j]) { // 로또번호가 중복되었는지?
                i--;
                break;
            }// if end
        }// for end
    }// for end

    lotto=lotto.sort(function(a, b){return a - b}); // 오름차순 정렬
	
	alert(lotto);
}//lotto() end

