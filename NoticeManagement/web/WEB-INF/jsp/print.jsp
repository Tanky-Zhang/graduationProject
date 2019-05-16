<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>信息管理</title>
    <!--引入jquery的js-->
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
    <%--引入popper.js--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/popper.js"></script>
    <%--引入bootstrap的js和css--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css" rel="stylesheet">
    <%--引入bootstrap-table的js和css--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table-zh-CN.js"></script>
    <link href="${pageContext.request.contextPath }/bootstrap/css/bootstrap-table.css" rel="stylesheet">
    <%--引入文件下载的css以及js--%>
  <%--  <script src="${pageContext.request.contextPath }/js/recode/xlsx.core.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/recode/blob.js"></script>
    <script src="${pageContext.request.contextPath }/js/recode/FileSaver.min.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table-export.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/tableExport.min.js"></script>--%>
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
    <%--引入弹出提示框的js和css--%>
    <link href="${pageContext.request.contextPath }/bootstrap/css/toastr.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/bootstrap/js/toastr.js"></script>
    <style type="text/css">
        .container-fluid {

            height: 150px;

            background-color: rgba(149, 57, 229, 0.15);

        }

        .row {

            height: 400px;

        }

        #toolbar {

            margin-top: 10px;

        }

        .modal-backdrop {
            z-index: 0 !important;
        }

        .btn-success {

            margin-right: 170px;

        }

        #cancle {

            margin-right: 40px;

        }
        .dropup .dropdown-menu{
            bottom: auto;
        }
    </style>
    <script>
        var columns = [
            {
                checkbox: true,
                halign: 'center',
                align: "center",
                id: 'td'
            },
            {
                title: '序号',
                align: "center",
                halign: 'center',
                width: 50,
                formatter: function (value, row, index) {
                    return index + 1;
                }
            },
            {
                field: 'ID',
                title: 'ID',
                visible: false
            },
            {
                field: 'SNAME',
                title: '姓名'
            },
            {
                field: 'NATIONALITY',
                title: '国籍'
            },
            {
                field: 'BIRTH',
                title: '出生日期'
            },
            {
                field: 'FIELD_OF_STUDY',
                title: '专业'

            },
            {
                field: 'SEX',
                title: '性别',
                formatter: function (value, row, index) {
                    if (value == "1") {
                        return "男";
                    }
                    if (value == 0) {

                        return "女";
                    }

                }

            },
            {
                field: 'PASSPORT',
                title: '护照'

            },
            {
                field: 'ADDRESS',
                title: '地址/电话'

            },
            {
                field: '',
                title: '打印次数'

            },
            {
                field: '',
                title: '操作',
                formatter: function (value, row, index) {

                    return '<a href="${pageContext.request.contextPath}/recode/print/' + row.ID + '\">打印预览</a>';

                }
            }];
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
            //1.初始化Table
            /*var oTable = new TableInit();
            oTable.Init();*/

            //2.初始化Button的点击事件
            /*var oButtonInit = new ButtonInit();
            oButtonInit.Init();*/
            $('#student-table').bootstrapTable({

                url: '${pageContext.request.contextPath }/recode/getList.action',         //请求后台的URL（*）
                method: 'post',                      //请求方式（*）
                contentType: "application/x-www-form-urlencoded",
                toolbar: '#toolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                sortable: false,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                queryParams: function (params) {

                    var temp = {

                        stuName: $("#searchName").val()

                    }

                    return temp;

                },          //传递参数（*）
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1,                       //初始化加载第一页，默认第一页
                pageSize: 10,                       //每页的记录行数（*）
                pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                //search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                //strictSearch: true,
                showColumns: true,                 //是否显示所有的列
                smartDisplay: false,
                //showRefresh: true,                  //是否显示刷新按钮
                //minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                //height: 30,                        //行高，如果没有设置height属性，表格自动根据记录条数表格高度
                uniqueId: "ID",                    //每一行的唯一标识，一般为主键列
                strictSearch: true,
                // showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
                // cardView: false,                    //是否显示详细视图
                //detailView: false,                   //是否显示父子表
                //showExport: true,                     //是否显示导出
                // exportDataType: "all",              //basic', 'all', 'selected'.
                columns: columns,
                /* onPageChange:function(number, size){/!*pn= number ; pz = size*!/}*/
                paginationLoop: false,
            });

            $("#queryButton").click(function () {

                $('#student-table').bootstrapTable('refresh');

            })


        });
        //初始化时间控件
        /* $(function () {
             var picker1 = $('#datetimepicker1').datetimepicker({
                 format: 'YYYY-MM-DD',
                 locale: moment.locale('zh-cn'),
                 //minDate: '2016-7-1'
             });
             var picker2 = $('#datetimepicker2').datetimepicker({
                 format: 'YYYY-MM-DD',
                 locale: moment.locale('zh-cn')
             });
             //动态设置最小值
             picker1.on('dp.change', function (e) {
                 picker2.data('DateTimePicker').minDate(e.date);
             });
             //动态设置最大值
             picker2.on('dp.change', function (e) {
                 picker1.data('DateTimePicker').maxDate(e.date);
             });

         });*/
    </script>
