package com.yanzhen.mapper;

import com.yanzhen.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int insert(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int insertSelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    User selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int updateByPrimaryKeySelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int updateByPrimaryKey(User record);

    /**
     * 查询用户信息  支持高级查询
     */
    List<User> queryUserList(User user);

    /**
     * 根据用户名查询用户对象
     */
    User queryUserInfoByUserName(@Param("username") String username);

    /**
     * 根据用户名密码 以及用户类型判断用户是否存在
     */
    User queryUserByUserNameAndPwdAndType(User user);

}