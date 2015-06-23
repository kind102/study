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
<h1>
	Hello tetris world!
</h1>
<div id="point"></div>
<div id="end"></div>
<table>
	<c:forEach var="i" begin="0" step="1" end="9">
		<tr>
			<c:forEach var="j" begin="0" step="1" end="4">
				<td id="${i}${j}">
				</td>
			</c:forEach>
		</tr>
	</c:forEach>
</table>
<span id="keyCode"></span>
<span id="direction"></span>
</body>
</html>
<script type="text/javascript">
var tetrisArray = new Array();
var points = 0;
$(function(){
	for (var i=0; i<10; i++)
		tetrisArray[i] = new Array();

    $('html').keydown(function(e){
		//console.log(e.which);
        var key = e.which;
        var direction;
        switch(key){
            case 38:
                direction = "up";
                break;
            case 37:
                direction = 'left';
                break;
            case 39:
                direction = 'right';
                break;
            case 40:
                direction = 'down';
                break;
            default:
                direction = 'none';
                break;
        }
        setBlock(key);
       $('#keyCode').text(key);
       $('#direction').text(direction);

    });
});


var BLOCK = function(pRow, pCol) {
    var _row = pRow;
    var _col = pCol;
    $("#"+_row+_col).css('background', 'blue');

    this.getRow = function(){
    	return _row;
    }

    this.getCol = function(){
    	return _col;
    }

    this.setRow = function(value){
    	_row += value;
    }

    this.setCol = function(value){
    	_col += value;
    }

    this.getLocation = function(){
		return nowLocation();
    }

    nowLocation = function(){
    	return _row + "" + _col;
    }

    this.removeNowLocation = function(){
    	$("#"+nowLocation()).css('background', 'white');
    }

    this.setLocation = function(row, col){
    	_row += row;
    	_col += col;
    }

    this.print = function(){
    	$("#"+nowLocation()).css('background', 'blue');
    }
};

var bo = new BLOCK(0, 0);


var _kindBlock = [['02', '12', '13', '23'],
                  ['02', '12', '22', '23'],
                  ['02', '12', '22', '32'],
                  ['02', '03', '12', '13']
                  ];

function BLOCKS() {

}



function setBlock(key) {
	bo.removeNowLocation();
	switch(key){
		case 38:
			if(bo.getRow() > 0)
				bo.setLocation(0,0);
            break;
        case 37:
        	if(bo.getCol() === 0 || tetrisArray[bo.getRow()][bo.getCol()-1] === 1)
        		break;
        	//if(bo.getCol() > 0)
        		bo.setLocation(0,-1);
            break;
        case 39:
        	if(bo.getCol() === 4 || tetrisArray[bo.getRow()][bo.getCol()+1] === 1)
        		break;
        	//if(bo.getCol() < 4)
        		bo.setLocation(0,1);
            break;
        case 40:
        	if(bo.getRow() < 9)
        		bo.setLocation(1,0);
            break;
        default:
            direction = 'none';
            break;
	}
	bo.print();
	newBlock();
	checkBlock();
}

function newBlock() {
	if(bo.getRow() === 9) {
		setArray();
		bo = new BLOCK();
	} else {
		var postBlock = tetrisArray[bo.getRow()+1][bo.getCol()];
		if(postBlock === 1) {
			setArray();
			bo = new BLOCK();
		}
	}
}

function setArray() {
	tetrisArray[bo.getRow()][bo.getCol()] = 1;
}

function checkBlock() {
	var count = 0;
	for (var i in tetrisArray) {
		for (var j in tetrisArray[i]) {
			if(tetrisArray[i][j] === 1)
				count += 1;
			if(count === 5) {
				printPoint();
				clearBlock(i);
				break;
			}
		}
		count = 0;
	}
}

function clearBlock(row) {
	for(var i=0; i<5; i++) {
		tetrisArray[row][i]= 0;
		var col = bo.getCol() + i;
		console.log("#"+row+col);
		$("#"+row+col).css('background', 'white');
	}
	changeBlock();
}

function changeBlock() {
	for (var i=9; i>-1; i--) {
		for (var j in tetrisArray[i]) {
			if(tetrisArray[i][j] === 1) {
				tetrisArray[i][j] = 0;
				$("#"+i+j).css('background', 'white');

				var nextRow = i+1;
				tetrisArray[nextRow][j] = 1;
				$("#"+nextRow+j).css('background', 'blue');
			}
		}
	}
}

function printPoint() {
	points += 5;
	$("#point").text("현재 점수 : " + points);

	if (points > 15)
		$("#end").html("<h2>...  그만해 ;;;;;</h2>");
}
</script>
