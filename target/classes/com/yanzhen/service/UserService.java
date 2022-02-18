package com.yanzhen.service;

import com.github.pagehelper.PageInfo;
import com.yanzhen.model.User;

import java.util.List;

public interface UserService {
    /**
     * 根据条件高级查询用户列表
     * @param page  第几页
     * @param pageSize  每页显示记录时
     * @param user  参数对象
     * @return
     */
    PageInfo<User> queryUserList(int page,int pageSize,User user);

    /**
     * 新增方法
     */
    int insertUserInfo(User user);

    /**
     * 修改
     */
    int updateUserInfo(User user);

    /**
     * 根据id删除记录信息
     */
    int deleteUserInfoByUserId(Integer id);

    /**
     * 根据id查询用户对象
     */
    User queryUserByID(Integer id);

    /**
     * 根据用户姓名查询用户对象
     */
    User queryUserInfoByUserName(String username);


    User queryUserInfoByNameAndPwdAndType(User user);
}
