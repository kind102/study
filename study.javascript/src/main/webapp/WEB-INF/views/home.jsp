<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>

</body>
</html>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js" ></script>
<script type="text/javascript">
var str = "010-9347-9327";
//console.log(str.replace(/[^0-9]/g, ''));
//console.log(str.replace(/[0-9]/g, ''));

var check = /[a-z]/g;
var aa = "abc";
//console.log(check.test(aa));


var url = /(\w+):\/\/([\w.]+)\/(\S*)/;
var text = "The website address is http://www.abc.com/news/2013/07/09";
var result = text.match(url);
//console.log(result);

var u = /(\w+):\/(\S*)/;
var s = "hi hello http://www.kind102.co.kr/kind";
var r = s.match(u);
//console.log(r);

var options = $.extend( null || {}, {
	dataType: "script",
	cache: true,
	url: "/javascript/resources/js/home.js"
});


// ajax 공부
$.ajax(options)
	.done(function(script, textStatus) {
		//console.log("success 1 : ", script);
		//console.log("success 2 : ", textStatus);
	})
	.fail(function(jqXHR, settings, exception) {
		//console.log("fail 1 : ", jqXHR);
		//console.log("fail 2 : ", settings);
		//console.log("fail 3 : ", exception);
	});




/* var result = window.open("/javascript/resources/view/popup.jsp", "", "width=150,height=150");
result.focus();
console.log("result : ", result); */

var aa = Number("");
//console.log("aa : ", aa);

var OBJ = function() {
	this.fn = {
		ip : "123",
		op : function() {
			console.log("aa");
		}
	};
}

var obj = new OBJ();
console.log(obj.fn.ip);
obj.fn.op();

</script>
