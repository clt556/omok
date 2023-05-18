<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/project/css/reset.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <title>회원가입</title>
    <link href="/project/image/square_logo.png" rel="shortcut icon" type="image/x-icon">
    <link rel="stylesheet" href="/project/css/style.css"/>
    <link rel="stylesheet" href="/project/css/contents.css"/>
    <link rel="stylesheet" href="/project/css/register.css"/>
    <link rel="stylesheet" href="/project/css/common.css"/>
    <script src="/project/js/common.js"></script>
    <script>
    	function idCheck() {
    		if ($("#id").val().trim() == "") {
    			alert("아이디를 입력하세요");
    			$("#id").focus();
    		}else {
    			$.ajax({
        			url: 'dupCheck.do?id='+$("#id").val(),
        			success : function(res) {
        				if (res == 'usable') {
        					alert('사용가능');
        				} else {
        					alert('사용불가');
        					$("#id").val(""); 
        				}
        			}		
        		});
    		}
    	}
    	
    	function goSave() {
    		if($("#id").val().trim() == '') {
    			alert('아이디를 입력하세요');
    			$("#id").focus();
    			return;
    		}
    		let con = true;
    		$.ajax({
    			url: 'dupCheck.do?id='+$("#id").val(),
    			async: false,
    			success : function(res) {
    				if (res == 'notusable') {
    					alert('아이디가 중복되었습니다.');
    					$("#id").val(""); 
    					con = false;
    				}
    			}		
    		});
    		if(!con) return;
    		if($("#password").val().trim() == '') {
    			alert('비밀번호를 입력하세요');
    			$("#password").focus();
    			return;
    		}
    		if($("#pswd2").val().trim() == '') {
    			alert('비밀번호 확인을 입력하세요');
    			$("#pswd2").focus();
    			return;
    		}
    		if($("#password").val() != $("#pswd2").val()) {
    			alert("비밀번호와 비밀번호 확인값이 다릅니다.")
    			$("#pswd2").val("");
    			$("#pswd2").focus();
    			return;
    		}
    		if($("#name").val().trim() == '') {
    			alert('닉네임을 입력하세요');
    			$("#name").focus();
    			return;
    		}
    		if (confirm('가입하시겠습니까?')) {
    			$("#frm").submit();
    		}
    	}
    	$(function() {
    	    $( "#birthday" ).datepicker({
    	         changeMonth: true, 
    	         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
    	         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
    	         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
    	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    	         dateFormat:"yy-mm-dd"
    	  });
    	});
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function zipcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    addr += extraAddr;
	                
	                } else {
	                    //document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zipcode').value = data.zonecode;
	                document.getElementById("addr1").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("addr2").focus();
	            }
	        }).open();
	    }
	</script>
 
</head>
<body>
    <div class="wrap">

 <!-- header -->
      <div id="header">
        <img src="/project/image/org_logo.png" id="logo"/>
      </div>

      <!-- wrapper -->
      <div id="wrapper">
        <form name="frm" id ="frm" action="regist.do" class="reg_form" method="post" enctype="multipart/form-data">
          <!-- content-->
          <div id="content">
            <!-- ID -->
            <div>
              <h3 class="join_title">
                <label for="id">아이디</label>
              </h3>
              <span class="reg_login_input">
                <input type="text" name="id" id="id" class="int" maxlength="20" />
                <!-- <span class="step_url">@omok.com</span> -->
              </span>
              <span class="input_error"></span>
              <span class="id_check"><a href="javascript:idCheck();"  class="btn bgGray" style="float:right; width:auto; clear:none; background-color: #bddc89">중복확인</a></span>
            </div>

            <!-- PW1 -->
            <div>
              <h3 class="join_title"><label for="password">비밀번호</label></h3>
              <span class="reg_login_input">
                <input type="password" name = "password" id="password" class="int" maxlength="20" />
                <!-- <span id="alertTxt">사용불가</span> -->
                <!-- <img
                src="../image/m_icon_pass.png"
                id="pswd1_img1"
                class="pswdImg"
              /> -->
              </span>
              <span class="input_error"></span>
            </div>

            <!-- PW2 -->
            <div>
              <h3 class="join_title">
                <label for="pswd2">비밀번호 재확인</label>
              </h3>
              <span class="reg_login_input_check">
                <input type="password" id="pswd2" class="int" maxlength="20" />
                <!-- <img
                src="../image/m_icon_check_disable.png"
                id="pswd2_img1"
                class="pswdImg"
              /> -->
              </span>
              <span class="input_error"></span>
            </div>

            <!-- NAME -->
            <div>
              <h3 class="join_title"><label for="name">닉네임</label></h3>
              <span class="reg_login_input">
                <input type="text" name="nickname" id="name" class="int" maxlength="20" />
              </span>
              <span class="input_error"></span>
            </div>


            <div class="space"></div>
            <button
              type="button"
              id="btnJoin"
              class="green_button"
              style="background-color: #bddc89"
              onclick="goSave();"
            >
              가입하기
            </button>
            <div class="space"></div>
            <button type="button" id="btnJoin" class="green_button" onclick="history.go(-1)">
              나가기
            </button>
            
          </div>
          <!-- content-->
        </form>
      </div>
    </div>
    <!-- wrapper -->
    <script src="/project/js/main.js"></script>
      
    </div>
</body>
</html>