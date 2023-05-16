<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>ȸ������</title>
    <link href="/project/image/square_logo.png" rel="shortcut icon" type="image/x-icon">
    <link rel="stylesheet" href="/project/css/register.css" />
    <link rel="stylesheet" href="/project/css/reset.css" />
    <link rel="stylesheet" href="/project/css/common.css" />
  </head>

  <body>
    <div class="wrap">
      <!-- header -->
      <div id="header">
        <img src="/project/image/org_logo.png" id="logo"/>
      </div>

      <!-- wrapper -->
      <div id="wrapper">
        <form class="reg_form" method="post" action="">
          <!-- content-->
          <div id="content">
            <!-- ID -->
            <div>
              <h3 class="join_title">
                <label for="id">���̵�</label>
              </h3>
              <span class="reg_login_input">
                <input type="text" id="id" class="int" maxlength="20" />
                <!-- <span class="step_url">@omok.com</span> -->
              </span>
              <span class="input_error"></span>
            </div>

            <!-- PW1 -->
            <div>
              <h3 class="join_title"><label for="pswd1">��й�ȣ</label></h3>
              <span class="reg_login_input">
                <input type="text" id="pswd1" class="int" maxlength="20" />
                <!-- <span id="alertTxt">���Ұ�</span> -->
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
                <label for="pswd2">��й�ȣ ��Ȯ��</label>
              </h3>
              <span class="reg_login_input_check">
                <input type="text" id="pswd2" class="int" maxlength="20" />
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
              <h3 class="join_title"><label for="name">�г���</label></h3>
              <span class="reg_login_input">
                <input type="text" id="name" class="int" maxlength="20" />
              </span>
              <span class="input_error"></span>
            </div>

            <!--                 
                <div>
                    <h3 class="join_title"><label for="yy">�������</label></h3>

                    <div id="bir_wrap">
                        
                        <div id="bir_yy">
                            <span class="box">
                                <input type="text" id="yy" class="int" maxlength="4" placeholder="��(4��)">
                            </span>
                        </div>

                        
                        <div id="bir_mm">
                            <span class="box">
                                <select id="mm" class="sel">
                                    <option>��</option>
                                    <option value="01">1</option>
                                    <option value="02">2</option>
                                    <option value="03">3</option>
                                    <option value="04">4</option>
                                    <option value="05">5</option>
                                    <option value="06">6</option>
                                    <option value="07">7</option>
                                    <option value="08">8</option>
                                    <option value="09">9</option>                                    
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </span>
                        </div>

                        
                        <div id="bir_dd">
                            <span class="box">
                                <input type="text" id="dd" class="int" maxlength="2" placeholder="��">
                            </span>
                        </div>

                    </div>
                    <span class="input_error"></span>    
                </div>

                
                <div>
                    <h3 class="join_title"><label for="gender">����</label></h3>
                    <span class="box gender_code">
                        <select id="gender" class="sel">
                            <option>����</option>
                            <option value="M">����</option>
                            <option value="F">����</option>
                        </select>                            
                    </span>
                    <span class="input_error">�ʼ� �����Դϴ�.</span>
                </div>

                
                <div>
                    <h3 class="join_title"><label for="email">����Ȯ�� �̸���<span class="optional">(����)</span></label></h3>
                    <span class="box int_email">
                        <input type="text" id="email" class="int" maxlength="100" placeholder="�����Է�">
                    </span>
                    <span class="input_error">�̸��� �ּҸ� �ٽ� Ȯ�����ּ���.</span>    
                </div>

                
                <div>
                    <h3 class="join_title"><label for="phoneNo">�޴���ȭ</label></h3>
                    <span class="box int_mobile">
                        <input type="tel" id="mobile" class="int" maxlength="16" placeholder="��ȭ��ȣ �Է�">
                    </span>
                    <span class="input_error"></span>    
                </div> -->

            <div class="space"></div>
            <button
              type="button"
              id="btnJoin"
              class="green_button"
              style="background-color: #bddc89"
            >
              �����ϱ�
            </button>
            <div class="space"></div>
            <button type="button" id="btnJoin" class="green_button" onclick="history.go(-1)">
              ������
            </button>
          </div>
          <!-- content-->
        </form>
      </div>
    </div>
    <!-- wrapper -->
    <script src="/project/js/main.js"></script>
  </body>
</html>
