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
			name: $("#name").val(),
			email: $("#email").val()
		},
		success:function(data){
			$("#test").html(data);
		},error:function(xhr){
            
			   alert(xhr.status);
		}

	});	
}
</script>
</head>
<body>
<input id="name" name="name"><br />
<input id="email" name="email">
<button onclick="abc();">클릭하세요</button>
<div id="test">

</div>
</body>
</html>