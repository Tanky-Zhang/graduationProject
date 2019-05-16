<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>学生信息显示</title>
    <!--引入jquery的js-->
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
    <%--引入popper.js--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/popper.js"></script>

    <%--引入bootstrap的js和css--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.js"></script>
    <link href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css" rel="stylesheet">
    <%--引入bootstrap-table的js和css--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table-zh-CN.js"></script>
    <link href="${pageContext.request.contextPath }/bootstrap/css/bootstrap-table.css" rel="stylesheet">
    <%--引入文件下载的css以及js--%>
    <script src="${pageContext.request.contextPath }/js/recode/xlsx.core.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/recode/blob.js"></script>
    <script src="${pageContext.request.contextPath }/js/recode/FileSaver.min.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table-export.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/tableExport.min.js"></script>
    <%--引入弹出模态框的js文件--%>
    <%-- <script src="${pageContext.request.contextPath }/bootstrap/js/modal.js"></script>--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-modalmanager.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-modal.js"></script>
    <%--引入做时间控件的js和css--%>
    <link href="${pageContext.request.contextPath }/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/bootstrap/js/moment-with-locales.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-datetimepicker.fr.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"></script>

    <%--引入时间提示的js和css--%>
    <link href="${pageContext.request.contextPath }/bootstrap/css/toastr.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/bootstrap/js/toastr.js"></script>
    <style>
        #myImg {

            padding-left: 100px !important;

        }

        #imgto {

            margin-left: 100px !important;
        }
        #father {

            background-color: rgba(149, 57, 229, 0.15);

        }
        #leftM {

            height: 600px;

        }
        #rightM {

            height: 550px;
        }

        #btn-group {

            margin-left: 10px;

        }
        .cbox {
            height: 200px !important;
            width: 200px !important;
            position: relative;
        }

        .duihao-wrapper {
            position: absolute;
            bottom: 0px;
            right: 0;
            display: none;
        }

        .on .duihao-wrapper {
            position: absolute;
            bottom: 0px;
            right: 0;
            display: block;
        }
    </style>
     
</head>

<body id="father">


<div class="row" style="height: 80px">
</div>

<div class="row">

    <div class="col-md-8" id="leftM">

        <div style="position:relative;" id="con">

            <img src="${pageContext.request.contextPath }/img/2.jpg" alt="" id="imgto">

            <div id="myImg" style="position:absolute; z-index:2; left:10px; top:10px">

                <div class="text" style=' text-align:center; padding-top: 60px;font-size: 50px'>
                    <p style="width: 900px !important;"><span>${stu.HOSTINSTITUTION}</span></p></div>
                <div class="text" style='font-size: 30px;padding-left: 50px;padding-top: 10px;margin-left: 20px'>
                    <p><span>${stu.SNAME}</span>同学：</p>
                </div>

                <div class="text" style='padding-top: 10px;font-size: 30px;padding-left: 100px;padding-right: 50px;'>
                    <p style="width: 800px !important; line-height:50px">
                        &nbsp;&nbsp;&nbsp;&nbsp;恭喜您，被<span>${stu.HOSTINSTITUTION}${stu.FIELD_OF_STUDY}</span>专业录取，请凭本通知书来校报到。
                    </p>
                </div>
                <div class="text" style='font-size: 30px;padding-left: 600px;padding-top: 20px'>
                    <p>${stu.HOSTINSTITUTION}学生处</p>
                </div>

                <div class="text" style='font-size: 30px;padding-left: 610px;padding-top: 10px'>
                    <p>${year}年${month}月${day}日</p>
                </div>

            </div>

        </div>

    </div>

    <div id="rightM" class="col-md-4">

        <div style="margin-left: 100px;margin-top: 20px">

            <div class="cbox cbox1" id="cbox1">

                <img id="img1" src="${pageContext.request.contextPath }/img/3.jpg" alt=""
                     style="height:200px !important;width: 200px !important;">

                <div class="duihao-wrapper">
                    <img src="${pageContext.request.contextPath }/img/4.jpg" id="duihao" alt=""
                         style="height: 30px;width: 30px;">
                </div>

            </div>
            <br>
            <div class="cbox " id="cbox2">

                <img src="${pageContext.request.contextPath }/img/2.jpg" alt=""
                     style="height:200px !important;width: 200px !important;"  id="img2">

                <div class="duihao-wrapper">
                    <img src="${pageContext.request.contextPath }/img/4.jpg" id="duihao1" alt=""
                         style="height: 30px;width: 30px;">
                </div>

            </div>


            <div id="btn-group">

                <br>
                <br>
                <button type="button" class="btn btn-default" id="selectM" onclick="choseTemplement()" style="margin-right: 30px !important;">选择模版
                </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-primary" id="sprintM" onclick="savemessage()">打印</button>
            </div>

        </div>
    </div>
</div>
<script>

    var srcPict="";

    function savemessage() {

        window.print();

    }

    function choseTemplement(){

        document.getElementById("imgto").src = srcPict;

    }

    $(function () {

        $("#cbox1").click(function () {
            if ($(this).hasClass("on")) {
                $(this).removeClass("on");
                console.log($('#img1').attr("src"))
            } else {
                $(this).addClass("on");
                $("#cbox2").removeClass("on");
                srcPict=$('#img1').attr("src");
            }
        })
        $("#cbox2").click(function () {

            if ($(this).hasClass("on")) {
                $(this).removeClass("on");
            } else {
                $(this).addClass("on");
                $("#cbox1").removeClass("on");
                srcPict=$('#img2').attr("src");
            }
        })

    })
</script>
</body>

</html>