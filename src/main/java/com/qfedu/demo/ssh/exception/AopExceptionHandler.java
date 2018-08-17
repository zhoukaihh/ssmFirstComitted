package com.qfedu.demo.ssh.exception;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Map;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.qfedu.demo.ssh.vo.DataTable;
import com.qfedu.demo.ssh.vo.Result;

/**
 * @author cailei
 *
 */
@Component
public class AopExceptionHandler implements MethodInterceptor {
	private final static Logger LOG = LogManager.getLogger(AopExceptionHandler.class);

	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		LOG.info("method:" + invocation.getMethod().getName());
		LOG.info("args:" + Arrays.toString(invocation.getArguments()));
		Object obj = null;
		try {
			obj = invocation.proceed();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			Class<?> r = invocation.getMethod().getReturnType();
			// 如果方法的返回类型是String，表示异常时需要返回登录页面或者错误页面
			if (String.class.equals(r)) {
				// 1.需要返回登录页面
				if (invocation.getMethod().getName().equals("main") || invocation.getMethod().getName().equals("login")) {
					String error;
					try {
						error = URLEncoder.encode(e.getMessage(), "UTF-8");
					} catch (UnsupportedEncodingException e1) {
						error = "未知异常！";
					}
					return "redirect:/login?error=" + error;
				}
				// 2.需要返回错误页面
				Object[] args = invocation.getArguments();
				Map<String, Object> map = (Map<String, Object>) args[args.length - 1];
				map.put("error", e.getMessage());
				return "error";
			}
			// 3.DataTable获取列表数据是的json请求，异常处理
			if (DataTable.class.equals(r)) {
				Object[] args = invocation.getArguments();
				Integer draw = (Integer)args[0];
				DataTable dt = new DataTable();
				dt.setDraw(++ draw);
				return dt;
			}
			// 4.ajax请求返回Result
			return new Result().setSuccess(false).setMessage(e.getMessage());
		}
		return obj;
	}
}