</head>
<body style="background-color: #f7f7f7;height: 100%">
<div>

    <div class="container-fluid">
    </div>
    <div class="" id="boot">
        <div class="container" id="table">
            <div class="row">
                <%--<div class="col-md-1"></div>--%>
                <div class="col-md-12" style="background-color: white">
                    <br>
                    <h4 style="margin-top: 0px;text-align:center;font-size: 30px">已登记信息</h4>
                    <div class="table-responsive">

                        <table id="student-table" class="table table-striped table-bordered"
                               data-name="cool-table">

                        </table>
                    </div>

                </div>
                <%--<div class="col-md-1"></div>--%>
            </div>

        </div>
    </div>
</div>
<!-- 工具容器 -->
<div id="toolbar" class="btn-group">
    <form class="form-inline">
        <button id="btn_upload" type="button" class="btn btn-default" onclick="saveMemberInfoShow()">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增打印
        </button>
        <button id="btn_edit" type="button" class="btn btn-default" onclick="editMemberInfoShow();">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>选择修改
        </button>
        <button id="btn_delete" type="button" class="btn btn-default" onclick="delStudent();">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>选择删除
        </button>
        <button id="btn_import" type="button" class="btn btn-default" onclick="delMemberVideo();">
            <span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span>导入
        </button>

        <input type="text" class="form-control" id="searchName" placeholder="请输入姓名"
               style="width: 150px;margin-left: 500px">
        <button type="button" class="btn btn-primary queryButton" id="queryButton">查询</button>
    </form>
    </form>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">学生信息编辑(由接受留学人员院校填写，带 <em style="color: red">●</em>为必填项)</h4>
                <input type="hidden" id="ID">
            </div>
            <div class="modal-body">
                <div class="application">
                    <form class="form-inline" id="modalForm">
                        <div class="form-group">
                            <label for="snumber">编号/Number:</label>
                            <input type="text" class="form-control" id="snumber">
                        </div>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="hostInstitution">接受院校/Host Institution:</label>
                            <input type="text" class="form-control" id="hostInstitution">
                        </div>
                        <br><br>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="sname">姓名/Name:</label>
                            <input type="text" class="form-control" id="sname">
                        </div>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="familyName">姓/Family Name:</label>
                            <input type="email" class="form-control" id="familyName" style="width: 150px">
                        </div>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="givenName">名/Given Name:</label>
                            <input type="email" class="form-control" id="givenName" style="width: 150px">
                        </div>
                        <br><br>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="nationality">国籍/Nationality:</label>
                            <input type="text" class="form-control" id="nationality" style="width: 120px">
                        </div>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="passport">护照号码/Passport:</label>
                            <input type="email" class="form-control" id="passport" style="width: 120px">
                        </div>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="sex">性别/Sex:</label>
                            <select class="form-control" style="width: 70px" id="sex">
                                <option value=" ">--</option>
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="isMatched">婚否/Matched:</label>
                            <select class="form-control" style="width: 70px" id="isMatched">
                                <option value=" ">--</option>
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                        <br><br>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="birth">出生日期/Date of Birth: </label>
                        </div>
                        <div class='input-group date datetimePicker' id='datetimepicker_birth'>
                            <input name="endTimeStr" type='text' class="form-control" id="birth"/>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label for="pTel">个人电话/Personal Tel</label>
                            <input type="email" class="form-control" id="pTel" style="width: 250px">
                        </div>
                        <br><br>
                        <div class="form-group">
                            <label for="pBirth">出生地点/Place of Birth:</label>
                            <input type="email" class="form-control" id="pBirth" style="width: 250px">
                        </div>
                        <div class="form-group">
                            <em style="color: red"></em>
                            <label for="address">家庭地址/Address</label>
                            <input type="email" class="form-control" id="address" style="width: 250px">
                        </div>
                        <br><br>
                        <div class="form-group">
                            <label for="employer_or_institution">原工作或学习单位/Employer or Institution
                                Affiliated:</label>
                            <input type="email" class="form-control" id="employer_or_institution"
                                   style="width: 300px">
                        </div>
                        </br></br>
                        <div class="form-group">
                            <label for="rTel">推荐单位电话/Reference&Tel:</label>
                            <input type="email" class="form-control" id="rTel">
                        </div>
                        <div class="form-group">
                            <em style="color: red"></em>
                            <label for="field_of_study">来华学习专业/Field of Study in China:</label>
                            <input type="email" class="form-control" id="field_of_study">
                        </div>
                        <br><br>
                        <div class="form-group">
                            <em style="color: red">●</em>
                            <label>学习期限/Duration:</label>
                        </div>
                        <div class="form-group">
                            <div class='input-group date datetimePicker' id='datetimepicker_start'>
                                <span class="input-group-addon">开始时间</span>
                                <input name="endTimeStr" type='text' class="form-control" id="staDuration"/>
                                <span class="input-group-addon">
                                                     <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class='input-group date datetimePicker' id='datetimepicker_end'>
                                <span class="input-group-addon">截止时间</span>
                                <input name="endTimeStr" type='text' class="form-control" id="endDuration"/>
                                <span class="input-group-addon">
                                                 <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                            </div>
                        </div>
                        <br><br>
                        <div class="form-group">
                            <label for="support">经济担保人或机构/Financial support will be provided by:</label>
                            <input type="email" class="form-control" id="support">
                        </div>
                        <div class="form-group">
                            <label for="sTel">电话/Tel:</label>
                            <input type="email" class="form-control" id="sTel">
                        </div>
                        <br><br>
                        <div class="form-group">
                            <label for="givenName">经费来源/Source of Funding:</label>
                            <label class="checkbox-inline">
                                <input type="checkbox" id="scholarship" value="1" name="source">奖学金/Scholarship
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" id="self" value="2" name="source">自费/Self-supporting
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" id="other" value="3" name="source">其他/Other
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="print" onclick="sprint()">打印预览</button>
                    <button type="button" class="btn btn-primary" id="save" onclick="savemessage()">保存</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div><!-- /.modal-content -->
