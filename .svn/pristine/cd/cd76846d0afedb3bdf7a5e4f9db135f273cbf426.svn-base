package com.qfedu.demo.ssh.dto;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.qfedu.demo.ssh.po.Menu;
import com.qfedu.demo.ssh.po.Role;

public class RoleDto {
	private final static Logger LOG = LogManager.getLogger(RoleDto.class);
	
	private Integer id;

	private String name;
	
	private String description;

	private String menuIds = "";
	
	private String menuNames = "";
	
	/**
	 * 用户修改表单显示角色时，和该用户关联的角色，应该是选中状态
	 */
	private Boolean selected = false;
	
	public RoleDto (Role r) {
		this.id = r.getId();
		this.name = r.getName();
		this.description = r.getDescription();
		for (Menu m : r.getMenus()) {
			if (!menuIds.equals("")) {
				menuIds += ",";
				menuNames += ",";
			}
			menuIds += m.getId();
			menuNames += m.getName();
		}
	}
	
	public RoleDto () {
		
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getMenuIds() {
		return menuIds;
	}

	public void setMenuIds(String menuIds) {
		this.menuIds = menuIds;
	}

	public String getMenuNames() {
		return menuNames;
	}

	public void setMenuNames(String menuNames) {
		this.menuNames = menuNames;
	}

	public Boolean getSelected() {
		return selected;
	}

	public void setSelected(Boolean selected) {
		this.selected = selected;
	}

	/**
	 * @param pos
	 * @return
	 */
	public static List<RoleDto> getDtos (List<Role> pos) {
		List<RoleDto> dtos = new ArrayList<RoleDto>();
		for (Role po : pos) {
			dtos.add(new RoleDto (po));
		}
		return dtos;
	}
}
