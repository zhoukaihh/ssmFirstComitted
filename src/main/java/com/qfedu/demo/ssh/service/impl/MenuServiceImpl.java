package com.qfedu.demo.ssh.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.qfedu.demo.ssh.dto.MenuDto;
import com.qfedu.demo.ssh.dto.UserDto;
import com.qfedu.demo.ssh.mapper.MenuMapper;
import com.qfedu.demo.ssh.mapper.RoleMapper;
import com.qfedu.demo.ssh.mapper.RoleMenuMapper;
import com.qfedu.demo.ssh.mapper.UserMapper;
import com.qfedu.demo.ssh.mapper.UserRoleMapper;
import com.qfedu.demo.ssh.po.Menu;
import com.qfedu.demo.ssh.po.MenuExample;
import com.qfedu.demo.ssh.po.Role;
import com.qfedu.demo.ssh.po.RoleMenu;
import com.qfedu.demo.ssh.po.RoleMenuExample;
import com.qfedu.demo.ssh.po.User;
import com.qfedu.demo.ssh.service.MenuService;
import com.qfedu.demo.ssh.service.UserService;
import com.qfedu.demo.ssh.util.SSMUtil;
import com.qfedu.demo.ssh.vo.DataTable;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {
	private final static Logger LOG = LogManager.getLogger(MenuServiceImpl.class);

	/**
	 * 引入需要使用的对象
	 */
	@Resource
	private MenuMapper menuDao;

	@Resource
	private UserMapper userDao;

	@Resource
	private RoleMapper roleDao;

	@Resource
	private UserRoleMapper userRoleDao;

	@Resource
	private UserService userService;
	
	@Resource
	private RoleMenuMapper roleMenuDao;

	/**
	 * 根据角色id获取菜单列表
	 */
	private List<Menu> getMenusByRole(Integer roleId) {
		// 根据角色id获取菜单id
		RoleMenuExample ure = new RoleMenuExample();
		ure.createCriteria().andRoleIdEqualTo(roleId);
		List<RoleMenu> urList = roleMenuDao.selectByExample(ure);
		// 构造菜单id集合
		List<Integer> mIds = new ArrayList<Integer>();
		for (RoleMenu ur : urList) {
			mIds.add(ur.getMenuId());
		}
		// 根据菜单id查询菜单
		MenuExample e = new MenuExample();
		e.createCriteria().andIdIn(mIds);
		List<Menu> menus = menuDao.selectByExample(e);
		return menus;
	}

	/**
	 * 查询所有顶级菜单
	 */
	@Override
	public List<MenuDto> findAllTopMenus(UserDto userDto) {
		User user = userDao.selectByPrimaryKey(userDto.getId());
		// 当前用户有权限的菜单集合
		Set<Menu> userMenus = new HashSet<Menu>();
		Boolean isAdmin = false;
		List<Role> roles = userService.getRolesByUser(userDto.getId());
		for (Role r : roles) {
			if (r.getName().equals("admin")) {
				isAdmin = true;
				continue;
			}
			userMenus.addAll(this.getMenusByRole(r.getId()));
		}
		List<Menu> pos = new ArrayList<Menu>();
		if (isAdmin) {
			MenuExample me = new MenuExample();
			me.createCriteria().andParentIdIsNull();
			pos = menuDao.selectByExample(me);
			this.setParentAndChildren(pos);
		} else {
			// 添加顶级菜单到pos
			for (Menu m : userMenus) {
				if (m.getParent() == null) {
					pos.add(m);
					m.setChildren(new ArrayList<Menu>());
				}
			}
			// 为pos中的顶级菜单添加子菜单
			for (Menu m : userMenus) {
				if (m.getParent() != null) {
					m.getParent().getChildren().add(m);
				}
			}
		}
		// 构造dto，并设置第一顶级菜单及其第一个子菜单为active
		List<MenuDto> dtos = MenuDto.getDtos(pos, true);
		if (dtos.size() > 0) {
			dtos.get(0).setActive(true);
			if (dtos.get(0).getChildren().size() > 0) {
				dtos.get(0).getChildren().get(0).setActive(true);
			}
		}
		return dtos;
	}

	/**
	 * 获取子菜单的封装
	 */
	private List<Menu> getChildren(Integer parentId) {
		MenuExample example = new MenuExample();
		MenuExample.Criteria c = example.createCriteria();
		c.andParentIdEqualTo(parentId);
		example.setOrderByClause("no");
		List<Menu> pos = menuDao.selectByExample(example);
		return pos;
	}

	/**
	 * 设置父菜单与子菜单的封装
	 */
	private void setParentAndChildren(Menu po) {
		if (po.getParentId() != null) {
			Menu p = menuDao.selectByPrimaryKey(po.getParentId());
			po.setParent(p);
		}
		po.setChildren(getChildren(po.getId()));
	}

	private void setParentAndChildren(List<Menu> pos) {
		for (Menu po : pos) {
			this.setParentAndChildren(po);
		}
	}

	/**
	 * 查询菜单列表信息
	 */
	@Override
	public DataTable<MenuDto> findAllBySearch(Integer start, Integer length, String search, String noDir) {
		PageHelper.startPage(SSMUtil.getPage(start, length), length);
		// 生成查询条件和排序
		MenuExample example = new MenuExample();
		MenuExample.Criteria c = example.createCriteria();
		c.andNameLike("%" + search + "%");
		MenuExample.Criteria cOr = example.or();
		cOr.andNoLike("%" + search + "%");
		example.setOrderByClause("no " + noDir);
		// 返回结果
		List<Menu> pos = menuDao.selectByExample(example);
		// 设置父子菜单
		setParentAndChildren(pos);
		// 计算总数
		Long count = Long.valueOf(menuDao.countByExample(example));
		// 构造返回dto
		DataTable<MenuDto> dt = new DataTable<MenuDto>();
		dt.setData(MenuDto.getDtos(pos, false));
		dt.setRecordsFiltered(count);
		dt.setRecordsTotal(count);
		return dt;
	}

	/**
	 * 创建父菜单
	 */
	@Override
	public void create(MenuDto dto) {
		Menu po = new Menu();
		po.setNo(dto.getNo());
		po.setName(dto.getName());
		po.setIcon(dto.getIcon());
		po.setUrl(dto.getUrl());
		
		menuDao.insert(po);
	}
	
	
	
	/**
	 *创建子菜单
	 */
	@Override
	public void createChild(MenuDto dto) {
		Menu po = new Menu();
		po.setIcon(dto.getIcon());
		po.setName(dto.getName());
		po.setNo(dto.getNo());
		po.setUrl(dto.getUrl());
		
		po.setParentId(dto.getParentId());
		
		menuDao.insert(po);
	}

	/**
	 *通过id查询菜单
	 */
	@Override
	public MenuDto findById(Integer id) {
		Menu po = menuDao.selectByPrimaryKey(id);
		
		return new MenuDto(po, false);
	}
	
	/**
	 * 修改菜单信息
	 */
	@Override
	public void update(MenuDto dto) {
		Menu po = new Menu();
		po.setId(dto.getId());
		po.setName(dto.getName());
		po.setIcon(dto.getIcon());
		po.setNo(dto.getNo());
		
		po.setParentId(dto.getParentId());
		
		menuDao.deleteByPrimaryKey(dto.getId());
		menuDao.insert(po);
	}
	
	/**
	 * 删除菜单
	 */
	@Override
	public void deltte(Integer[] ids) {
		for (Integer id : ids) {
			MenuExample em = new MenuExample();
			em.createCriteria().andIdEqualTo(id);
			
			menuDao.deleteByExample(em);
		}
	}

	
}
