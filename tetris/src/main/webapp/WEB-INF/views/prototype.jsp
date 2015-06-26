<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js" ></script>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
<style>
table {
    border-style: solid;
    border-width: 5px;
    width: 30%;
    height: 70%;
}

td {
	border-style: solid;
    border-width: 1px;
}

</style>
</head>
<body>

</body>
</html>
<script type="text/javascript">
var A = function() { }
var B = new A();
A.prototype.x = "hello";
console.log(B);

var C = function() {
	this.x = "hello";
	this.z = function() { return this.x }
}
var D = new C();
C.prototype.y = "world";
console.log(D);
console.log(D.z());
console.log(D.y);
</script>
