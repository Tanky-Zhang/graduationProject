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

    <%--引入弹出提示框的js和css--%>
    <link href="${pageContext.request.contextPath }/bootstrap/css/toastr.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/bootstrap/js/toastr.js"></script>

    <style>
     .login {

         width: 150px !important;

     }
     .toast-center-center {
         margin-top: -138px !important;
     }
    </style>

</head>
<body>
<div class="page-container">
    <h1>留学生入学通知书管理系统</h1>
    <form>
        <input type="text" name="userName" class="username" placeholder="Username" id="username">
        <input type="password" name="passWord" class="password" placeholder="Password" id="password">
        <div>
        <button type="button" id="sub_btn" class="login">登录</button>
        <button type="button" id="reg_btn" class="login">注册</button>
        </div>
    </form>

</div>

<script>


    $(function () {

        $("#reg_btn").click(function () {

            window.location.href = "${pageContext.request.contextPath }/user/showRegist.action";

        })

        $("#sub_btn").click(function () {

            var username=$("#username").val();

            if (username==""||username==null){

                toastr.warning('用户名不能为空！');

                return 0;

            }

            var  password=$("#password").val();

            if (password==""||password==null){

                toastr.warning('密码不能为空！');

                return 0;

            }

            $.ajax({

                url: "${pageContext.request.contextPath }/user/login.action",

                type:  "post",

                async: false,

                data: {

                    "userName": $("#username").val(),
                    "passWord":$("#password").val()

                },
                success: function (data) {

                    if (data=="error"){


                        toastr.error('用户名或密码错误，请验证！');


                    }else {

                        window.location.href="${pageContext.request.contextPath}/user/print.action";


                    }

                },
                error: function () {

                    toastr.error('修改密码失败');
                }
            });

        })
        
    })

    $(function () {


        //初始化弹框
        toastr.options = {
            "closeButton": false,//显示关闭按钮
            "debug": false,//启用debug
            "positionClass": "toast-center-center",//弹出的位置
            "showDuration": "300",//显示的时间
            "hideDuration": "500",//消失的时间
            "timeOut": "2000",//停留的时间
            "extendedTimeOut": "1000",//控制时间
            "showEasing": "swing",//显示时的动画缓冲方式
            "hideEasing": "linear",//消失时的动画缓冲方式
            "showMethod": "fadeIn",//显示时的动画方式
            "hideMethod": "fadeOut"//消失时的动画方式

        };

    })

</script>
</body>
</html>
