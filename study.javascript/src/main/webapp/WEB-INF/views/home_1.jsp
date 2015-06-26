<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
</body>
</html>
<script type="text/javascript">
var str = "010-9347-9327";
console.log(str.replace(/[^0-9]/g, ''));
console.log(str.replace(/0/g, ''));

var check = /[a-z]/g;
var aa = "abc";
console.log(check.test(aa));


var url = /(\w+):\/\/([\w.]+)\/(\S*)/;
var text = "The website address is http://www.abc.com/news/2013/07/09";
var result = text.match(url);
console.log(result);

var u = /(\w+):\/(\S*)/;
var s = "hi hello http://www.kind102.co.kr/kind";
var r = s.match(u);
console.log(r);

</script>
