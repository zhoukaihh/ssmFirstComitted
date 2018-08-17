package com.qfedu.demo.ssh.service;

import java.util.List;

import com.qfedu.demo.ssh.dto.RoleDto;
import com.qfedu.demo.ssh.po.Menu;
import com.qfedu.demo.ssh.vo.DataTable;

public interface RoleService {

	DataTable<RoleDto> findAllBySearch(Integer start, Integer length, String search, String nameDir);

	void create(RoleDto r, Integer[] menuIds);

	List<RoleDto> findAll();

	RoleDto findById(Integer id);

	void update(RoleDto r);

	List<Menu> getMenusByRole(Integer roleId);

	void delete(Integer[] id);

}
