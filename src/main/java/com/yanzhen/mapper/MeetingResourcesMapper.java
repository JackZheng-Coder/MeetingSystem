package com.yanzhen.mapper;

import com.yanzhen.model.MeetingResources;

public interface MeetingResourcesMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_resources
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_resources
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int insert(MeetingResources record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_resources
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int insertSelective(MeetingResources record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_resources
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    MeetingResources selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_resources
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int updateByPrimaryKeySelective(MeetingResources record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_resources
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int updateByPrimaryKey(MeetingResources record);
}