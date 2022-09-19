<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp"%>
		<div class="row g-0">
	  		<div class="col-sm-6 col-md-8">
	  			<div class="alert alert-danger" role="alert">회원 로그인</div>
	  		</div>
	  		<div class="col-6 col-md-4"></div>
		</div>		
		<form action="loginok.jsp" method="post">
		<div class="row mb-3">
			<label for="ckid" class="col-sm-1 col-form-label text-primary">아이디</label>
			<div class="col-sm-2">
				<input type="text" name="id" id="ckid" class="form-control">
			</div>		
		</div>
		<div class="row mb-3">
			<label for="ckid" class="col-sm-1 col-form-label text-primary">비밀번호</label>
			<div class="col-sm-2">
				<input type="password" name="pwd" id="pwd" class="form-control">
			</div>
		</div>
		<div class="d-grid gap-2 col-5 mx-auto">
    		<button type="submit" class="btn btn-primary">로그인</button>
    	</div>
		</form>
		<div style="height:50px;"></div>
<%@ include file="bottom.jsp"%>			