<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.qfedu.demo.ssh.dto.RoleDto" %>
<%@ page import="java.util.List" %>
<%
	List<RoleDto> roles = (List<RoleDto>)request.getAttribute("roles");
%>
<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="userModalLabel">修改用户</h4>
		    </div>
		    
   			<div class="modal-body">
   				<form role="form" id="userUpdateForm" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">ID</label>
                        <div class="col-sm-10">
                        	<input class="form-control" name="id" value="${user2.id}" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">登录名</label>
                        <div class="col-sm-10">
                        	<input class="form-control" placeholder="请输入登录名" name="loginName" value="${user2.loginName }">
                        </div>
                    </div>
                   	<div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入姓名" name="name" value="${user2.name }">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-10">
                        <%for (RoleDto r : roles) { %>
                        <label class="col-sm-12">
                            <input type="checkbox" value="<%=r.getId()%>" <% if (r.getSelected()) {%>checked="checked"<%} %> name="roleIds"> <%=r.getName()%>
                        </label>
                        <% } %>
                        </div>
                    </div>
                </form>
   			</div>
   			
   			<div class="modal-footer">
   				<button type="button" class="btn btn-default" onclick="submitUserUpdateForm ();">提交</button>
                <button type="reset" class="btn btn-default">重置</button>
   			</div>
   		</div>
   		<script type="text/javascript">
   		$(document).ready (function () {
   			$('#userUpdateForm').bootstrapValidator ({
   				fields : {
   					loginName : {
   						validators: {
	                        notEmpty: {
	                            message: '用户名不能为空'
	                        },
	                        stringLength: {
	                            min: 3,
	                            max: 30,
	                            message: '请输入3到30个字符'
	                        },
	                        regexp: {
	                            regexp: /^[a-zA-Z0-9_\. \u4e00-\u9fa5 ]+$/,
	                            message: '用户名只能由字母、数字、点、下划线和汉字组成 '
	                        }
	                    }
   					},
   					roleIds : {
	                	validators: {
	                        notEmpty: {
	                            message: '角色不能为空！'
	                        }
	                    }
	                }
   				}	
   			});	
   		});
   		
   		function submitUserUpdateForm () {
   			var bv = $('#userUpdateForm').data ('bootstrapValidator');
   			bv.validate ();
   			if (!bv.isValid()) {
   				return;
   			}
    		$.post ('${pageContext.request.contextPath}/user/update', $('#userUpdateForm').serializeArray(), function (result) {
    			if (result.success) {
    				$('#userDialog').modal ('hide');
    				$('#page-wrapper').load ('${pageContext.request.contextPath}/user');
    			} else {
    				alert (result.message);
    			}
    		});
    	}
   		</script>
   	</div>
   	