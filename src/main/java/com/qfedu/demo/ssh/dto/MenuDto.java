package com.qfedu.demo.ssh.dto;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.qfedu.demo.ssh.po.Menu;

public class MenuDto {
	
	private final static Logger LOG = LogManager.getLogger(MenuDto.class);
	
	private Integer id;
	
	private String name;
	
	private MenuDto parent;
	
	private List<MenuDto> children = new ArrayList<MenuDto>();
	
	private String url;
	
	private String icon;

	private String no;
	
	private Integer parentId;
	
	private String parentName;
	
	private Boolean active = false;
	
	/**
	 * 角色修改表单显示菜单时，和该角色关联的菜单，应该是选中状态
	 */
	private Boolean selected = false;
	
	public MenuDto () {
		
	}
	
	public MenuDto (Menu m, Boolean loadChildren) {
		this.id = m.getId();
		this.name = m.getName();
		this.url = m.getUrl();
		this.icon = m.getIcon();
		this.no = m.getNo();
		if (m.getParent() != null) {
			this.parent = new MenuDto (m.getParent(), false);
		}
		if (loadChildren) {
			this.children = MenuDto.getDtos(m.getChildren(), false);
		}
		
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

	public MenuDto getParent() {
		return parent;
	}

	public void setParent(MenuDto parent) {
		this.parent = parent;
	}

	public List<MenuDto> getChildren() {
		return children;
	}

	public void setChildren(List<MenuDto> children) {
		this.children = children;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}
	
	public String getActiveCls () {
		if (active) {
			return "active";
		}
		return "";
	}
	
	
	
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	/**
	 * @return
	 */
	public String getParentName () {
		if (this.parent == null) {
			return "";
		}
		return parent.getName();
	}
	
	
	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	
	public Boolean getSelected() {
		return selected;
	}

	public void setSelected(Boolean selected) {
		this.selected = selected;
	}

	public static List<MenuDto> getDtos (List<Menu> pos, Boolean loadChildren) {
		List<MenuDto> dtos = new ArrayList<MenuDto>();
		for (Menu po : pos) {
			dtos.add(new MenuDto(po, loadChildren));
		}
		return dtos;
	}
}
