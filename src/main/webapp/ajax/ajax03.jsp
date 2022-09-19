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
		url:"mem.json",
		dataType:"json",
		success:function(data){
			alert(typeof(data));
			//object
			$("#test1").html(data.id);
            $("#test2").html(data.name);
            $("#test3").html(data.addr);
            
		},error:function(xhr){
            
			   alert(xhr.status);
		}

	});	
}
</script>
</head>
<body>
<button onclick="abc();">클릭하세요</button>
<div id="test1"></div>
<div id="test2"></div>
<div id="test3"></div>
</body>
</html>