package com.qfedu.demo.ssh.service;

import java.util.List;

import com.qfedu.demo.ssh.dto.RoleDto;
import com.qfedu.demo.ssh.dto.UserDto;
import com.qfedu.demo.ssh.po.Role;
import com.qfedu.demo.ssh.po.User;
import com.qfedu.demo.ssh.vo.DataTable;

public interface UserService {

	UserDto authenticate(String username, String password);

	List<UserDto> findAll();

	UserDto findById(Integer id);

	void update(UserDto u);

	void create(UserDto u, Integer[] roleIds);

	void delete(Integer[] id, UserDto u);

	DataTable findAllBySearch(Integer start, Integer length, String search, String loginDir);

	List<RoleDto> findAllRolesWithSelected(Integer id);
	
	List<Role> getRolesByUser(Integer userId);

}
