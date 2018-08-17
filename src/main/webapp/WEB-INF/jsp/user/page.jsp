<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

			<div class="row">
                <div class="col-lg-12">
                    <h4>用户管理</h4>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="userTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>登录名</th>
                                        <th>姓名</th>
                                        <th>性别</th>
                                        <th>角色</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                            </table>
                            <!-- /.table-responsive -->
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <script>
            $(document).ready(function() {
            	var tableId = 'userTable';
            	// 初始化列表，并触发后台的json数据获取
                var table = $('#' + tableId).DataTable({
                	"processing": true,
                    "serverSide": true,
                    "rowId" : 'id',
                    "ajax": {
                        "url": "${pageContext.request.contextPath}/user/list",
                        "type": "GET"
                    },
                    "order": [[ 1, "desc" ]] ,
                    "columns": [
                    	{ "data": "id" , "orderable" : false},
                    	{ "data": "loginName" },
                        { "data": "name" , "orderable" : false},
                        { "data": "genderName" , "orderable" : false},
                        { "data": "roleNames" , "orderable" : false},
                        { "data": "createTime" , "orderable" : false},
                        // 下面在操作列中添加了修改和删除按钮
                        { "data": null , "orderable" : false, "defaultContent": "<a class='btn btn-primary btn-xs' name='update'>修改</a> <a class='btn btn-primary btn-warning btn-xs' name='delete'>删除</a>"}
                    ]
                });
                // 设置列表中按钮的事件
                $('#' + tableId + ' tbody').on( 'click', 'a', function () {
                	// this表示a标签对应dom，$(this)将其转为jQuery对象，获取按钮所在行的json对象，及UserDto
                    var data = table.row( $(this).parents('tr') ).data();
                	// 调用修改方法
                	if ($(this).attr('name') == 'update') {
                		updateUser(data.id);
                	}
                	// 调用删除方法
					if ($(this).attr('name') == 'delete') {
						deleteUser (data.id);
                	}
                } );
             	// 设置列表多选
                $('#' + tableId + ' tbody').on( 'click', 'tr', function () {
                	// 如果有info样式则删除，没有则添加
                	$(this).toggleClass('info');
                } );
             	
                // 添加工具栏按钮，找到设置分页的div，并添加创建和批量删除按钮的a标签
                $('#' + tableId + '_length').append (" <a class='btn btn-primary btn-sm' onclick='createUser();'>创建</a> <a class='btn btn-primary btn-warning btn-sm' onclick='deleteUsers();'>批量删除</a>");
            });

            function createUser () {
            	// 创建userDailog的div，如果之前存在，先删除
            	$('#userDialog').remove();
            	$('body').append ('<div class="modal fade" id="userDialog" tabindex="-1" role="dialog" aria-labelledby="userModalLabel"></div>');
            	// 显示对话框
            	$('#userDialog').load ('${pageContext.request.contextPath}/user/create', function () {
            		$('#userDialog').modal ('show');
            	});
            	// $('#page-wrapper').load ('${pageContext.request.contextPath}/user/create');
            }
            
            function updateUser (id) {
            	// 创建userDailog的div，如果之前存在，先删除
            	$('#userDialog').remove();
            	$('body').append ('<div class="modal fade" id="userDialog" tabindex="-1" role="dialog" aria-labelledby="userModalLabel"></div>');
            	// 
            	$('#userDialog').load ('${pageContext.request.contextPath}/user/update?id=' + id, function () {
            		// 调用modal控件的show方法
            		$('#userDialog').modal ('show');
            	});
            }
            
            function deleteUser (id) {
            	if (!confirm ('确定要删除选定的用户吗？')) {
            		return;
            	}
            	$.post ('${pageContext.request.contextPath}/user/delete', {id : id}, function (result) {
		    		if (result.success) {
		    			var tableId = 'userTable';
				    	var table = $('#' + tableId).DataTable();
		    			table.rows('.info').remove().draw(false);
		    		} 
		    		alert (result.message);
		    	});
            }
            
            function deleteUsers () {
            	// 获取DataTable
		    	var tableId = 'userTable';
		    	var table = $('#' + tableId).DataTable();
		    	// 查找样式为info的行，包含所有UserDto属性
		    	var rows = table.rows('.info').data();
		    	// 判断用户是否有选择
		    	if (rows.length == 0) {
		    		alert ('请选择至少一条记录！');
		    		return;
		    	}
		    	// 让用户确认删除
		    	if (!confirm ('是否删除选中的用户？')) {
		    		return;
		    	}
		    	// 拼接id字符串，多个id逗号隔开
		    	var ids = '';
		    	for (var i = 0; i < rows.length; i ++) {
		    		if (ids != '') {
		    			ids += ',';
		    		}
		    		ids += rows[i].id;
		    	}
		    	// 发送ajax请求，如果成功刷新本页面，否则提示用户操作失败
		    	deleteUser(ids);
		    }
		    </script>