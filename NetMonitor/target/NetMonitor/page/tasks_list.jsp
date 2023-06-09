<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" /> 
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="../css/style.css"/>
        <link rel="stylesheet" href="../assets/css/ace.min.css" />
        <link rel="stylesheet" href="../assets/css/font-awesome.min.css" />
        <link rel="stylesheet" href="../Widget/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
        <link href="../Widget/icheck/icheck.css" rel="stylesheet" type="text/css" />
		<!--[if IE 7]>
		  <link rel="stylesheet" href="../assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
        <!--[if lte IE 8]>
		  <link rel="stylesheet" href="../assets/css/ace-ie.min.css" />
		<![endif]-->
	    <script src="../js/jquery-1.9.1.min.js"></script>   
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/typeahead-bs2.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="../assets/js/jquery.dataTables.min.js"></script>
		<script src="../assets/js/jquery.dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="../js/H-ui.js"></script> 
        <script type="text/javascript" src="../js/H-ui.admin.js"></script> 
        <script src="../assets/layer/layer.js" type="text/javascript" ></script>
        <script src="../assets/laydate/laydate.js" type="text/javascript"></script>
        <script type="text/javascript" src="../Widget/zTree/js/jquery.ztree.all-3.5.min.js"></script>
        <script src="../js/lrtk.js" type="text/javascript" ></script>
<title>任务列表</title>
</head>
<body>
<div class=" page-content clearfix">
 <div id="products_style">
    <div class="search_style">
      <ul class="search_content clearfix">
       <li><label class="l_f">任务名称</label><input name="" type="text"  class="text_add" placeholder="输入任务名称"  style=" width:250px"/></li>
       <li><label class="l_f">添加时间</label><input class="inline laydate-icon" id="start" style=" margin-left:10px;"></li>
       <li style="width:90px;"><button type="button" class="btn_search"><i class="icon-search"></i>查询</button></li>
      </ul>
    </div>

    <div class="border clearfix">
       <span class="l_f">
        <a href="picture-add.jsp" title="新增" class="btn btn-warning Order_form"><i class="icon-plus"></i>添加任务</a>
        <a href="javascript:ovid()" class="btn btn-danger"><i class="icon-trash"></i>批量删除</a>
       </span>
       <span class="r_f">共：<b>2334</b>个监控任务</span>
    </div>

    <div class="table_menu_list" id="testIframe">
       <table class="table table-striped table-bordered table-hover" id="sample-table">
            <thead>
             <tr>
                <th width="25px"><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
                <th width="180px">名称</th>
                <th width="250px">监控对象</th>
                <th width="100px">分组</th>
                <th width="100px">频率</th>
                <th width="100px">劫持占比</th>
                <th width="100px">任务状态</th>
                <th width="180px">预计消耗波点</th>
                <th width="180px">最后检测时间</th>
                <th width="100px">操作</th>
             </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
  </div>
 </div>
</div>
</body>
</html>
<script>
jQuery(function($) {
		var oTable1 = $('#sample-table').dataTable( {
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,2,3,4,5,8,9]}// 制定列不参与排序
		] } );
				
				
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
				});

                $('.search_content li .btn_search').on('click' , function(){
                    alert(1);
                });
			
				$('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
				function tooltip_placement(context, source) {
					var $source = $(source);
					var $parent = $source.closest('table')
					var off1 = $parent.offset();
					var w1 = $parent.width();
			
					var off2 = $source.offset();
					var w2 = $source.width();
			
					if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
					return 'left';
				}
			});
 laydate({
    elem: '#start',
    event: 'focus' 
});
$(function() { 
	$("#products_style").fix({
		float : 'left',
		//minStatue : true,
		skin : 'green',	
		durationTime :false,
		spacingw:30,//设置隐藏时的距离
	    spacingh:260,//设置显示时间距
	});
});
</script>
<script type="text/javascript">
//初始化宽度、高度  
 $(".widget-box").height($(window).height()-215); 
$(".table_menu_list").width($(window).width()-260);
 $(".table_menu_list").height($(window).height()-215);
  //当文档窗口发生改变时 触发  
    $(window).resize(function(){
	$(".widget-box").height($(window).height()-215);
	 $(".table_menu_list").width($(window).width()-260);
	  $(".table_menu_list").height($(window).height()-215);
	})
 
/*******树状图*******/
var setting = {
	view: {
		dblClickExpand: false,
		showLine: false,
		selectedMulti: false
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
			pIdKey: "pId",
			rootPId: ""
		}
	},
	callback: {
		beforeClick: function(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("tree");
			if (treeNode.isParent) {
				zTree.expandNode(treeNode);
				return false;
			} else {
				demoIframe.attr("src",treeNode.file + ".html");
				return true;
			}
		}
	}
};

var code;
		
$(document).ready(function(){
	demoIframe.bind("load", loadReady);
});

function loadReady(){
    var htmlobj = $.ajax({url:"http://localhost:8080/tTask",async:false});
    console.log(htmlobj.responseText);
    $("#testIframe table tbody").append("&lt;tr>test&lt;/tr>");
}

/*产品-编辑*/
function member_edit(title,url,id,w,h){
	layer_show(title,url,w,h);
}

/*产品-删除*/
function member_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$(obj).parents("tr").remove();
		layer.msg('已删除!',{icon:1,time:1000});
	});
}
//面包屑返回值
var index = parent.layer.getFrameIndex(window.name);
parent.layer.iframeAuto(index);
$('.Order_form').on('click', function(){
	var cname = $(this).attr("title");
	var chref = $(this).attr("href");
	var cnames = parent.$('.Current_page').html();
	var herf = parent.$("#iframe").attr("src");
    parent.$('#parentIframe').html(cname);
    parent.$('#iframe').attr("src",chref).ready();;
	parent.$('#parentIframe').css("display","inline-block");
	parent.$('.Current_page').attr({"name":herf,"href":"javascript:void(0)"}).css({"color":"#4c8fbd","cursor":"pointer"});
    parent.layer.close(index);
	
});
</script>
