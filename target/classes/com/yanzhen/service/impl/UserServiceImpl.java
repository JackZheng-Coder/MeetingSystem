package com.yanzhen.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yanzhen.mapper.UserMapper;
import com.yanzhen.model.User;
import com.yanzhen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userDao;

    /**
     * 根据条件高级查询用户列表
     * @param page  第几页
     * @param pageSize  每页显示记录数
     * @param user  参数对象
     * @return
     */
    @Override
    public PageInfo<User> queryUserList(int page, int pageSize, User user) {
        PageHelper.startPage(page,pageSize);
        List<User> list=userDao.queryUserList(user);
        PageInfo <User> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public int insertUserInfo(User user) {
        return userDao.insert(user);
    }

    @Override
    public int updateUserInfo(User user) {
        return userDao.updateByPrimaryKeySelective(user);
    }

    @Override
    public int deleteUserInfoByUserId(Integer id) {
        return userDao.deleteByPrimaryKey(id);
    }

    @Override
    public User queryUserByID(Integer id) {
        return userDao.selectByPrimaryKey(id);
    }

    @Override
    public User queryUserInfoByUserName(String username) {
        return userDao.queryUserInfoByUserName(username);
    }

    @Override
    public User queryUserInfoByNameAndPwdAndType(User user) {
        return userDao.queryUserByUserNameAndPwdAndType(user);
    }
}
