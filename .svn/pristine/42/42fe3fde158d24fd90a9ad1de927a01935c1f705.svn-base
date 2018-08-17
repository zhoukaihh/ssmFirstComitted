package com.qfedu.demo.ssh.service;

import java.util.List;

import com.qfedu.demo.ssh.dto.DictionaryDto;
import com.qfedu.demo.ssh.vo.DataTable;

public interface DictionaryService {

	List<DictionaryDto> findAllByType(String string);

	DataTable<DictionaryDto> findAllBySearch(Integer start, Integer length, String search, String typeDir);

	void create(DictionaryDto dto);

}
