package com.qfedu.demo.ssh.dto;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qfedu.demo.ssh.po.User;

public class UserDto {
	private final static Logger LOG = LogManager.getLogger(UserDto.class);

	public UserDto () {
		
	}
	
	public UserDto (User u) {
		this.setLoginName(u.getLoginname());
		this.setId(u.getId());
		this.setName(u.getName());
		this.setPassword(u.getPassword());
		this.setCreateTime(u.getCreatetime());
		this.gender = u.getGender();
		this.roles = RoleDto.getDtos(u.getRoles());
	}
	
	private Integer id;

	private String loginName;

	private String password;

	private String name;

	private String gender;
	
	private String genderName;
	
	private Date createTime;

	private List<RoleDto> roles = new ArrayList<RoleDto>();
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getDT_RowId () {
		return id;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", locale = "zh", timezone="GMT+8")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public String getRoleIds () {
		String str = "";
		for (RoleDto r : roles) {
			if (!str.equals("")) {
				str += ",";
			}
			str += r.getId();
		}
		return str;
	}
	
	public String getRoleNames () {
		String str = "";
		for (RoleDto r : roles) {
			if (!str.equals("")) {
				str += ",";
			}
			str += r.getName();
		}
		return str;
	}
	
	public void setRoleIds (Integer[] roleIds) {
		LOG.info(Arrays.toString(roleIds));
		// StringUtils.isEmpty(str)
		if (roleIds == null || roleIds.length == 0) {
			return;
		}
		for (Integer id : roleIds) {
			RoleDto r = new RoleDto ();
			r.setId(id);
			roles.add(r);
		}
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGenderName() {
		return genderName;
	}

	public void setGenderName(String genderName) {
		this.genderName = genderName;
	}

	@JsonIgnore
	public List<RoleDto> getRoles() {
		return roles;
	}

	public void setRoles(List<RoleDto> roles) {
		this.roles = roles;
	}

	/**
	 * @param pos
	 * @return
	 */
	public static List<UserDto> getDtos (List<User> pos) {
		List<UserDto> dtos = new ArrayList<UserDto>();
		for (User u : pos) {
			UserDto dto = new UserDto (u);
			dtos.add(dto);
		}
		return dtos;
	}
}

