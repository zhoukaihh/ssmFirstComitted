<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

			<div class="row">
                <div class="col-lg-12">
                    <h4>选择菜单</h4>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="menuTable">
                                <thead>
                                    <tr>
                                    	<th>编号</th>
                                        <th>名称</th>
                                        <th>上级</th>
                                        <th>图标</th>
                                        <th>URL</th>
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
            // 用于存放用户点击菜单时的临时id和名称，当用户点击确定时，该值才覆盖roleMenuIds和roleMenuNames的值
            var selectedMenu = {
            	ids : $('#roleFormMenuIds').val(),
            	names : $('#roleFormMenuNames').val()
            };
            console.log (selectedMenu);
            $(document).ready(function() {
            	var tableId = 'menuTable';
            	// 初始化列表，并触发后台的json数据获取
                var table = $('#' + tableId).DataTable({
                	"processing": true,
                    "serverSide": true,
                    "rowId" : 'id',
                    "ajax": {
                        "url": "${pageContext.request.contextPath}/role/menu/list",
                        "type": "GET"
                    },
                    "order": [[ 0, "asc" ]] ,
                    "columns": [
                    	{ "data": "no"},
                    	{ "data": "name" , "orderable" : false},
                        { "data": "parentName" , "orderable" : false},
                        { "data": "icon" , "orderable" : false},
                        { "data": "url" , "orderable" : false}
                    ],
                    // 创建行之后的回调方法
                    "createdRow" : function( row, data, dataIndex ) {
                    	// 获取菜单的ids
                    	var ids = selectedMenu.ids.split(',');
                    	for (var i = 0; i < ids.length; i ++) {
                    		if (data.id == ids[i]) {
                    			$(row).addClass( 'info' );
                    		}
                    	}
                    }
                });
             	// 设置列表多选
                $('#' + tableId + ' tbody').on( 'click', 'tr', function () {
                	var r = table.row( this ).data();
                	console.log (r);
                	// 如果有info样式则删除，没有则添加
                	if ($(this).attr ('class').indexOf ('info') > -1) {
                		// 删除
                		var ids = selectedMenu.ids.split(',');
                		var names = selectedMenu.names.split(',');
                		selectedMenu.ids = '';
                		selectedMenu.names = '';
                		for (var i = 0; i < ids.length; i ++) {
                			if (ids[i] != r.id) {
                				if (selectedMenu.ids != '') {
                					selectedMenu.ids += ',';
                    				selectedMenu.names += ',';
                				}
                				selectedMenu.ids += ids[i];
                				selectedMenu.names += names[i];
                			}
                		}
                		console.log ('after delete :' + selectedMenu.names);
                	} else {
                		// 添加
                		if (selectedMenu.ids != '') {
           					selectedMenu.ids += ',';
               				selectedMenu.names += ',';
           				}
                		selectedMenu.ids += r.id;
        				selectedMenu.names += r.name;
        				console.log ('after add :' + selectedMenu.names);
                	}
                	$(this).toggleClass('info');
                } );
                // 添加工具栏按钮，找到设置分页的div，并添加创建和批量删除按钮的a标签
                $('#' + tableId + '_length').append (" <a class='btn btn-primary btn-sm' onclick='selectMenuOK();'>确定</a> <a class='btn btn-primary btn-warning btn-sm' onclick='selectMenuCancel();'>取消</a>");
            });
            
            function selectMenuOK () {
            	var table = $('#menuTable').DataTable ();
            	$('#roleFormMenuIds').val (selectedMenu.ids);
            	$('#roleFormMenuNames').val (selectedMenu.names);
            	$('#roleDialog').remove();
            	$('#roleDialog2').show().attr('id', 'roleDialog');
            }
            
            function selectMenuCancel () {
            	$('#page-wrapper').remove();
            	$('#page-wrapper2').show().attr('id', 'page-wrapper');
		    }
		    </script>