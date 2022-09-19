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
		url:"mem2.json",
		dataType:"json",
		success:function(data){
			
			alert(typeof(data));
			$.each(data, function(i, field){

				var res = "";

				for(var key in data[i]) {
						
					res += key+" : "+data[i][key]+" ";

				}

				res += "<br />";

				$("#test").append(res);

			});
            
		},error:function(xhr){
            
			   alert(xhr.status);
		}

	});	
}
</script>
</head>
<body>
<button onclick="abc();">클릭하세요</button>
<div id="test"></div>
</body>
</html>