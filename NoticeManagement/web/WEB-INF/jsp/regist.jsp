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
    <title>注册</title>
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
        #username{

              width: 160px;

          }
        #password{

            width: 160px;

        }
        #repassword{

            width: 160px;

        }
        #tip{

            width: 150px !important;

            margin-left: 120px !important;
        }

        #ptip{

            width: 150px !important;

            margin-left: 120px !important;
        }

    </style>

</head>

<body>

<script>

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

    function hideDiv(){

        $("#tip").hide();

    }
    function hidepDiv(){

        $("#ptip").hide();

    }



    function getPassword() {

        var  password=$("#password").val();
        
        if (password!=$("#repassword").val()){

            $("#ptip").show();

            $("#ptip").html("密码输入错误！");

            //$("#reg_btn").attr("disabled")

        }

    }

    function getuserName() {

        var username=$("#username").val();

        $.ajax({

            url: "${pageContext.request.contextPath}/user/getuserName.action",

            type: "post",

            async: false,

            data: {

                "username": username

            },
            success: function (data) {
                
                if (data=="error") {

                   $("#tip").show();

                   $("#tip").html("用户名已经存在！");

                }

            },
            error: function () {
                // prompt.showToastr("error", "网络异常！");
                toastr.error('添加失败');
            }
        });
    }

    $(function () {


        $("#reg_btn").click(function () {

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

            var  repassword=$("#repassword").val();

            if (repassword==""||repassword==null){


                toastr.warning('请确认密码！');

                return 0;


            }
            
            if (password!=repassword) {

                return 0;

            }

            var userMessage = {

                USERNAME:username,

                PASSWORD:password

            }

            $.ajax({

                url: "${pageContext.request.contextPath}/user/registUser.action",

                type: "post",

                async: false,

                data: {

                    "userMessage": JSON.stringify(userMessage)

                },
                success: function (data) {

                   if (data=="success"){

                       toastr.success('注册成功');

                       window.location.href="${pageContext.request.contextPath}/user/home.action";


                   }

                },
                error: function () {
                    // prompt.showToastr("error", "网络异常！");
                    toastr.error('添加失败');
                }
            });


        })


    })

</script>
<div class="page-container">
    <h1>留学生入学通知书管理系统</h1>
<form action="" method="post">
    <span style="color: black">请输入用户名:</span><input type="text" name="userName" class="username" placeholder="Username" id="username" onblur="getuserName()" onfocus="hideDiv()"><div style="color: red" id="tip"></div>
    <span style="color: black">请输入密码：</span><input type="password" name="passWord" class="password" placeholder="Password" id="password">
    <span style="color: black">请确认密码：</span><input type="password" name="passWord" class="password" placeholder="Password" id="repassword" onblur="getPassword()" onfocus="hidepDiv()"><div style="color: red" id="ptip"></div>
    <button type="button" id="reg_btn" >注册</button>
</form>
</div>



</body>
</html>
