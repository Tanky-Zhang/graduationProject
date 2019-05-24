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
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.js"></script>
    <link href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css" rel="stylesheet">
    <%--引入bootstrap-table的js和css--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table-zh-CN.js"></script>
    <link href="${pageContext.request.contextPath }/bootstrap/css/bootstrap-table.css" rel="stylesheet">
    <%--引入文件下载的css以及js--%>
    <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

    <%--导出的js文件--%>
    <script src="${pageContext.request.contextPath }/bootstrap/js/tableExport.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table-export.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/xlsx.core.min.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/FileSaver.min.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap-table-zh-CN.js"></script>



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

            height: 120px;

            /*background-color: rgba(149, 57, 229, 0.15);*/

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
        #updatePassForm{

            padding-left: 135px;

        }
        .toast-center-center {
            margin-top: -217px !important;
        }

     /*   .float-right{
            float: right;
            margin-top: -45px !important;
        }

        a{
            display: inherit;
            padding: 4px 5px;
        }*/
    </style>
    <script>

        var pageNumber=1;
        var pageSize=10;

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

                    return (pageNumber-1)*pageSize+index+1;

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

        function initTabel(){

            //$('#student-table').bootstrapTable('destroy');

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
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1,                       //初始化加载第一页，默认第一页
                pageSize: 10,                       //每页的记录行数（*）
                pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                pagination:true,
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
                //showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
                cardView: false,                    //是否显示详细视图
                //detailView: false,                   //是否显示父子表
                //showExport: true,                     //是否显示导出
                // exportDataType: "all",              //basic', 'all', 'selected'.
                columns: columns,
                paginationLoop: true,
                /*  onPageChange:function(number, size){
                      pageNumber=number;
                      pageSize=size;
                  },*/
                queryParams: function (params) {

                    //console.log(params);

                    /*pageNumber=(params.offset/params.limit)+1;//将页码和每页的条数赋给全局变量用于展示序号

                    pageSize= params.limit ;// 每页显示数量*/

                    var temp = {

                        stuName: $("#searchName").val(),
                        pageSize :params.limit, // 每页显示数量
                        pageOffset :params.offset // 每页显示数量

                    }

                    return temp;

                },          //传递参数（*）
                //paginationLoop: true,
                //export: 'glyphicon-export icon-share',
                showExport: true,              //是否显示导出按钮(此方法是自己写的目的是判断终端是电脑还是手机,电脑则返回true,手机返回falsee,手机不显示按钮)
                initExport:true,
                exportDataType: "all",              //basic', 'all', 'selected'.
                exportTypes:['excel'],	    //导出类型
                //exportButton: $('#btn_export'),     //为按钮btn_export  绑定导出事件  自定义导出按钮(可以不用)
                exportOptions:{
                    ignoreColumn: [0,0],            //忽略某一列的索引
                    fileName: '留学生信息表',              //文件名称设置
                    worksheetName: 'Sheet1',          //表格工作区名称
                    //tableName: '商品数据表',
                    excelstyles: ['background-color', 'color', 'font-size', 'font-weight'],
                    //onMsoNumberFormat: DoOnMsoNumberFormat
                }
                //导出excel表格设置<<<<<<<<<<<<<<<

            });

        }
        $(function () {

            initTabel();

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


            $("#queryButton").click(function () {

                //$('#student-table').bootstrapTable({pageNumber:1,pageSize:10});

                initTabel();

               /* $('#student-table').bootstrapTable('refresh',{


                    url:'/recode/getList.action'


                });*///'destroy',

            })


           /* $("#myExportData").click(function () {

                var type = $("#myExportData").val(),//导出文件类型,赋值在按钮标签上的value属性

                    doExport = function () {
                        that.$el.tableExport($.extend({}, that.options.exportOptions, {
                            type: type,
                            escape: false
                        }));
                    };

                if (that.options.exportDataType === 'all' && that.options.pagination) {
                    that.$el.one(that.options.sidePagination === 'server' ? 'post-body.bs.table' : 'page-change.bs.table', function () {
                        doExport();
                        that.togglePagination();
                    });
                    that.togglePagination();
                } else if (that.options.exportDataType === 'selected') {
                    var data = that.getData(),
                        selectedData = that.getAllSelections();

                    // Quick fix #2220
                    if (that.options.sidePagination === 'server') {
                        data = {total: that.options.totalRows};
                        data[that.options.dataField] = that.getData();

                        selectedData = {total: that.options.totalRows};
                        selectedData[that.options.dataField] = that.getAllSelections();
                    }

                    that.load(selectedData);
                    doExport();
                    that.load(data);
                } else {
                    doExport();
                }
            });
*/

        });

      /*  function exportData(){
            //导出数据
            $('#student-table').tableExport({
                type: 'excel',
                exportDataType: 'all',
                escape: 'false',
                ignoreColumn: [0,12],  //忽略某一列的索引
                fileName: '用户列表',  //文件名称设置
                worksheetName: 'sheet1',  //表格工作区名称
                tableName: '用户列表',
                onMsoNumberFormat: doOnMsoNumberFormat,
                onCellHtmlData: DoOnCellHtmlData,
            });
        }

        //数字
        function doOnMsoNumberFormat(cell, row, col){
            var result = "";
            if (row > 0 && col == 0){
                result = "\\@";
            }
            return result;
        }

        //处理导出内容,这个方法可以自定义某一行、某一列、甚至某个单元格的内容,也就是将其值设置为自己想要的内容
        function DoOnCellHtmlData(cell, row, col, data){
            if(row == 0){
                return data;
            }

            //由于备注列超过6个字的话,通过span标签处理只显示前面6个字,如果直接导出的话会导致内容不完整,因此要将携带完整内容的span标签中title属性的值替换
            if(col == 4 || col ==11 || col == 7){
                var spanObj = $(data);//将带 <span title="val"></span> 标签的字符串转换为jQuery对象
                var title = spanObj.attr("title");//读取<span title="val"></span>中title属性的值
                //var span = cell[0].firstElementChild;//读取cell数组中的第一个值下的第一个元素
                if(typeof(title) != 'undefined'){
                    return title;
                }
            }

            return data;
        }
*/

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
        <!--导航-->
        <div class="navbar-wrapper">
            <div class="container" id="navcontainer">
                <nav class="navbar navbar-inverse  navbar-fixed-top " role="navigation">
                    <div class="container">
                        <div class="navbar-header">
                            <a class="navbar-brand" href="#"><P style="font-size: x-large">来华留学生入学通知书打印系统</P></a>
                        </div>
                        <form class="navbar-form navbar-left" role="search">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="请输入留学生姓名" id="searchName">
                            </div>
                            <button type="button" class="btn btn-primary" id="queryButton">搜索</button>
                        </form>
                        <div class="navbar-right">
                            <p class="navbar-brand">欢迎您：${loginUser.USERNAME}</p>
                            <ul class="nav navbar-nav">
                                <li><a data-toggle="modal" onclick="updatePassword()" >修改密码</a></li>
                                <li><a data-toggle="modal"  href="${pageContext.request.contextPath}/user/logout">退出</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>

            </div>
        </div>
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
      <%--  <span>
        <input type="text" class="form-control" id="searchName" placeholder="请输入姓名"
               style="width: 150px">
        <button type="button" class="btn btn-primary queryButton" id="queryButton">查询</button>
        </span>--%>
        <shiro:hasPermission name="save-resource">
        <button id="btn_upload" type="button" class="btn btn-default" onclick="saveMemberInfoShow()">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增打印
        </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="edit-resource">
        <button id="btn_edit" type="button" class="btn btn-default" onclick="editMemberInfoShow();">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>选择修改
        </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="delete-resource">
        <button id="btn_delete" type="button" class="btn btn-default" onclick="delStudent();">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>选择删除
        </button>
        </shiro:hasPermission>
        <button id="myExportData" type="button" class="btn btn-default">
            <span class="export-excel glyphicon glyphicon-share-alt" aria-hidden="true"></span>导出
        </button>
        <shiro:hasPermission name="givepermission-resource">
        <button id="btn_per" type="button" class="btn btn-default" onclick="givepermission();">
            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>批量授权
        </button>
        </shiro:hasPermission>
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

        $('#myModal').modal();


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
                async: false,
                data: {
                    // mparam: escape(encodeURIComponent(JSON.stringify({dataMap: dataMap})))
                    "mparam": JSON.stringify(mparam)

                },
                success: function (data) {

                    toastr.success('添加成功');

                    $('#myModal').modal('hide');
                    //模态框隐藏以后将表单重置
        /*            $('#myModal').on('hide.bs.modal', function () {

                        document.getElementById("modalForm").reset();

                    });*/
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

        var selected = $("#student-table").bootstrapTable("getSelections");

        if (selected.length == 0) {
            toastr.warning('请您至少选择一条信息');
            return;
        }

        $('#delcfmModel').modal();

    }

    function delMemberVideo() {

        var selected = $("#student-table").bootstrapTable("getSelections");

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

    //授权方法
    function givepermission(){

        $.ajax({
            url: "${pageContext.request.contextPath}/user/getUsers.action",
            type: "post",
            async: false,
            success: function (data) {
                //toastr.success('删除成功');
               // $('#student-table').bootstrapTable('refresh');

                var  userList=data.userList;

                var html="";

                for (var i=0;i<userList.length;i++){

                    html+="<tr>"
                    html +=   "<td><input name=\""+userList[i].USERID+"\" class=\"checkbox\" type=\"checkbox\" onclick=\"checkOne()\"></td>"
                    html +=   "<td>" + userList[i].USERNAME + "</td>"
                    html +=    "<td>" +userList[i].ROLENAME + "</td>"
                    html+="</tr>"

                }

                $("#tableble").html(html);

                $("#myLabel").modal();

            },
            error: function () {
                toastr.error('获取用户列表失败');
            }
        });

    }
    
    function  isPermission() {

        var checkedUser=[];

        var checks=$(".checkbox");

        for(var c=0;c<checks.length;c++){

            if(checks[c].checked==true){

                checkedUser.push(checks[c].getAttribute("name"));

            }

        }
        if (checkedUser.length==0) {

            toastr.warning('请您至少选择一条信息');

            return;

        }
        var ckeckStr= checkedUser.join(",")

        $.ajax({
            url: "${pageContext.request.contextPath}/user/permissions.action",
            type: "post",
            async: false,
            data:{

                "checkStr":ckeckStr

            },
            success: function (data) {

                toastr.success('授权成功');

                $("#myLabel").modal('hide');

            },
            error: function () {

                toastr.error('授权失败');

            }
        });



        
    }
    //实现全选和反选
    function checkAll(){

      var  che=document.getElementById("checkall");

      if (che.checked==true){

        var checks=$(".checkbox");

        for(var c=0;c<checks.length;c++){

            checks[c].checked=true;

        }

        }else {

            var checks=$(".checkbox");

            for(var c=0;c<checks.length;c++){

                checks[c].checked=false;

            }

        }

   }

   //实现单选与全选的联动
    function checkOne(){

        var  che=document.getElementById("checkall");

            var checks=$(".checkbox");

            for(var c=0;c<checks.length;c++){

               if(checks[c].checked==false){

                   che.checked=false;

                   return;

               }

            }

          che.checked=true;

    }

    //修改密码的实现
     function  updatePassword() {

        $("#myPassModal").modal();
         
     }

     //校验旧密码是否输入正确
    function checkOldPass(){

        var oldPass=$("#oldPass").val();

        $.ajax({

            url: "${pageContext.request.contextPath}/user/checkPass.action",

            type: "post",

            async: false,

            data: {

                "oldPass": oldPass

            },
            success: function (data) {

                if (data=="error") {

                    $("#oldTip").show();

                    $("#oldTip").html("旧密码输入错误！");

                }

            },
            error: function () {

                toastr.error('获取原密码失败');

            }
        });

    }
    
    function  hideOldTip() {

        $("#oldTip").hide();
        $("#reTip").hide();
        
    }

    function checkRePass() {

        var  password=$("#newPass").val();

        if (password!=$("#rePass").val()){

            $("#reTip").show();

            $("#reTip").html("密码输入错误！");

            //$("#reg_btn").attr("disabled")

        }

    }
    
    function  savePassword() {

        var oldPass=$("#oldPass").val();

        if (oldPass==""||oldPass==null){

            toastr.warning('请填写原密码！');

            return 0;

        }

        var  newPass=$("#newPass").val();

        if (newPass==""||newPass==null){

            toastr.warning('请填写新密码！');

            return 0;

        }

        var  rePass=$("#rePass").val();

        if (rePass==""||rePass==null){


            toastr.warning('请确认密码！');

            return 0;


        }
        if (newPass!=rePass) {

            return 0;

        }

        $.ajax({

            url: "${pageContext.request.contextPath}/user/updatePass.action",

            type: "post",

            async: false,

            data: {

                "newPass": newPass

            },
            success: function (data) {

                if (data=="success"){

                    toastr.success('修改成功,即将跳转到登录页。');

                    $("#myPassModal").modal("hide");

                    //response.setHeader("refresh","3;${pageContext.request.contextPath}/user/home.action")

                  setTimeout("window.location.href=\"${pageContext.request.contextPath}/user/home.action\";",3000)

                }

            },
            error: function () {

                toastr.error('修改密码失败');
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

<div class="modal fade in" id="myLabel">
    <div class="modal-dialog">
        <div class="modal-content message_align" style="width: 500px !important;">
            <div class="modal-header">
                <span style="font-size: large">授予超级管理员权限</span>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body" id="tanchu">

                <div class="bs-example" data-example-id="hoverable-table">

                    <table class="table" id="btable">
                        <thead>
                        <tr>
                            <th><input id="checkall" class="checkall" type="checkbox" onclick="checkAll()"></th>
                            <th>用户名</th>
                            <th>角色名称</th>
                        </tr>
                        </thead>
                        <tbody id="tableble">

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="aa">取消</button>
                <a onclick="isPermission()" class="btn btn-success">授权</a>
            </div>
        </div>
    </div>
</div>

<%--修改密码的模态框--%>
<div class="modal fade" id="myPassModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myupdateLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <div class="application">
                    <form class="form-inline" id="updatePassForm" >
                        <label for="snumber">请输入旧密码:</label>
                        <input type="password" class="form-control" id="oldPass" onblur="checkOldPass()" onfocus="hideOldTip()">
                        <br>
                        <span style="display: none;margin-left: 125px;color: red" id="oldTip"></span>
                        <br>
                        <label for="snumber">请输入新密码:</label>
                        <input type="password" class="form-control" id="newPass">
                        <br>
                        <br>
                        <label for="snumber">请确认新密码:</label>
                        <input type="password" class="form-control" id="rePass" onblur="checkRePass()" onfocus="hideOldTip()">
                        <br>
                        <span style="display: none;margin-left: 125px;color: red" id="reTip"></span>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="updatePass" onclick="savePassword()">保存</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>