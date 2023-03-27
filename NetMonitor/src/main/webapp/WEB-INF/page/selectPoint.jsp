<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ include file="taglib.jsp"%>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit|ie-comp|ie-stand">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link href="${ctx}/static/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="${ctx}/static/css/style.css"/>
  <link rel="stylesheet" href="${ctx}/static/assets/css/ace.min.css" />
  <link rel="stylesheet" href="${ctx}/static/assets/css/font-awesome.min.css" />
  <link rel="stylesheet" href="${ctx}/static/Widget/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
  <link href="${ctx}/static/Widget/icheck/icheck.css" rel="stylesheet" type="text/css" />
  <!--[if IE 7]>
		  <link rel="stylesheet" href="${ctx}/static/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
  <!--[if lte IE 8]>
		  <link rel="stylesheet" href="${ctx}/static/assets/css/ace-ie.min.css" />
		<![endif]-->
  <script src="${ctx}/static/js/jquery-1.9.1.min.js"></script>
  <script src="${ctx}/static/assets/js/bootstrap.min.js"></script>
  <script src="${ctx}/static/assets/js/typeahead-bs2.min.js"></script>
  <!-- page specific plugin scripts -->
  <script src="${ctx}/static/assets/js/jquery.dataTables.min.js"></script>
  <script src="${ctx}/static/assets/js/jquery.dataTables.bootstrap.js"></script>
  <script type="text/javascript" src="${ctx}/static/js/H-ui.js"></script>
  <script type="text/javascript" src="${ctx}/static/js/H-ui.admin.js"></script>
  <script src="${ctx}/static/assets/layer/layer.js" type="text/javascript" ></script>
  <script src="${ctx}/static/assets/laydate/laydate.js" type="text/javascript"></script>
  <script type="text/javascript" src="${ctx}/static/Widget/zTree/js/jquery.ztree.all-3.5.min.js"></script>
  <script src="${ctx}/static/js/lrtk.js" type="text/javascript" ></script>

  <title>选择节点</title>

  <style href="">
    .pointCheckBox{
      float: left;
      padding-left: 5px;
    }
    .checkedPoint{
      color:blue;
    }
  </style>
</head>
<body>
<div class="table_menu_list" id="testIframe">
  <table class="table table-striped table-bordered table-hover">
    <tr>
      <td style="width: 30%">&nbsp;</td>
      <td style="width: 70%">
      <c:forEach items="${groups}" var="group">
        <div class="pointCheckBox"><input type="checkbox" class="ace" aria-hidden="false" value="${group}"><span class="lbl"></span>${group}</div>
      </c:forEach>
      </td>
    </tr>
    </tr>
    </tr>
    <c:forEach items="${group2Map}" var="group2">
      <tr>
        <td><input type="checkbox" class="ace" value="${group2.key}" onclick="checkedGroup(this)">${group2.key}</td>
        <td>
          <c:forEach items="${group2.value}" var="data">
            <div class="pointCheckBox"><input type="checkbox" class="ace" aria-hidden="false" name="${data.name}" value="${data.code}" group="${data.group}"/><span class="lbl"></span>${data.name}</div>
          </c:forEach>
        </td>
      </tr>
    </c:forEach>
  </table>
</div>
<div class="clearfix cl">
  <div class="Button_operation">
    <button onClick="pointSave()" class="btn btn-secondary  btn-warning" type="button"><i class="icon-save"></i>保存</button>
    <button onClick="window.close()" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
  </div>
</div>
</body>
<script type="text/javascript">
  function checkedGroup(checkObj){
      var checkFlag = $(checkObj).is(':checked');
      var groupVal = $(checkObj).val();
      $("#testIframe input [group="+groupVal+"]").attr("checked",checkFlag);
  }

  function pointSave(){
    debugger;
    var nodesId = "";
    var nodesName = "";
    $("#testIframe input:checked").each(function (){
      nodesName += this.name+",";
      nodesId += this.value+",";
    });
    window.opener.document.all.nodesId.value=nodesId;
    window.opener.document.all.nodesName.value=nodesName;
    window.close();
  }
</script>
</html>
