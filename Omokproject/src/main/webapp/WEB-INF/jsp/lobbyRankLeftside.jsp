<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
	function logout(){
		if(confirm("로그아웃 하시겠습니까??")){
			alert("로그아웃 되었습니다!");
			location.href='logout.do';
		}
	}
</script>
  <div class="leftSide">
    <div id="profileContainer">
      <div id="profileImg">
        <img src="/project/image/lobby_rank_profile_img.png">
      </div>
      <div id="profileBox">
        <div id="profileInfo">
          <p class="font_title">${loginSess.nickname} 님</p>
          <h3>${loginSess.victory}승 ${loginSess.total - loginSess.victory}패 (<fmt:formatNumber value="${loginSess.victory/loginSess.total*100}" pattern=".00"/>%)</h3>
        </div>
        <div id="buttonsWrapper">
          <button id="profileButton" onclick="logout()">로그아웃</button>
          <button id="profileButton" onclick="location.href='updateInfo.do'">정보 수정</button>
        </div>
      </div>
    </div>
    <img src="/project/image/square_logo.png" class="logo">
  </div>