</div>


<div style="display: none">

    <%--定义一个form表单做提交使用--%>
    <form action="${pageContext.request.contextPath}/recode/printSave" id="formSubmint" method="post">

        <input type="text" id="myformString" name="myformString">

        <input type="text" id="status" name="status">


    </form>

</div>
<script type="text/javascript">

    //定义一个全局变量用来保存当前状态是修改还是新增
    var dostatus = 0; //正常状态为0；为1就是新增状态 为2就是修改状态

    $(function () {

        $('.datetimePicker').datetimepicker({

            format: 'yyyy-mm-dd',

            language: 'zh-CN',//修改成中文

            autoclose: true,//选中关闭

            minView: "month"//显示到日期

        });

    });

    //非空校验
    function panduan() {

        if ($("#hostInstitution").val() == "") {

            toastr.warning('接受院校不能为空！');

            return 0;

        } else if ($("#sname").val() == "") {

            toastr.warning('姓名不能为空！');

            return 0;

        } else if ($("#familyName").val() == "") {

            toastr.warning('姓不能为空！');
            return 0;

        } else if ($("#givenName").val() == "") {

            toastr.warning('名不能为空！');

            return 0;

        } else if ($("#nationality").val() == "") {

            toastr.warning('国籍不能为空！');

            return 0;

        } else if ($("#passport").val() == "") {

            toastr.warning('护照号码不能为空！');

            return 0;

        } else if ($("#sex").val() == "") {

            toastr.warning('性别不能为空！');

            return 0;

        } else if ($("#isMatched").val() == "") {

            toastr.warning('是否婚配不能为空！');

            return 0;

        } else if ($("#birth").val() == "") {

            toastr.warning('出生日期不能为空！');

            return 0;

        } else if ($("#pTel").val() == "") {

            toastr.warning('个人电话不能为空！');
            return 0;


        } else if ($("#staDuration").val() == "") {

            toastr.warning('学习开始时间不能为空！');

            return 0;

        } else if ($("#endDuration").val() == "") {

            toastr.warning('学习结束时间不能为空！');

            return 0;

        }

        return 1;

    }

    //打印预览按钮的实现
    function sprint() {


        var flag = panduan();

        if (flag == 0) {

            return;

        }

        var mparam = getmap();

        var ID = $("#ID").val();

        if (ID != "") {

            mparam['ID'] = ID;

        }


        var formString = JSON.stringify(mparam);

        $("#myformString").val(formString);

        $("#status").val(dostatus);

        $("#formSubmint").submit();

    }

    //获取表单map
    function getmap() {

        obj = document.getElementsByName("source");
        check_val = [];
        for (k in obj) {
            if (obj[k].checked) {

                check_val.push(obj[k].value);

            }
        }

        var source = check_val.join(",");
        var snumber = $("#snumber").val();//编号
        var hostInstitution = $("#hostInstitution").val();//接受院校
        var pTel = $("#pTel").val();//个人电话
        var sTel = $("#sTel").val();//担保人电话
        var sname = $("#sname").val();//全名
        var familyName = $("#familyName").val();//姓
        var sex = $("#sex").val();//性别
        var isMatched = $("#isMatched").val();//是否结婚
        var givenName = $("#givenName").val();//名字
        var passport = $("#passport").val();//护照
        var birth = $("#birth").val();//生日
        var pBirth = $("#pBirth").val();//出生地
        var nationality = $("#nationality").val();//国籍
        var address = $("#address").val();//家庭地址
        var field_of_study = $("#field_of_study").val();//专业
        var employer_or_institution = $("#employer_or_institution").val();//工作或者学习环境
        var staDuration = $("#staDuration").val();//开始期限
        var endDuration = $("#endDuration").val();//结束期限
        var support = $("#support").val();//担保人
        var rTel = $("#rTel").val();//推荐单位电话

        var mparam = {
            SNUMBER: snumber,
            PTEL: pTel,
            STEL: sTel,
            SNAME: sname,
            FAMILYNAME: familyName,
            SEX: sex,
            ISMATCHED: isMatched,
            GIVENNAME: givenName,
            PASSPORT: passport,
            BIRTH: birth,
            PBIRTH: pBirth,
            NATIONALITY: nationality,
            ADDRESS: address,
            FIELD_OF_STUDY: field_of_study,
            EMPLOYER_OR_INSTITUTION: employer_or_institution,
            STADURATION: staDuration,
            ENDDURATION: endDuration,
            SUPPORT: support,
            HOSTINSTITUTION: hostInstitution,
            RTEL: rTel,
            SOURCEOFMONEY: source
        }

        return mparam;

    }


    //点击新增
    function saveMemberInfoShow() {

        //window.print();

        dostatus = 1;

        document.getElementById("modalForm").reset();

        $('#myModal').modal("show");

    }

    //完成保存功能
    function savemessage() {

        var flag = panduan();

        if (flag == 0) {

            return;

        }

        var mparam = getmap();

        if (dostatus == 1) {//新增状态

            $.ajax({
                url: "${pageContext.request.contextPath}/recode/saveMessage.action",
                type: "post",
                //contentType:'application/json;charset=utf-8',
                async: false,
                //dataType: "json",
                data: {
                    // mparam: escape(encodeURIComponent(JSON.stringify({dataMap: dataMap})))
                    "mparam": JSON.stringify(mparam)

                },
                success: function (data) {
                    toastr.success('添加成功');
                    $('#myModal').modal('hide');
                    //模态框隐藏以后将表单重置
                    $('#myModal').on('hide.bs.modal', function () {

                        document.getElementById("modalForm").reset();

                    });
                    $('#student-table').bootstrapTable('refresh');
                },
                error: function () {
                    // prompt.showToastr("error", "网络异常！");
                    toastr.error('添加失败');
                }
            });

        } else {

            //将原有ID获取
            var ID = $("#ID").val();
            // console.info(ID)
            mparam['ID'] = ID;
            console.info(mparam["ID"]);
            $.ajax({
                url: "${pageContext.request.contextPath}/recode/editMessage.action",
                type: "post",

                async: false,

                data: {
                    "mparam": JSON.stringify(mparam)

                },
                success: function (data) {
                    toastr.success('修改成功');
                    $('#myModal').modal('hide');
                    $('#myModal').on('hide.bs.modal', function () {

                        document.getElementById("modalForm").reset();

                    });
                    //$('#student-table').bootStrapTable('refresh')
                    $('#student-table').bootstrapTable('refresh');
                },
                error: function () {
                    // prompt.showToastr("error", "网络异常！");
                    toastr.error('修改失败');
                }
            });

        }

    };

    //实现删除和多项删除
    function delStudent() {

        $('#delcfmModel').modal();

    }

    function delMemberVideo() {

        var selected = $("#student-table").bootstrapTable("getSelections");

        if (selected.length == 0) {
            toastr.warning('请您至少选择一条信息');
            return;
        }

        var sid = [];
        for (var i = 0; i < selected.length; i++) {
            sid.push(selected[i].ID);
        }
        var sidstr = sid.join(",");


        $.ajax({
            url: "${pageContext.request.contextPath}/recode/deleMessage.action",
            type: "post",
            async: false,
            data: {
                "sid": sidstr
            },
            success: function (data) {
                toastr.success('删除成功');
                $('#student-table').bootstrapTable('refresh');

            },
            error: function () {
                toastr.error('删除失败');
            }
        });

    }

    //实现修改功能
    function editMemberInfoShow() {

        dostatus = 2;

        document.getElementById("modalForm").reset();
        //$('#myModal').modal('show');
        var selected = $("#student-table").bootstrapTable("getSelections");
        //alert("1121");
        //checkDel();
        if (selected.length == 0) {
            toastr.warning('请您至少选择一条信息');
            return;
        }
        if (selected.length > 1) {
            toastr.warning('每次只能选择一条信息');
            return;
        }

        var sid = selected[0].ID;

        $.ajax({
            url: "${pageContext.request.contextPath}/recode/getMessage.action",
            type: "post",
            async: false,
            data: {
                "sid": sid
            },
            success: function (data) {

                $("#hostInstitution").val(data.HOSTINSTITUTION);
                $("#snumber").val(data.SNUMBER);//编号
                $("#pTel").val(data.PTEL);//个人电话
                $("#sTel").val(data.STEL);//担保人电话
                $("#sname").val(data.SNAME);//全名
                $("#familyName").val(data.FAMILYNAME);//姓
                $("#sex").val(data.SEX);//性别  0代表女 1代表男
                $("#isMatched").val(data.ISMATCHED);//是否结婚 0代表未婚 1代表已婚
                $("#givenName").val(data.GIVENNAME);//名字
                $("#passport").val(data.PASSPORT);//护照
                $("#birth").val(data.BIRTH);//生日
                $("#pBirth").val(data.PBIRTH);//出生地
                $("#nationality").val(data.NATIONALITY);//国籍
                $("#address").val(data.ADDRESS);//家庭地址
                $("#field_of_study").val(data.FIELD_OF_STUDY);//专业
                $("#employer_or_institution").val(data.EMPLOYER_OR_INSTITUTION);//工作或者学习环境
                $("#staDuration").val(data.STADURATION);//开始期限
                $("#endDuration").val(data.ENDDURATION);//结束期限
                $("#support").val(data.SUPPORT);//担保人
                $("#rTel").val(data.RTEL);//推荐单位电话
                $("#ID").val(data.ID);
                //console.info(data.ID);
                //对多选框的操作回显
                var str = data.SOURCEOFMONEY;
                if (str != "" && str != null) {
                    var checkboxs = str.split(",");

                    //console.info(checkboxs[0]);
                    obj = document.getElementsByName("source");
                    //check_val = [];
                    for (var v = 0; v < checkboxs.length; v++) {
                        for (k in obj) {

                            if (obj[k].value == checkboxs[v]) {

                                obj[k].checked = true;

                            }
                        }
                    }
                }
                //$("#modalForm")[0].reset();
                //document.getElementById("modalForm").reset();
                $('#myModal').modal();

                //由于时间组件出现模态框关闭的情况 所以会出现模态框一旦关闭 会触发表单清空的情况
                /*  $('#myModal').on('hide.bs.modal', function () {

                      document.getElementById("modalForm").reset();

                  });*/
                // toastr.success('修改成功');

            },

            error: function () {

                toastr.error('获取编辑列表失败');

            }

        });

    }
</script>

<%--确认删除模态框--%>
<div class="modal fade" id="delcfmModel">
    <div class="modal-dialog">
        <div class="modal-content message_align" style="width: 500px !important;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <%-- <h4 class="modal-title">提示信息</h4>--%>
            </div>
            <div class="modal-body">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="cancle">取消</button>
                <a onclick="delMemberVideo()" class="btn btn-success" data-dismiss="modal">确定</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>