<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp"></jsp:include>

<div>
	<label>部门名称</label>
	<input id="deptName" />
	<input id="queryDept" value="查询" type="button"/>

</div>
<!-- 创建easyui表格 -->
<table id="dg"></table>
<!-- 表单窗口  -->
<div id="dlg">
	<form action="#" id="form1">
		<label>部门名称</label>
		<input id="ideptName" />
		<input id="inDept" value="保存" type="button"/>
	</form>

</div>

<script type="text/javascript">
$(function(){
	$("#queryDept").click(function(){
		var deptName = $("#deptName").val();
		if(deptName){
			//刷新
			$('#dg').datagrid({
				queryParams:{
					//和list中分页查询的deptname一样 
					deptname:deptName
				}
			});
		}		
	})
		
	//初始化 表格
	$("#dg").datagrid({		
	    url:'dept/list.do',    
	    columns:[[    
	        {field:'id',title:'ID',width:100},    
	        {field:'deptName',title:'部门名称',width:100}         
	    ]],
	    //自适应高度
	    fit:true,
	    //自适应宽度
	    fitColumns:true,
	 	 //  单选
	    singleSelect:true,
	    //分页
	    pagination:true
	   
	});
	
	 //初始化 表格
	$('#dg').datagrid({		 
		toolbar: [{
			text:'增加',
			iconCls: 'icon-add',
			handler: function(){
				$('#dlg').dialog("setTitle","增加部门");
				 $("#ideptName").val(" ");
				$('#dlg').dialog("open");
				//保存按钮解除所有时间绑定
				$('#inDept').unbind();
				$('#inDept').click(function(){
					var	ideptName = $("#ideptName").val();
					if(ideptName){
						$.ajax({
							url:"dept/add.do",
							data:{deptName:ideptName},
							success:function(data){
								if(data.flag){
									$('#dg').datagrid('reload');
									$('#dlg').dialog({ closed:true })
								}
							}						
						})								
					}
				})				
			}
		},'-',{
			text:'修改',
			iconCls: 'icon-edit',
			handler: function(){
				//修改对话框
				$('#dlg').dialog("setTitle","修改部门");
				//打开对话框
				$('#dlg').dialog("open");
				//保存按钮解除所有时间绑定
				$('#inDept').unbind();
				
				var row = $("#dg").datagrid('getSelected');
				if(row){
					$("#ideptName").val(row.deptName);
					
					$('#inDept').click(function(){
						var	ideptName = $("#ideptName").val();
						if(ideptName){
							$.ajax({
								url:"dept/updata.do",
								data:{id:row.id,deptname:ideptName},
								success:function(data){
									if(data.flag){
										$('#dg').datagrid('reload');
										$('#dlg').dialog("close")
									}
								}						
							})									
						}
					})					
				}
			}
		},{
			text:'删除',
			iconCls: 'icon-remove',
			handler: function(){
				var row = $("#dg").datagrid('getSelected');
				if(row){
					$.ajax({
						url:"dept/del.do",
						data:{id:row.id},
						success:function(data){
							if(data.flag){
								$('#dg').datagrid('reload')
							}
						}						
					})				
				}
			}
		}]
	});

	//初始化窗口
	$('#dlg').dialog({    
	    title: '增加部门',    
	    width: 300,    
	    height:100,    
	    closed: true,    
	    cache: false,        
	    modal: true   
	});	 
})	
</script>
	