package com.qfedu.demo.ssh.service.impl;
import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.qfedu.demo.ssh.dto.DictionaryDto;
import com.qfedu.demo.ssh.mapper.DictionaryMapper;
import com.qfedu.demo.ssh.po.Dictionary;
import com.qfedu.demo.ssh.po.DictionaryExample;
import com.qfedu.demo.ssh.service.DictionaryService;
import com.qfedu.demo.ssh.vo.DataTable;

@Service
@Transactional
public class DictionaryServiceImpl implements DictionaryService {
	private final static Logger LOG = LogManager.getLogger(DictionaryServiceImpl.class);

	@Resource
	private DictionaryMapper dictionaryDao;
	
	@Override
	public List<DictionaryDto> findAllByType(String string) {
		DictionaryExample de = new DictionaryExample ();
		de.createCriteria().andTypeEqualTo(string);
		List<Dictionary> pos = dictionaryDao.selectByExample(de);
		return DictionaryDto.getDtos(pos);
	}

	@Override
	public DataTable<DictionaryDto> findAllBySearch(Integer start, Integer length, String search, String typeDir) {
//		List<Dictionary> pos = this.dictionaryDao.findAllBySearch(start, length, search, typeDir);
//		Long count = (Long) this.dictionaryDao.countAllBySearch (search);
//		DataTable<DictionaryDto> dt = new DataTable<DictionaryDto> ();
//		dt.setData(DictionaryDto.getDtos(pos));
//		dt.setRecordsFiltered(count);
//		dt.setRecordsTotal(count);
//		return dt;
		return null;
	}

	@Override
	public void create(DictionaryDto dto) {
//		// Dictionary d2 = this.dictionaryDao.findByTypeAndName(dto.getType(), dto.getName());
//		if (d2 != null) {
//			throw new RuntimeException ("该数据字典已经存在！");
//		}
//		Dictionary po = new Dictionary ();
//		po.setDescription(dto.getDescription());
//		po.setName(dto.getName());
//		po.setType(dto.getType());
//		po.setValue(dto.getValue());
		// this.dictionaryDao.create(po);
	}
}
