<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ include file="top.jsp"%>    
			<div id="section">
				<h1>회원 상세 정보</h1>
				<hr/>
<jsp:useBean id="mbean" class="shop.com.bean.MemberBean"/>
<jsp:setProperty name="mbean" property="*" />								
<%

MemberDAO mdao = new MemberDAO();
out.println(mbean.getId());
// 아이디 중복 검사
Boolean rsid = mdao.getSearchID(mbean.getId());

if(rsid == true) {
	
%>
<script>
	alert("중복되는 아이디가 있습니다. 확인 바랍니다.");
	history.go(-1);
</script>
<%			
}else{
	
	int rss = mdao.insertMember(mbean);
	out.println(rss+ "개의 회원이 정상적으로 등록되었습니다.");
	response.sendRedirect("memberlist.jsp?menu="+menu);
}
out.println(rsid);

%>

			</div>
<%@ include file="bottom.jsp"%>			