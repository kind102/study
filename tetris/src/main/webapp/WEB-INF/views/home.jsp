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
	<c:forEach var="i" begin="0" step="1" end="14">
		<tr>
			<c:forEach var="j" begin="0" step="1" end="8">
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
var maxRow = 14;
var maxCol = 8;
var timerId;
var endGame = false;
var newBlockTimerId;

for (var i=0; i<=maxRow; i++)
	tetrisArray[i] = new Array('0','0','0','0','0','0','0','0','0');

$(function(){
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
		process(key);
		$('#keyCode').text(key);
		$('#direction').text(direction);
    });
});


var BLOCK = function(pRow, pCol, pColor) {
    var _row = Number(pRow);
    var _col = Number(pCol);
	var _color = pColor;
    $("#"+_row+_col).css('background', _color);

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
    	$("#"+_row+_col).css('background', '');
    }

    this.setLocation = function(row, col){
    	_row += row;
    	_col += col;
    }

    this.print = function(){
    	$("#"+_row+_col).css('background', _color);
    }

};

function GROUP_BLOCK() {
	var _kindBlock = {
	                   0 : {
	                	   block : ['0,2', '1,2', '1,3', '2,3'],
	                	   turn : {
							   0 : ['-1,1', '0,0', '1,1', '2,0'],
		                	   1 : ['1,1', '0,0', '1,-1', '0,-2'],
							   2 : ['1,-1', '0,0', '-1,-1', '-2,0'],
							   3 : ['-1,-1', '0,0', '-1,1', '0,2']
	                	   },
	                	   color : "blue"
	                   },
	                   1 : {
	                	   block : ['0,2', '1,2', '2,2', '2,3'],
	                	   turn : {
	                		   0 : ['-1,1', '0,0', '1,-1', '2,0'],
	                		   1 : ['1,1', '0,0', '-1,-1', '0,-2'],
		                	   2 : ['1,-1', '0,0', '-1,1', '-2,0'],
							   3 : ['-1,-1', '0,0', '1,1', '0,2']
	                	   },
	                	   color : "red"
	                   },
	                   2 : {
	                	   block : ['0,2', '0,3', '1,2', '1,3'],
	                	   turn : {
							   0 : ['0,0', '0,0', '0,0', '0,0'],
		                	   1 : ['0,0', '0,0', '0,0', '0,0'],
							   2 : ['0,0', '0,0', '0,0', '0,0'],
							   3 : ['0,0', '0,0', '0,0', '0,0']
	                	   },
	                	   color : "yellow"
	                   },
	                   3 : {
	                	   block : ['0,2', '1,2', '2,2', '3,2'],
	                	   turn : {
							   0 : ['-1,1', '0,0', '1,-1', '2,-2'],
		                	   1 : ['1,1', '0,0', '-1,-1', '-2,-2'],
							   2 : ['1,-1', '0,0', '-1,1', '-2,2'],
							   3 : ['-1,-1', '0,0', '1,1', '2,2']
	                	   },
	                	   color : "green"
	                   },
	                   4 : {
	                	   block : ['0,3', '1,2', '1,3', '2,2'],
	                	   turn : {
							   0 : ['-1,-1', '1,-1', '0,0', '2,0'],
		                	   1 : ['1,-1', '1,1', '0,0', '0,2'],
							   2 : ['1,1', '-1,1', '0,0', '-2,0'],
							   3 : ['-1,1', '-1,-1', '0,0', '0,-2']
	                	   },
	                	   color : "orange"
	                   },
	                   5 : {
	                	   block : ['0,3', '1,3', '2,2', '2,3'],
	                	   turn : {
							   0 : ['-1,1', '0,0', '0,-2', '1,-1'],
		                	   1 : ['1,1', '0,0', '-2,0', '-1,-1'],
							   2 : ['1,-1', '0,0', '0,2', '-1,1'],
							   3 : ['-1,-1', '0,0', '2,0', '1,1']
	                	   },
	                	   color : "purple"
	                   }
	                  };

	var _bos = [];
	var turnState = 0;
	var block = Math.floor(Math.random() * 6);
	var color = "";

	this.create = function() {
		color = _kindBlock[block].color;
		for (var i in  _kindBlock[block].block) {
			var str = _kindBlock[block].block[i].split(",");
			_bos[i] = new BLOCK(str[0], str[1], color);
		}
	}

	this.getGroupInfo = function() {
		return _bos;
	}

	this.getTurn = function() {
    	return turnState;
    }

    this.setTurn = function(state) {
    	turnState = state;
    }

    this.getTurnDatas = function(state) {
    	return _kindBlock[block].turn[state];
    }

    this.getColor = function() {
    	return color;
    }

    this.getBlockInfo = function() {
    	return _kindBlock[block].block;
    }
}

