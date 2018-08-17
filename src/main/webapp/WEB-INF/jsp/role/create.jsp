<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	创建角色
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <form role="form" id="roleCreateForm">
                                        <div class="form-group">
                                            <label>名称</label>
                                            <input class="form-control" placeholder="请输入名称" name="name">
                                        </div>
                                       	<div class="form-group">
                                            <label>描述</label>
                                            <input class="form-control" placeholder="请输入描述" name="description">
                                        </div>
                                        <div class="form-group input-group">
                                        	<input type="hidden" name="menuIds" id="roleFormMenuIds">
                                            <input type="text" class="form-control" placeholder="请选择菜单" id="roleFormMenuNames">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="selectRoleMenus();"><i class="fa fa-search"></i>
                                                </button>
                                            </span>
                                        </div>
                                        <button type="button" onclick="submitRoleCreateForm ();" class="btn btn-default">提交</button>
                                        <button type="reset" class="btn btn-default">重置</button>
                                    </form>
                                </div>
                               
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
                <script type="text/javascript">
                $(document).ready(function () {	
    	   			$('#roleCreateForm').bootstrapValidator({
    		            // 默认错误消息
    	   				message: '输入值不合法',
    	   				// 设置验证成功或者失败的图标
    		            feedbackIcons: {
    		                valid: 'glyphicon glyphicon-ok',
    		                invalid: 'glyphicon glyphicon-remove',
    		                validating: 'glyphicon glyphicon-refresh'
    		            },
    		            // 设置不同字段的验证规则和错误信息
    		            fields: {
    		                name: {
    		                    message: '名称不合法',
    		                    validators: {
    		                        notEmpty: {
    		                            message: '名称不能为空'
    		                        },
    		                        stringLength: {
    		                            min: 2,
    		                            max: 30,
    		                            message: '请输入2到30个字符'
    		                        },
    		                        regexp: {
    		                            regexp: /^[a-zA-Z0-9_\. \u4e00-\u9fa5 ]+$/,
    		                            message: '名称只能由字母、数字、点、下划线和汉字组成 '
    		                        }
    		                    }
    		                },
    		                description: {
    		                    message: '描述不合法',
    		                    validators: {
    		                        notEmpty: {
    		                            message: '描述不能为空'
    		                        },
    		                        stringLength: {
    		                            min: 3,
    		                            max: 30,
    		                            message: '请输入3到30个字符'
    		                        },
    		                        regexp: {
    		                            regexp:  /^[a-zA-Z0-9_\. \u4e00-\u9fa5 ]+$/,
    		                            message: '描述只能由字母、数字、点、下划线、汉字组成 '
    		                        }
    		                    }
    		                },
    		                menuIds : {
    		                	validators: {
    		                        notEmpty: {
    		                            message: '菜单不能为空！'
    		                        }
    		                    }
    		                }
    		            }
    		        });
    	   			
    	   			// $('#roleCreateForm').data('bootstrapValidator').enableFieldValidators('roleIds', false);
    		    });
                
                function submitRoleCreateForm () {
                	// 获取关联的bootstrapValidator对象	
    		   		var bv = $('#roleCreateForm').data('bootstrapValidator');
    		        bv.validate();
    		        if (!bv.isValid()) {
    		        	return;
    		        }
    		        $.post ('${pageContext.request.contextPath}/role/create', $('#roleCreateForm').serializeArray(), function (result) {
    		 			if (result.success) {
    		 				$('#page-wrapper').load ('${pageContext.request.contextPath}/role');
    		 				$('#roleDialog').remove();
    		 			} else {
    		 				alert (result.message);
    		 			}
    		 		});
    		 	}
                	
                	function selectRoleMenus () {
                		$('#roleDialog').hide().attr('id', "roleDialog2");
                		
                		$('body').append ('<div class="modal fade" id="roleDialog" tabindex="-1" role="dialog" aria-labelledby="roleModalLabel"></div>');
                		$('#roleDialog').load ('${pageContext.request.contextPath}/role/menus', function () {
                    		
                			$('#roleDialog').modal ('show');
                    	});
                	}
                </script>
            </div>
