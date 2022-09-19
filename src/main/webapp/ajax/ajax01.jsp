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
		url:"ajax01_ok.jsp",
		data: {
			name: "홍길동",
			email: "abc@test.com"
		},
		dataType:"text",
		success:function(data){
			//alert(typeof(data));
			//$("#test").html(data);
		},error:function(xhr){
            
			   alert(xhr.status);
		}

	});	
}
</script>
</head>
<body>
<button onclick="abc();">클릭하세요</button>
<div id="test">

</div>
</body>
</html>