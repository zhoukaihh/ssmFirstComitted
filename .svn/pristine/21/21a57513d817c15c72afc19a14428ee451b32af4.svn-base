package com.qfedu.demo.ssh.dto;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.qfedu.demo.ssh.po.Dictionary;

public class DictionaryDto {
	private final static Logger LOG = LogManager.getLogger(DictionaryDto.class);

	private Integer id;

	private String value;

	private String name;

	private String type;

	private String description;
	
	private Boolean selected = false;

	public DictionaryDto() {
	}
	
	public DictionaryDto(Dictionary po) {
		this.id = po.getId();
		this.value = po.getValue();
		this.name = po.getName();
		this.type = po.getType();
		this.description = po.getDescription();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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
	public static List<DictionaryDto> getDtos (List<Dictionary> pos) {
		List<DictionaryDto> dtos = new ArrayList<DictionaryDto>();
		for (Dictionary po : pos) {
			dtos.add(new DictionaryDto (po));
		}
		return dtos;
	}
	
}
