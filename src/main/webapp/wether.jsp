<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
/* Javascript 샘플 코드 */


var xhr = new XMLHttpRequest();
var url = "https://apis.data.go.kr/1360000/VilageFcstMsgService/getLandFcst?serviceKey=zj%2BgF2pIXe8aXZgjKd53WlpzGACyXfz%2FXJTaZl057ITgPIiZ9Ty44jXS%2BuyIjjWsWrpzL3OpvCI21krPM3IiJw%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&regId=11A00101";
/*var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'서비스키';
queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10');
queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('XML');
queryParams += '&' + encodeURIComponent('stnId') + '=' + encodeURIComponent('108');
*/
xhr.open('GET', url);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
    }
};

xhr.send('');
</script>
</head>
<body>

</body>
</html>