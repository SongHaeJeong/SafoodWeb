<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<header>
	<div class="header_dimmed_bg">
		<div class="header_wrapper">
			<div class="brand_logo">
				<a href="/main.safood"><img src="/img/safood_logo.png" alt="logo"/></a>
			</div>
			<nav>
				<ul class="nav_menu">
					<li><router-link to="/foods"><a>식품 정보</a></router-link></li>
					<li><a href="main.safood">내 섭취 정보</a></li>
					<li><router-link to="/board/qna"><a>게시판</a></router-link></li>
				</ul>
			</nav>
		</div>
	</div>
	<div class="color_line">
	</div>
</header>
