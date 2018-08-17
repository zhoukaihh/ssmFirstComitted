package com.qfedu.demo.ssh.exception;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

// @ControllerAdvice
public class MyExceptionHandler {
	private final static Logger LOG = LogManager.getLogger(MyExceptionHandler.class);
	
	@ExceptionHandler(Exception.class)
	public String handle (Exception e) {
		String error;
		try {
			error = URLEncoder.encode(e.getMessage(), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			error = "未知异常！";
		}
		LOG.error(error, e);
		return "redirect:/login?error=" + error;
	}
}
