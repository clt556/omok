<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.project.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<% Map<Integer, BoardVO> boards = (Map<Integer, BoardVO>) request.getAttribute("boards"); %>
<% List<Integer> keys = new ArrayList<>(boards.keySet()); 
   keys.sort((s1, s2) -> s1.compareTo(s2));
   int _page = (((Integer) request.getAttribute("page")) - 1) * 5;
   int prior = ((Integer) request.getAttribute("page")) - 1;
   int next = ((Integer) request.getAttribute("page")) + 1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="../image/square_logo.png" rel="shortcut icon" type="image/x-icon">
  <link rel="stylesheet" href="/project/css/reset.css" />
  <link rel="stylesheet" href="/project/css/common.css">
  <link rel="stylesheet" href="/project/css/lobbyRankLeftside.css">
  <link rel="stylesheet" href="/project/css/lobby.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script type="text/javascript" src="/project/js/modal.js"></script>
  <!-- <script type="text/javascript">
    $(document).ready(function() {
      $("#leftSideWrapper").load("lobbyRankLeftside.html");
    });
  </script> -->
  <title>로비 방목록</title>
</head>
<body>
  <div class="wrap">
    <div class="modal">
      <div class="modalContent">
        <form class="inputTitleWrapper" method="post" action="create">
        <h2>방 이름</h2>
          <input type="text" class="inputTitle" name="title" maxlength="15"/>
          <div class="modalButtonsWrapper">
            <input type="submit" value="생성" class="modalButton green_button"/>
            <button type="button" class="modalOutButton modalButton green_button">취소</button>
          </div>
        </form>
      </div>
    </div>

    <div id="leftSideWrapper">
		<%@include file="/WEB-INF/jsp/lobbyRankLeftside.jsp" %>
    </div>

    <div class="rightSide">
      <button class="reloadButton" type="button" onclick="window.location.reload()"></button>
      <div class="contents">
        <div class="menu">
          <div class="contents1">
            <button class="createGame bigButton">방만들기</button>
          </div>
          <div class="hideContents">
            <button class="bigButton notNow" onclick="location.href='rank.html'">랭킹</button>
          </div>
        </div>
        <div class="contents2">
          <div class="roomList">
            <% for (int i = _page; i < _page + 5; i++) {
		  		if (i >= keys.size()) break;
		  	%>
            <div class="room" onclick="location.href='game?roomNo=<%=keys.get(i) %>'">
              <div class="roomNo" <c:if test="${boards.get(keys.get(i)).player2 != null }">style="background-color:#54AD56;"</c:if>><%=keys.get(i) %></div>
              <div class="roomTitle" <c:if test="${boards.get(keys.get(i)).player2 != null }">style="background-color:#54AD56;"</c:if>><%=boards.get(keys.get(i)).title %> <c:if test="${boards.get(keys.get(i)).player2 == null }">(빈 방)</c:if></div>
            </div>
			<%} %>
          </div>
          <div class="pageMoveButtonsWrapper">
            <button class="green_button pageMoveButton" onclick="location.href='lobby?page=<%=prior %>'">&lt;</button>
            <button class="green_button pageMoveButton" onclick="location.href='lobby?page=<%=next %>'">&gt;</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>