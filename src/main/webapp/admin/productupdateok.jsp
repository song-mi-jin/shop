<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.ProductDAO"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="top.jsp"%>    
			<div id="section">
				<h1>상품 수정</h1>
				<hr/>
<jsp:useBean id="pbean" class="shop.com.bean.ProductBean"/>							
<%
ServletContext context = getServletContext();
String realFolder = context.getRealPath("\\upimg");
String encType = "utf-8"; //인코딩 타입
int maxSize = 5 * 1024 * 1024; //최대 업로드될 파일의 크기5Mb

MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

Enumeration files = multi.getFileNames();
//열거형 객체로 저장
String filename = null;

String pimg = multi.getParameter("pimg");

if(files.hasMoreElements()) {
	
	String name = (String) files.nextElement();
	
	//파일 업로드가 있을 경우 이전 파일은 삭제
	File file = multi.getFile(name);
	if(file !=null) {
		
		String uploadedFileName =  realFolder+"\\" + pimg;
		File realFile = new File(uploadedFileName);  //파일객체 생성
		boolean isDel = false;
		isDel = realFile.delete(); //boolean type 리턴
	
		out.println(uploadedFileName);
	
	}

	
	filename = multi.getFilesystemName(name);
	//서버에 저장된 파일명
	
	String original = multi.getOriginalFileName(name);
	// 사용자가 업로드한 파일명

%>
<img src="<%=request.getContextPath()%>/upimg/<%=filename%>" />
<%
}

int pnum = Integer.parseInt(multi.getParameter("pnum"));
String pname = multi.getParameter("pname");
int pprice = Integer.parseInt(multi.getParameter("pprice"));
int pstock = Integer.parseInt(multi.getParameter("pstock"));
String phot = multi.getParameter("phot");
String pnew = multi.getParameter("pnew");
String pdisplay = multi.getParameter("pdisplay");
String pdesc = multi.getParameter("pdesc");

pbean.setPnum(pnum);
pbean.setPname(pname);
pbean.setPprice(pprice);
pbean.setPstock(pstock);
pbean.setPimg(filename);
pbean.setPdesc(pdesc);
pbean.setPhot(phot);
pbean.setPnew(pnew);
pbean.setPdisplay(pdisplay);

ProductDAO pdao = new ProductDAO();

out.println(pbean.getPhot());
int rss = pdao.updateProduct(pbean);
out.println(rss+ "개의 상품이 정상적으로 수정되었습니다.");

%>

			</div>
<%@ include file="bottom.jsp"%>			