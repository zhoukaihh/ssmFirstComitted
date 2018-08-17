package com.qfedu.demo.ssh.service;

import java.util.List;

import com.qfedu.demo.ssh.dto.MenuDto;
import com.qfedu.demo.ssh.dto.UserDto;
import com.qfedu.demo.ssh.vo.DataTable;

public interface MenuService {

	List<MenuDto> findAllTopMenus(UserDto u);

	DataTable<MenuDto> findAllBySearch(Integer start, Integer length, String search, String noDir);

	void createChild(MenuDto m);

	void create(MenuDto dto);

	void deltte(Integer[] id);

	MenuDto findById(Integer id);

	void update(MenuDto dto);

}
