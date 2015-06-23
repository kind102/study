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
var maxRow = 14
var maxCol = 8

$(function(){
	for (var i=0; i<=maxRow; i++)
		tetrisArray[i] = new Array('0','0','0','0','0','0','0','0','0');

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
        //setBlock(key);
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
    	//console.log("remove1 : #"+_row+_col);
    	$("#"+_row+_col).css('background', '');
    	//console.log("remove2 : #"+_row+_col);
    }

    this.setLocation = function(row, col){
    	//console.log("next move1 : ", row, col);
    	_row += row;
    	_col += col;
    	//console.log("next move2 : ", _row, _col);
    }

    this.print = function(){
    	//console.log("#"+_row+_col);
    	$("#"+_row+_col).css('background', _color);
    }

};

//var bo = new BLOCK(0, 0);

function GROUP_BLOCK() {
	var _kindBlock = [['0,2', '1,2', '1,3', '2,3'],
	                  ['0,2', '1,2', '2,2', '2,3'],
	                  ['0,2', '1,2', '2,2', '3,2'],
	                  ['0,2', '0,3', '1,2', '1,3'],
	                  ['0,3', '1,2', '1,3', '2,2'],
	                  ['0,3', '1,3', '2,2', '2,3']];

	var _kindBlock1 = {
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
	var block = -1;
	var color = "";

	this.create = function() {
		block = Math.floor(Math.random() * 6);
		color = _kindBlock1[block].color;
		for (var i in  _kindBlock1[block].block) {
			var str = _kindBlock1[block].block[i].split(",");
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
    	return _kindBlock1[block].turn[state];
    }

    this.getColor = function() {
    	return color;
    }
}

var gbo = new GROUP_BLOCK();
gbo.create();

function createBlock() {
	gbo = new GROUP_BLOCK();
	if(checkRange(40))
		gbo.create();
}

function process(key) {
	if (key === 38)
		turnBlock();
	else setGroupBlock(key);
	newBlock();
	//checkBlock();
	checkBlock_1();
}

function setGroupBlock(key) {
	var groupBlock = gbo.getGroupInfo();
	if (checkRange(key)) {
		for (var i in groupBlock) {
			actGroupBlock(groupBlock[i], key)
		}
		for (var i in groupBlock) {
			groupBlock[i].print();
		}
	}
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
	        	if(bo[i].getRow() === maxRow)
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

function actGroupBlock(bo, key) {
	bo.removeNowLocation();
	switch(key){
        case 37:
       		bo.setLocation(0,-1);
            break;
        case 39:
       		bo.setLocation(0,1);
            break;
        case 40:
       		bo.setLocation(1,0);
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
	//console.log("turnDatas : ", turnDatas);
	var groupBlock = gbo.getGroupInfo();
	//console.log("groupBlock : ", groupBlock);
	var addRow = 0;
	var addCol = 0;
	var booln = true;
	for (var i=turnDatas.length-1; i>=0; i--) {
		var cStr = turnDatas[i].split(",");
		var cRow = groupBlock[i].getRow() + Number(cStr[0]);
		var cCol = groupBlock[i].getCol() + Number(cStr[1]);
		//console.log("1 : ", cRow, cCol);
		if (tetrisArray[cRow][cCol] === 1 || cRow < 0 || cRow > maxRow ||
				cCol < 0 || cCol > maxCol) {
			booln = false;
			//console.log("2 : ", cRow, cCol, booln);
			break;
		}
		/*
		if (col < 0) {
			//addCol = 1;
			break;
		} else if (col > maxCol) {
			//addCol = -1;
			break;
		}
		 */
	}
	//console.log("3 : ", booln);
	if (booln) {
		for (var i=turnDatas.length-1; i>=0; i--) {
			var str = turnDatas[i].split(",");
			var row = Number(str[0]);
			var col = Number(str[1]);
			//console.log("b - ", groupBlock[i].getRow(), groupBlock[i].getCol(), " + ", row, col);
			groupBlock[i].removeNowLocation();
			groupBlock[i].setLocation(row, col);
			groupBlock[i].print();
			//console.log("a - ", groupBlock[i].getRow(), groupBlock[i].getCol());
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
		//console.log("color : ", color);
		tetrisArray[groupBlock[i].getRow()][groupBlock[i].getCol()] = color;
	}
}

function checkBlock() {
	var count = 0;
	var start_point = -1;
	var end_point = -1;
	for (var i in tetrisArray) {
		for (var j in tetrisArray[i]) {
			if(tetrisArray[i][j] != '0')
				count += 1;
			if(count === maxCol+1) {
				printPoint();
				clearBlock(i);
				if (start_point === -1) {
					start_point = i;
					end_point = i;
				} else end_point = i;
				break;
			}
		}
		count = 0;
	}
	//console.log("check : ", start_point, end_point);
	changeBlock(start_point, end_point);
}

function checkBlock_1() {
	console.log();
	var count = 0;
	var start_point = -1;
	var end_point = -1;
	var point = 0;
	var booln = false;
	for (var i=tetrisArray.length-1; i>=0; i--) {
		for (var j in tetrisArray[i]) {
			if(tetrisArray[i][j] != '0')
				count += 1;
			if(count === maxCol+1) {
				if(booln) {
					booln = false;
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
			console.log("check : ", start_point ,end_point, ", point : " + point);
			changeBlock_1(i, start_point + 1 - end_point + point);
		}
		//break;
		count = 0;
	}
}

function clearBlock(row) {
	for(var i=0; i<=maxCol; i++) {
		tetrisArray[row][i]= '0';
		$("#"+row+i).css('background', '');
	}
}

function changeBlock(start, end) {
	//console.log("change : ", start, end);
	for (var i=start-1; i>=0; i--) {
		for (var j in tetrisArray[i]) {
			if(tetrisArray[i][j] != '0') {
				var color = tetrisArray[i][j];
				tetrisArray[i][j] = '0';
				//console.log("change rm : ", "#"+i+j);
				$("#"+i+j).css('background', '');

				tetrisArray[end][j] = color;
				//console.log("change set : ", "#"+start+j);
				$("#"+end+j).css('background', color);
			}
		}
		end--;
	}
}

function changeBlock_1(row, point) {
	console.log("change : ", row, point);
	for (var j in tetrisArray[row]) {
		if(tetrisArray[row][j] != '0') {
			var color = tetrisArray[row][j];
			tetrisArray[row][j] = '0';
			//console.log("change rm : ", "#"+i+j);
			$("#"+row+j).css('background', '');

			tetrisArray[row+point][j] = color;
			//console.log("change set : ", "#"+start+j);
			$("#"+(row+point)+j).css('background', color);
		}
	}
}

function printPoint() {
	/* points += 5;
	$("#point").text("현재 점수 : " + points);

	if (points > 15)
		$("#end").html("<h2>...  그만해 ;;;;;</h2>"); */
}
</script>
