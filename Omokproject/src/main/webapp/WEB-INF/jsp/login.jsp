<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link href="/project/image/square_logo.png" rel="shortcut icon" type="/project/image/x-icon">
    <link rel="stylesheet" href="/project/css/reset.css">
    <link rel="stylesheet" href="/project/css/common.css">
    <link rel="stylesheet" href="/project/css/login.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script>
		function check(){
			if($("#id").val().trim()==''){
    			alert("아이디를 입력해 주세요");
    			console.log(1);
    			$("#id").focus();
    			return false;
    		}
    		if($("#password").val().trim()==''){
    			alert("비밀번호를를 입력해 주세요");
    			console.log(1);
    			$("#password").focus();
    			return false;
    		}
    	}
    </script>
</head>
<body>
    <div class="wrap" id="wrap">
        <!-- 로그인 -->
        <div class="login">
          <form action="login.do" method="post" onsubmit="return check();">
            <img height=200px src="/project/image/login_mococo.gif">
            <div class="font_title">로그인</div>
            <br>
            <div class="input_wrapper">
                <input class="reg_login_input login_input" type="text" id="id" name="id" placeholder=" ID"/>
                <input class="reg_login_input login_input" type="password" id="password" name="password" placeholder=" PASSWORD"/>
                <div class="input_error">
                    아이디 또는 비밀번호가 잘못 되었습니다.
                </div>
            </div>
            <br>
            <div class="button_wrapper">
                <input class="green_button login_button submit" type="submit" value="접속">
                <button type="button" class="green_button login_button" onClick="location.href='register.do'">회원가입</button>
            </div>
          </form>
        </div>
        <!-- 랭킹 -->
        <div class="ranking">
            <div class="logo">
                <img src="/project/image/org_logo.png">
            </div>
            <br>
            <div class="font_title scroll-text">
                <p class="p">명예의 전당</p>
            </div>
          <div class="rank_card" style="background-color: #ffe000;"><img src="/project/image/login_gold.png"><span>Username_1</span></div>
          <div class="rank_card" style="background-color: #d5d5d5;"><img src="/project/image/login_silver.png"><span>Username_2</span></div>
          <div class="rank_card" style="background-color: #f09f49;"><img src="/project/image/login_bronze.png"><span>Username_3</span></div>
          <div class="rank_card"><span>Username_4</span></div>
          <div class="rank_card"><span>Username_5</span></div>
   		</div>
   </div>  
</body>
</html>