package com.yanzhen.mapper;

import com.yanzhen.model.MeetingInfo;
import com.yanzhen.model.MeetingUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("meetingInfoDao")
public interface MeetingInfoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_info
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_info
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int insert(MeetingInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_info
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int insertSelective(MeetingInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_info
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    MeetingInfo selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_info
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int updateByPrimaryKeySelective(MeetingInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table meeting_info
     *
     * @mbggenerated Tue Aug 24 21:59:52 CST 2021
     */
    int updateByPrimaryKey(MeetingInfo record);


    /**
     * 查询会议记录信息，支持高级查询
     */
    List<MeetingInfo> queryMeetingInfoAll(MeetingInfo meetingInfo);


    /**
     * 根据用户id 和会议id判断是否有参与了会议
     */
    int queryMeeingInfoByMeetIdAndUserId(@Param("meetId") Integer meetId,
                                         @Param("userId") Integer userId);


    /**
     * 根据会议室 和会议事件判断当前时间段是否存在会议信息
     * 用来拒绝预约使用
     */
    int getMeeingInfoByRoomIdAndTime(@Param("startTime") String startTime,
                                     @Param("endTime") String endTime,
                                     @Param("roomId") Integer roomId);

    //根据用户查询会议列表
    List<MeetingUser> queryMeetInfoByUserId(@Param("userId") Integer userId);


}