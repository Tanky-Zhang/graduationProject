<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="C" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="留学生入学通知书管理">
    <meta name="author" content="张中国">
    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/Login/reset.css">
    <%--<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">--%>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/Login/style.css">
    <script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
    <!-- Javascript -->
    <script src="<%=basePath%>js/Login/scripts.js"></script>

    <style>
     .login {

         width: 150px !important;

     }
    </style>

</head>
<body>
<div class="page-container">
    <h1>留学生入学通知书管理系统</h1>
    <form action="${pageContext.request.contextPath }/user/login.action" method="post">
        <input type="text" name="userName" class="username" placeholder="Username" id="username">
        <input type="password" name="passWord" class="password" placeholder="Password" id="password">
        <div>
        <button type="submit" id="sub_btn" class="login">登录</button>
            <button type="button" id="reg_btn" class="login">注册</button>
        </div>
    </form>

</div>

<script>

    $("#reg_btn").click(function () {

        window.location.href = "${pageContext.request.contextPath }/user/showRegist.action";

    })
</script>
</body>
</html>
