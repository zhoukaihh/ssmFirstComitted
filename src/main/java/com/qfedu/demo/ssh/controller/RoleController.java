package com.qfedu.demo.ssh.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qfedu.demo.ssh.dto.MenuDto;
import com.qfedu.demo.ssh.dto.RoleDto;
import com.qfedu.demo.ssh.service.MenuService;
import com.qfedu.demo.ssh.service.RoleService;
import com.qfedu.demo.ssh.vo.DataTable;
import com.qfedu.demo.ssh.vo.Result;

@Controller
@RequestMapping("/role")
public class RoleController {
	private final static Logger LOG = LogManager.getLogger(RoleController.class);

	/**
	 * 角色管理主页面
	 * 
	 * @return
	 */
	@RequestMapping
	public String toHome() {
		return "role/page";
	}

	@Resource
	private RoleService roleService;

	/**
	 * 获取角色列表数据
	 * 
	 * @param draw
	 * @param start
	 * @param length
	 * @param search
	 * @param nameDir
	 * @return
	 */
	@RequestMapping("/list")
	@ResponseBody
	public DataTable<RoleDto> list(Integer draw, Integer start, Integer length,
			@RequestParam("search[value]") String search, @RequestParam("order[0][dir]") String nameDir) {
		DataTable<RoleDto> dt = roleService.findAllBySearch(start, length, search, nameDir);
		dt.setDraw(++draw);
		return dt;
	}

	/**
	 * 加载角色创建表单
	 * 
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() {
		return "role/create";
	}

	/**
	 * 提交创建表单
	 * 
	 * @param r
	 * @param menuIds
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@ResponseBody
	public Result create(RoleDto r, Integer[] menuIds) {
		roleService.create(r, menuIds);
		return new Result().setSuccess(true).setMessage("创建角色成功！");
	}

	/**
	 * 加载修改表单
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(Integer id, Map<String, Object>map) {
		RoleDto role = roleService.findById (id);
		map.put("role", role);
		return "role/update";
	}

	/**
	 * 提交修改表单
	 * @param r
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public Result update (RoleDto r) {
		roleService.update(r);
		return new Result ().setSuccess(true).setMessage("修改角色成功！");
	}
	/**
	 * 角色选择菜单的主页面
	 * 
	 * @return
	 */
	@RequestMapping("/menus")
	public String selectMenus() {
		return "role/menuSelectorPage";
	}

	@Resource
	private MenuService menuService;

	@RequestMapping("/menu/list")
	@ResponseBody
	public DataTable<MenuDto> listMenus(Integer draw, Integer start, Integer length,
			@RequestParam("search[value]") String search, @RequestParam("order[0][dir]") String noDir) {
		DataTable<MenuDto> dt = menuService.findAllBySearch(start, length, search, noDir);
		dt.setDraw(++draw);
		return dt;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Result delete(Integer[] id){
		roleService.delete(id);
		return new Result().setSuccess(true).setMessage("删除角色成功");
	}
	
}
