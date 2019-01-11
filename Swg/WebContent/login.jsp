<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width ,initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Do what</title>
<style type="text/css">
 a:hover { text-decoration: underline;}
 a:link { text-decoration: none;}
</style>
</head>
<body>

	<!-- Nav쪽 -->
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <div class="navbar-header">
	    	<button type="button" class="navbar-toggle collapsed" 
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			</button>
			<a href="https://github.com/sinwonkim"><img src="images/unp2.PNG" alt="이미지 " style="width:50px;height:50px; font-style: lightblue">sinwon's git</a>
	    </div>
	    <div>
	    </div>
	    <div  id="#bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav" >
	        <li><a class="navbar-brand " href="main.jsp"  style="margin-left:0px;">Home</a></li>
	        <li><a href="#">2번 메뉴</a></li> 
	        <li><a href="boardList.jsp">게시판</a></li> 
	      </ul>
	    </div>
	    <ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="btn dropdown-toggle"  data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expended="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu" style="min-width: 80px;">
						<li class="active"><a href="login.jsp">로그인</a></li> 
						<li ><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
		</ul>		
	  </div>
	</nav>
	
	<!-- 로그인 폼  -->
	<div class="container">
      <form class="form-signin" method="post" action="loginAction.jsp">
        <h2 class="form-signin-heading" style="text-align: center;">로그인 화면</h2>
        <label for="userID" class="sr-only">아이디</label>
        <input type="text" class="form-control" placeholder="아이디" id="userID" name="userID" required autofocus>
        <label for="userPassword" class="sr-only">비밀번호</label>
        <input type="password" class="form-control" placeholder="비밀번호" id="userPassword" name="userPassword" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" value="로그인">로그인</button>
      </form>
    </div> <!-- /container -->
<script
  src="https://code.jquery.com/jquery-1.12.4.js" ></script>
 <script src="js/bootstrap.min.js"></script>
</body>
</html>