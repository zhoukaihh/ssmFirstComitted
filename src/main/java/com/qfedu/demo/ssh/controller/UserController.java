package com.qfedu.demo.ssh.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.qfedu.demo.ssh.dto.DictionaryDto;
import com.qfedu.demo.ssh.dto.RoleDto;
import com.qfedu.demo.ssh.dto.UserDto;
import com.qfedu.demo.ssh.service.DictionaryService;
import com.qfedu.demo.ssh.service.RoleService;
import com.qfedu.demo.ssh.service.UserService;
import com.qfedu.demo.ssh.vo.DataTable;
import com.qfedu.demo.ssh.vo.Result;

@Controller
@RequestMapping("/user")
@SessionAttributes ("user")
public class UserController {
	private final static Logger LOG = LogManager.getLogger(UserController.class);

	@Resource // @Autowired
	private UserService userService;

	/**
	 * 到首页
	 * @return
	 */
	@RequestMapping
	public String toHome() {
		return "user/page";
	}

	/**
	 * 返回用户列表信息
	 * @return
	 */
	@RequestMapping("/list")
	@ResponseBody
	public DataTable<UserDto> list(Integer draw, Integer start, Integer length, @RequestParam("search[value]") String search,
			@RequestParam("order[0][dir]") String loginDir) {
		DataTable<UserDto> data = userService.findAllBySearch(start, length, search, loginDir);
		data.setDraw(++draw);
		return data;
	}

	/**
	 * 返回需要修改的对象
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(Integer id, Map<String, Object> map) {
		UserDto u = userService.findById(id);
		List<RoleDto> roles = userService.findAllRolesWithSelected(id);
		map.put("user2", u);
		map.put("roles", roles);
		return "user/update";
	}

	/**
	 * 修改用户信息
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public Result update(UserDto u) {
		userService.update(u);
		return new Result().setSuccess(true).setMessage("修改用户成功！");
	}

	/**
	 * 引入需要的对象
	 * @return
	 */
	@Resource
	private RoleService roleService;

	@Resource
	private DictionaryService dictionaryService;
	
	/**
	 *返回创建页面并提供角色和性别备选
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create(Map<String, Object> map) {
		List<RoleDto> roles = roleService.findAll();
		List<DictionaryDto> dics = dictionaryService.findAllByType ("gender");
		map.put("roles", roles);
		map.put("dictionaries", dics);
		return "user/create";
	}

	/**
	 * 提交数据并创建用户
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@ResponseBody
	public Result create(UserDto u, Integer[] roleIds) {
		userService.create(u, roleIds);
		return new Result().setSuccess(true).setMessage("创建用户成功！");
	}

	/**
	 * 删除用户
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Result delete(Integer[] id, Map<String, Object>map) {
		UserDto u = (UserDto) map.get("user");
		userService.delete(id, u);
		return new Result().setSuccess(true).setMessage("删除用户成功！");
	}
}
