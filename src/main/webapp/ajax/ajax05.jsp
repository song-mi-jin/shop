<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
function abc(){
	
	$.ajax({
		url:"ajax05_ok.jsp",
		data :{
			user_num: 2
		},
		dataType:"json",
		success:function(data){

			$("#test").append(data.id);
			$("#test").append(data.name);
            
		},error:function(xhr){
            
			   alert(xhr.status);
		}

	});	
}
</script>
</head>
<body>
<!-- <button onclick="abc();">클릭하세요</button> -->
<a href="ajax05_ok.jsp?user_num=2">회원정보</a>
<div id="test"></div>
</body>
</html>