/* var gbo = new GROUP_BLOCK();
gbo.create(); */
var gbo;
createBlock();

function createBlock() {
	clearInterval(timerId);
	gbo = new GROUP_BLOCK();
	if (createCheckRange()) {
		gbo.create();
		timerId = setInterval("process(40)", 1000);
	} else {
		gbo = null;
		theEndTetris();
	}
}

function process(key) {
	if (key === 38)
		turnBlock();
	else setGroupBlock(key);

	if (endGame === true) return false;
	if (key > 32) {
		setTimeout("newBlockTimeout()", 5000);
	} else {
		newBlock();
		if (endGame === false)
			checkBlock();
	}
}

function newBlockTimeout() {
	newBlock();
	if (endGame === false)
		checkBlock();
}

function setGroupBlock(key) {
	var groupBlock = gbo.getGroupInfo();
	var movePoint = 1;
	if (key === 32)
		movePoint = getMovePoint(groupBlock);
	if (checkRange(key)) {
		for (var i in groupBlock) {
			actGroupBlock(groupBlock[i], key, movePoint)
		}
		for (var i in groupBlock) {
			groupBlock[i].print();
		}
	}
}

function createCheckRange() {
	var blockInfo = gbo.getBlockInfo();
	for (var i in blockInfo) {
		var str = blockInfo[i].split(",");
		var col = Number(str[1]);
		if(tetrisArray[0][col] != '0')
			return false;
	}
	return true;
}

function checkRange(key) {
	var bo = gbo.getGroupInfo();
	var booln = true;
	for (var i in bo) {
		switch(key){
	        case 37:
	        	if(bo[i].getCol() === 0 || tetrisArray[bo[i].getRow()][bo[i].getCol()-1] != '0' ||
	        			tetrisArray[bo[i].getRow()][bo[i].getCol()-1] == 'undefined')
	        		booln = false;
	            break;
	        case 39:
	        	if(bo[i].getCol() === maxCol || tetrisArray[bo[i].getRow()][bo[i].getCol()+1] != '0' ||
	        			tetrisArray[bo[i].getRow()][bo[i].getCol()+1] == 'undefined')
	        		booln = false;
	            break;
	        case 40:
	        	if(bo[i].getRow() === maxRow || tetrisArray[bo[i].getRow()+1][bo[i].getCol()] != '0' ||
	        			tetrisArray[bo[i].getRow()+1][bo[i].getCol()] == 'undefined')
	        		booln = false;
	            break;
	        default:
	            direction = 'none';
	            break;
		}
		if (booln === false)
			break;
	}
	return booln;
}

function actGroupBlock(bo, key, movePoint) {
	bo.removeNowLocation();
	switch(key){
        case 37:
       		bo.setLocation(0,movePoint*-1);
            break;
        case 39:
       		bo.setLocation(0,movePoint);
            break;
        case 32:
        case 40:
       		bo.setLocation(movePoint,0);
            break;
        default:
            direction = 'none';
            break;
	}
}

