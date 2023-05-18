<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로비: 랭크</title>
  <link href="../image/square_logo.png" rel="shortcut icon" type="image/x-icon">
  <link rel="stylesheet" href="/project/css/reset.css" />
  <link rel="stylesheet" href="/project/css/common.css">
  <link rel="stylesheet" href="/project/css/lobbyRankLeftside.css">
  <link rel="stylesheet" href="/project/css/rank.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script type="text/javascript" src="../js/modal.js"></script>
  <script type="text/javascript">
    var num =${num};
    function left(){
		if(num == 1){
			num = 1;
			location.href="rank.do?num="+num;	
		}else{
			num -= 1;
			location.href="rank.do?num="+num;
			
		}
	};
    
    function right(){
    	if( ${total}<= 5*num){
    		location.href="rank.do?num="+num;
    	}else{
    		num= num+1;
    		location.href="rank.do?num="+num;
    	}
	};
	 
  </script>
  
</head>
<body>
  <div class="wrap">
    <div id="leftSideWrapper">
   		<%@include file="/WEB-INF/jsp/lobbyRankLeftside.jsp" %>
    </div>

    <div class="rightSide">
      <button class="reloadButton" type="button" onclick="window.location.reload()"></button>
      <div class="contents">
        <div class="menu">
          <div class="hideContents">
            <button class="bigButton notNow" onclick="location.href='lobby'">방목록</button>
          </div>
          <div class="contents1">
            <button class="bigButton" onclick="location.href='rank.do?num=1'">랭킹</button>
          </div>
        </div>
        <div class="contents2">
          <div class="rankList">
            <table class="rankTable rankTh">
              <tr>
                <th>랭크</th>
                <th>아이디</th>
                <th>닉네임</th>
                <th><button id="changing" class="changeSortButton">승수</button></th>
              </tr>
            </table>
            <table class="rankTable rankTd">
              <!-- tr이 for문으로 반복되어야 함 -->
              <c:forEach var="vo" items="${list}">
				<tr>
					<td>${vo.rnum }</td>
					<td>${vo.id }</td>
					<td>${vo.nickname }</td>
					<td id="vtr">${vo.victory }</td>
				</tr>
			</c:forEach>
              <!-- 여기까지 for문 -->
            </table>
          </div>
          <div class="pageMoveButtonsWrapper">
            <button class="green_button pageMoveButton" onclick="left()">&lt;</button>
            <button class="green_button pageMoveButton" onclick="right()">&gt;</button>
            
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>