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
import com.qfedu.demo.ssh.dto.UserDto;
import com.qfedu.demo.ssh.mapper.DictionaryMapper;
import com.qfedu.demo.ssh.mapper.RoleMapper;
import com.qfedu.demo.ssh.mapper.UserMapper;
import com.qfedu.demo.ssh.mapper.UserRoleMapper;
import com.qfedu.demo.ssh.po.Dictionary;
import com.qfedu.demo.ssh.po.DictionaryExample;
import com.qfedu.demo.ssh.po.Role;
import com.qfedu.demo.ssh.po.RoleExample;
import com.qfedu.demo.ssh.po.User;
import com.qfedu.demo.ssh.po.UserExample;
import com.qfedu.demo.ssh.po.UserRole;
import com.qfedu.demo.ssh.po.UserRoleExample;
import com.qfedu.demo.ssh.service.RoleService;
import com.qfedu.demo.ssh.service.UserService;
import com.qfedu.demo.ssh.util.SSMUtil;
import com.qfedu.demo.ssh.vo.DataTable;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	private final static Logger LOG = LogManager.getLogger(UserServiceImpl.class);

	@Resource // @Autowired
	private UserMapper userDao;

	/**
	 * 登陆验证
	 */
	@Override
	public UserDto authenticate(String username, String password) {
		UserExample ue = new UserExample();
		ue.createCriteria().andLoginnameEqualTo(username);
		List<User> users = userDao.selectByExample(ue);
		if (users.size() == 0) {
			throw new RuntimeException("用户名或者密码不正确！");
		}
		User u = users.get(0);
		String md5 = SSMUtil.getMD5(u.getId().toString(), password);
		if (!u.getPassword().equals(md5)) {
			throw new RuntimeException("用户名或者密码不正确！");
		}
		return new UserDto(u);
	}

	/**
	 * 查询所有用户
	 */
	@Override
	public List<UserDto> findAll() {
		// List<User> pos = userDao.findAll ();
		return UserDto.getDtos(null);
	}

	/**
	 *通过id查询用户
	 */
	@Override
	public UserDto findById(Integer id) {
		User u = userDao.selectByPrimaryKey(id);
		return new UserDto(u);
	}

	/**
	 * 修改用户
	 */
	@Override
	public void update(UserDto u) {
		// 修改用户
		User po = userDao.selectByPrimaryKey(u.getId());
		po.setLoginname(u.getLoginName());
		po.setName(u.getName());
		po.setGender(u.getGender());
		userDao.updateByPrimaryKey(po);

		// 删除关系数据
		UserRoleExample ure = new UserRoleExample();
		ure.createCriteria().andUserIdEqualTo(u.getId());
		userRoleDao.deleteByExample(ure);
		// 插入关系数据
		for (RoleDto r : u.getRoles()) {
			UserRole ur = new UserRole();
			ur.setRoleId(r.getId());
			ur.setUserId(po.getId());
			this.userRoleDao.insert(ur);
		}
	}

	/**
	 * 创建用户
	 */
	@Override
	public void create(UserDto u, Integer[] roleIds) {
		// 生成po
		User po = new User();
		po.setLoginname(u.getLoginName());
		po.setName(u.getName());
		po.setPassword(u.getPassword());
		po.setGender(u.getGender());
		po.setCreatetime(u.getCreateTime());
		// 插入po
		userDao.insert(po);
		// 插入关系数据，要求po的id回写
		for (Integer roleId : roleIds) {
			UserRole ur = new UserRole();
			ur.setRoleId(roleId);
			ur.setUserId(po.getId());
			this.userRoleDao.insert(ur);
		}

		// 修改密码为md5
		String md5 = SSMUtil.getMD5(po.getId().toString(), po.getPassword());
		po.setPassword(md5);
		userDao.updateByPrimaryKey(po);
	}

	/**
	 * 删除用户
	 */
	@Override
	public void delete(Integer[] id, UserDto u) {
		for (Integer i : id) {
			// 当前用户不能删
			if (i.equals(u.getId())) {
				throw new RuntimeException("当前用户不允许删除！");
			}
			// 删除关系数据
			UserRoleExample ure = new UserRoleExample();
			ure.createCriteria().andUserIdEqualTo(i);
			userRoleDao.deleteByExample(ure);
			// 删除用户
			userDao.deleteByPrimaryKey(i);
		}
	}

	@Resource
	private DictionaryMapper dictionaryDao;

	/**
	 * 查询角色列表信息
	 */
	@Override
	public DataTable findAllBySearch(Integer start, Integer length, String search, String loginDir) {
		DataTable data = new DataTable();
		// 分页设置
		PageHelper.startPage(SSMUtil.getPage(start, length), length);
		// 生成查询条件和排序
		UserExample example = new UserExample();
		UserExample.Criteria c = example.createCriteria();
		c.andNameLike("%" + search + "%");
		UserExample.Criteria cOr = example.or();
		cOr.andLoginnameLike("%" + search + "%");
		example.setOrderByClause("loginName " + loginDir);
		// 返回结果
		List<User> pos = userDao.selectByExample(example);
		// 设置用户关联的角色
		for (User po : pos) {
			po.setRoles(this.getRolesByUser(po.getId()));
		}
		// 查询总数
		Long count = Long.valueOf(userDao.countByExample(example));
		List<UserDto> dtos = UserDto.getDtos(pos);
		for (UserDto u : dtos) {
			DictionaryExample de = new DictionaryExample();
			if (u.getGender() != null) {
				de.createCriteria().andTypeEqualTo("gender").andValueEqualTo(u.getGender());
				List<Dictionary> dics = dictionaryDao.selectByExample(de);
				if (dics.size() > 0) {
					u.setGenderName(dics.get(0).getName());
				}
			}
		}
		data.setData(dtos);
		data.setRecordsFiltered(count);
		data.setRecordsTotal(count);
		return data;
	}

	@Resource
	private RoleService roleService;

	/**
	 * 获取用户选中的角色
	 */
	@Override
	public List<RoleDto> findAllRolesWithSelected(Integer id) {
		// 获取用户
		User u = userDao.selectByPrimaryKey(id);
		// 设置用户关联的角色
		u.setRoles(this.getRolesByUser(u.getId()));
		// 获取所有角色
		List<RoleDto> roles = roleService.findAll();
		// 当前用户已有的角色设置selected
		for (RoleDto rDto : roles) {
			for (Role r : u.getRoles()) {
				if (rDto.getId().equals(r.getId())) {
					rDto.setSelected(true);
				}
			}
		}
		return roles;
	}

	@Resource
	private RoleMapper roleDao;

	@Resource
	private UserRoleMapper userRoleDao;

	/**
	 *  获取用户选中的角色
	 */
	@Override
	public List<Role> getRolesByUser(Integer userId) {
		// 根据用户id查询角色id集合
		UserRoleExample ure = new UserRoleExample();
		ure.createCriteria().andUserIdEqualTo(userId);
		List<UserRole> urList = userRoleDao.selectByExample(ure);
		// 构造角色id集合
		List<Integer> rIds = new ArrayList<Integer>();
		for (UserRole ur : urList) {
			rIds.add(ur.getRoleId());
		}
		// 通过角色id集合查询角色
		RoleExample e = new RoleExample();
		e.createCriteria().andIdIn(rIds);
		List<Role> roles = roleDao.selectByExample(e);
		return roles;
	}
}
