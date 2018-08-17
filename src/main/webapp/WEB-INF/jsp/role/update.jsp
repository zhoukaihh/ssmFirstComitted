<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.qfedu.demo.ssh.dto.MenuDto" %>
<%@ page import="java.util.List" %>
<%
	List<MenuDto> menus = (List<MenuDto>)request.getAttribute("menus");
%>
<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="roleModalLabel">修改角色</h4>
		    </div>
		    
   			<div class="modal-body">
   				<form role="form" id="roleUpdateForm" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                        	<input class="form-control" placeholder="请输入名称" name="name" value="${role.name }">
                        </div>
                    </div>
                   	<div class="form-group">
                        <label class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入描述" name="description" value="${role.description }">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单</label>
                        <div class="col-sm-10">
                        <%for (MenuDto m : menus) { %>
                        <label class="col-sm-12">
                            <input type="checkbox" value="<%=m.getId()%>" <% if (m.getSelected()) {%>checked="checked"<%} %> name="menuIds"> <%=m.getName()%>
                        </label>
                        <% } %>
                        </div>
                    </div>
                </form>
   			</div>
   			
   			<div class="modal-footer">
   				<button type="button" class="btn btn-default" onclick="submitRoleUpdateForm ();">提交</button>
                <button type="reset" class="btn btn-default">重置</button>
   			</div>
   		</div>
   		<script type="text/javascript">
   		$(document).ready (function () {
   			$('#roleUpdateForm').bootstrapValidator ({
   				fields : {
   					no : {
   						validators: {
	                        notEmpty: {
	                            message: '编号不能为空'
	                        }
   						}
   					},
   					name : {
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
	                            message: '用户名只能由字母、数字、点、下划线和汉字组成 '
	                        }
	                    }
   					},
   					URL : {
	                	validators: {
	                        notEmpty: {
	                            message: 'URL不能为空！'
	                        }
	                    }
	                }
   				}	
   			});	
   		});
   		
   		function submitRoleUpdateForm () {
   			var bv = $('#roleUpdateForm').data ('bootstrapValidator');
   			bv.validate ();
   			if (!bv.isValid()) {
   				return;
   			}
    		$.post ('${pageContext.request.contextPath}/role/update', $('#roleUpdateForm').serializeArray(), function (result) {
    			if (result.success) {
    				$('#roleDialog').modal ('hide');
    				$('#page-wrapper').load ('${pageContext.request.contextPath}/role');
    			} else {
    				alert (result.message);
    			}
    		});
    	}
   		</script>
   	</div>
   	