package com.qfedu.demo.ssh.controller;
import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qfedu.demo.ssh.dto.DictionaryDto;
import com.qfedu.demo.ssh.service.DictionaryService;
import com.qfedu.demo.ssh.vo.DataTable;
import com.qfedu.demo.ssh.vo.Result;

@Controller
@RequestMapping("/dictionary")
public class DictionaryController {
	private final static Logger LOG = LogManager.getLogger(DictionaryController.class);
	
	@RequestMapping
	public String toHome () {
		return "dictionary/page";
	}
	
	@Resource
	private DictionaryService dictionaryService;
	
	@RequestMapping("/list")
	@ResponseBody
	public DataTable<DictionaryDto> list(Integer draw, Integer start, Integer length, @RequestParam("search[value]") String search,
			@RequestParam("order[0][dir]") String typeDir) {
		DataTable<DictionaryDto> data = dictionaryService.findAllBySearch(start, length, search, typeDir);
		data.setDraw(++draw);
		return data;
	}
	
	@RequestMapping(value= "/create", method = RequestMethod.GET)
	public String create () {
		return "dictionary/create";
	}
	
	@RequestMapping(value= "/create", method = RequestMethod.POST)
	@ResponseBody
	public Result create (DictionaryDto dto) {
		this.dictionaryService.create(dto);
		return new Result().setSuccess(true).setMessage("创建数据字典成功！");
	}
}