function turnBlock() {
	var state = gbo.getTurn();
	if (state === 3)
		gbo.setTurn(0);
	else gbo.setTurn(state+1);

	var turnDatas = gbo.getTurnDatas(gbo.getTurn());
	var groupBlock = gbo.getGroupInfo();
	var addRow = 0;
	var addCol = 0;
	var booln = true;
	for (var i=turnDatas.length-1; i>=0; i--) {
		var cStr = turnDatas[i].split(",");
		var cRow = groupBlock[i].getRow() + Number(cStr[0]);
		var cCol = groupBlock[i].getCol() + Number(cStr[1]);
		if (tetrisArray[cRow][cCol] != '0' || cRow < 0 || cRow > maxRow ||
				cCol < 0 || cCol > maxCol) {
			booln = false;
			break;
		}
	}
	if (booln) {
		for (var i=turnDatas.length-1; i>=0; i--) {
			var str = turnDatas[i].split(",");
			var row = Number(str[0]);
			var col = Number(str[1]);
			groupBlock[i].removeNowLocation();
			groupBlock[i].setLocation(row, col);
			groupBlock[i].print();
		}
	} else {
		gbo.setTurn(state);
	}
}

function newBlock() {
	var groupBlock = gbo.getGroupInfo();
	for (var i in groupBlock) {
		if (groupBlock[i].getRow() === maxRow) {
			setArray();
			createBlock();
			break;
		} else {
			var postBlock = tetrisArray[groupBlock[i].getRow()+1][groupBlock[i].getCol()];
			if(postBlock != '0') {
				setArray();
				createBlock();
				break;
			}
		}
	}
}

function setArray() {
	var groupBlock = gbo.getGroupInfo();
	for (var i in groupBlock) {
		var color = $('#'+groupBlock[i].getRow()+groupBlock[i].getCol()).css('background');
		tetrisArray[groupBlock[i].getRow()][groupBlock[i].getCol()] = color;
	}
}

function checkBlock() {
	var count = 0;
	var start_point = -1;
	var end_point = -1;
	var movePoint = 0;
	var booln = false;
	for (var i=tetrisArray.length-1; i>=0; i--) {
		for (var j in tetrisArray[i]) {
			if(tetrisArray[i][j] != '0')
				count += 1;
			if(count === maxCol+1) {
				if(booln) {
					booln = false;
					movePoint += start_point + 1 - end_point;
					start_point = -1;
					end_point = -1;
				}

				printPoint();
				clearBlock(i);
				if (start_point === -1) {
					start_point = i;
					end_point = i;
				} else end_point = i;
				break;
			}
		}
		if (count < maxCol+1 && start_point >= 0 && count > 0) {
			booln = true;
			changeBlock(i, start_point + 1 - end_point + movePoint);
		}
		count = 0;
	}
}

function clearBlock(row) {
	for(var i=0; i<=maxCol; i++) {
		tetrisArray[row][i]= '0';
		$("#"+row+i).css('background', '');
	}
}

function changeBlock(row, point) {
	for (var j in tetrisArray[row]) {
		if(tetrisArray[row][j] != '0') {
			var color = tetrisArray[row][j];
			tetrisArray[row][j] = '0';
			$("#"+row+j).css('background', '');

			tetrisArray[row+point][j] = color;
			$("#"+(row+point)+j).css('background', color);
		}
	}
}

function theEndTetris() {
	endGame = true;
	for (var i in tetrisArray) {
		for (var j in tetrisArray[i]) {
			if(tetrisArray[i][j] != '0') {
				tetrisArray[i][j] = 'rgb(102,102,102)';
				$("#"+i+j).css('background', 'rgb(102,102,102)');
			} else {
				tetrisArray[i][j] = 'rgb(204,204,204)';
				$("#"+i+j).css('background', 'rgb(204,204,204)');
			}
		}
	}
}

function getMovePoint(groupBlock) {
	var movePoint = maxRow;
	for (var i in groupBlock) {
		var row = groupBlock[i].getRow();
		var col = groupBlock[i].getCol();
		if (movePoint > maxRow - row)
			movePoint = maxRow - row;
		for (var j=row+1; j<=maxRow; j++) {
			if (tetrisArray[j][col] != '0') {
				var value = j - row - 1;
				if (movePoint > value)
					movePoint = value;
				break;
			}
		}
	}
	return movePoint;
}

function printPoint() {
	/* points += 5;
	$("#point").text("현재 점수 : " + points);

	if (points > 15)
		$("#end").html("<h2>...  그만해 ;;;;;</h2>"); */
}
</script>
