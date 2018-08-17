package com.qfedu.demo.ssh.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.qfedu.demo.ssh.dto.RoleDto;
import com.qfedu.demo.ssh.mapper.MenuMapper;
import com.qfedu.demo.ssh.mapper.RoleMapper;
import com.qfedu.demo.ssh.mapper.RoleMenuMapper;
import com.qfedu.demo.ssh.po.Menu;
import com.qfedu.demo.ssh.po.MenuExample;
import com.qfedu.demo.ssh.po.Role;
import com.qfedu.demo.ssh.po.RoleExample;
import com.qfedu.demo.ssh.po.RoleMenu;
import com.qfedu.demo.ssh.po.RoleMenuExample;
import com.qfedu.demo.ssh.po.UserRole;
import com.qfedu.demo.ssh.service.RoleService;
import com.qfedu.demo.ssh.util.SSMUtil;
import com.qfedu.demo.ssh.vo.DataTable;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {
	private final static Logger LOG = LogManager.getLogger(RoleServiceImpl.class);

	@Resource
	private RoleMapper roleDao;
	
	/**
	 * 查询角色列表信息
	 */
	@Override
	public DataTable<RoleDto> findAllBySearch(Integer start, Integer length, String search, String nameDir) {
		DataTable data = new DataTable();
		// 分页设置
		PageHelper.startPage(SSMUtil.getPage(start, length), length);
		// 生成查询条件和排序
		RoleExample example = new RoleExample();
		RoleExample.Criteria c = example.createCriteria();
		c.andNameLike("%" + search + "%");
		RoleExample.Criteria cOr = example.or();
		cOr.andNameLike("%" + search + "%");
		example.setOrderByClause("name " + nameDir);
		// 返回结果
		List<Role> pos = roleDao.selectByExample(example);
		// 设置用角色联的菜单
		for (Role po : pos) {
			po.setMenus(this.getMenusByRole(po.getId()));
		}
		// 查询总数
		Long count = Long.valueOf(roleDao.countByExample(example));
		List<RoleDto> dtos = RoleDto.getDtos(pos);

		data.setData(dtos);
		data.setRecordsFiltered(count);
		data.setRecordsTotal(count);
		return data;
	}
	
	@Resource
	private RoleMenuMapper roleMenuDao;
	
	@Resource
	private MenuMapper menuDao;
	
	/**
	 *  获取角色选中的菜单
	 */
	@Override
	public List<Menu> getMenusByRole(Integer roleId) {
		// 根据角色id查询菜单id集合
		RoleMenuExample rme = new RoleMenuExample();
		rme.createCriteria().andRoleIdEqualTo(roleId);
		List<RoleMenu> rmList = roleMenuDao.selectByExample(rme);
		// 构造角色id集合
		List<Integer> mIds = new ArrayList<Integer>();
		for (RoleMenu rm : rmList) {
			mIds.add(rm.getMenuId());
		}
		// 通过菜单id集合查询菜单
		MenuExample e = new MenuExample();
		e.createCriteria().andIdIn(mIds);
		List<Menu> menus = menuDao.selectByExample(e);
		return menus;
	}

	/**
	 * 创建角色
	 */
	@Override
	public void create(RoleDto r, Integer[] menuIds) {
		Role po = new Role ();
		po.setDescription(r.getDescription());
		po.setName(r.getName());
//		插入角色
		roleDao.insert(po);
		
//		插入关系数据，要求po的id回写
		for (Integer menuId : menuIds) {
			RoleMenu rm = new RoleMenu();
			rm.setMenuId(menuId);
			rm.setRoleId(po.getId());
			this.roleMenuDao.insert(rm);
		}
		
		// roleDao.create (po);
	}

	@Override
	public List<RoleDto> findAll() {
		List<Role> pos = roleDao.selectByExample(new RoleExample());
		return RoleDto.getDtos(pos);
	}

	@Override
	public RoleDto findById(Integer id) {
		// Role po = roleDao.findById (id);
		return new RoleDto (null);
	}

	/**
	 * 修改角色
	 */
	@Override
	public void update(RoleDto r) {
//		Role po = roleDao.findById(r.getId());
//		po.setDescription(r.getDescription());
//		po.setName(r.getName());
//		List<Menu> menus = new ArrayList<Menu>();
//		for (String idStr : r.getMenuIds().split(",")) {
//			Integer id = Integer.parseInt(idStr);
//			Menu m = new Menu ();
//			m.setId(id);
//			menus.add(m);
//		}
//		po.setMenus(menus);
//		roleDao.update(po);
	}

	
	/**
	 * 删除角色
	 */
	@Override
	public void delete(Integer[] ids) {
		for (Integer id : ids) {
//			删除表关系
			RoleMenuExample rme = new RoleMenuExample();
			rme.createCriteria().andRoleIdEqualTo(id);
			roleMenuDao.deleteByExample(rme);
//			删除角色
			roleDao.deleteByPrimaryKey(id);
		}
	}
}
