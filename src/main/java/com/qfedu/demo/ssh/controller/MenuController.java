package com.qfedu.demo.ssh.controller;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qfedu.demo.ssh.dto.MenuDto;
import com.qfedu.demo.ssh.service.MenuService;
import com.qfedu.demo.ssh.vo.DataTable;
import com.qfedu.demo.ssh.vo.Result;

@Controller
@RequestMapping("/menu")
public class MenuController {
	private final static Logger LOG = LogManager.getLogger(MenuController.class);
	
	/**
	 * 菜单管理主页面
	 * @return
	 */
	@RequestMapping
	public String toHome () {
		return "menu/page";
	}
	
	@Resource
	private MenuService menuService;
	
	/**
	 * 获取菜单DataTable数据
	 * @param draw 返回时需要加一
	 * @param start 开始记录索引
	 * @param length 每页最大记录数
	 * @param search 查询字段内容
	 * @param noDir 编号字段的排序方式
	 * @return
	 */
	@RequestMapping("/list")
	@ResponseBody
	public DataTable<MenuDto> list (Integer draw,Integer start, Integer length, 
			@RequestParam("search[value]") String search, @RequestParam("order[0][dir]") String noDir) {
		DataTable<MenuDto> dt = menuService.findAllBySearch (start, length, search, noDir);
		dt.setDraw(++draw);
		return dt;
	}
	
	/**
	 * 创建父菜单
	 * @return
	 */
	@RequestMapping(value="/create",method=RequestMethod.GET)
	public String create(){
		return "menu/create";
	}
	
	@RequestMapping(value="/create",method=RequestMethod.POST)
	@ResponseBody
	public Result create(MenuDto dto){
		menuService.create(dto);
		return new Result().setSuccess(true).setMessage("创建父菜单成功");
	}
	
	/**
	 * 创建子菜单，并提供父菜单的id
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value= "/createChild" , method = RequestMethod.GET)
	public String createChild (Integer id, Map<String, Object>map) {
		map.put("parentId", id);
		return "menu/createChild";
	}
	
	/**
	 *提交数据并创建子菜单
	 * @return
	 */
	@RequestMapping (value = "/createChild", method = RequestMethod.POST)
	@ResponseBody
	public Result createChild (MenuDto m) {
		menuService.createChild (m);
		return new Result().setSuccess(true).setMessage("创建子菜单成功！");
	}
	
	
	/**
	 * 修改菜单信息
	 */
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public String update(Integer id,Map<String, Object>map){
		MenuDto dto = menuService.findById(id);
		map.put("menu",dto);
		return "menu/update";
	}
	
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public Result update(MenuDto dto){
		menuService.update(dto);
		return new Result().setSuccess(true).setMessage("修改菜单信息成功");
	}
	
	/**
	 * 删除菜单
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Result delete(Integer[] id){
		menuService.deltte(id);
		return new Result().setSuccess(true).setMessage("删除菜单成功");
	}
}
