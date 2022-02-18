package com.yanzhen.service;

import com.github.pagehelper.PageInfo;
import com.yanzhen.model.MeetingInfo;
import com.yanzhen.model.MeetingUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MeetingInfoService {

    PageInfo<MeetingInfo> queryMeetingInfo(int page,int pageSize,MeetingInfo meetingInfo);

    int insertInfo(MeetingInfo meetingInfo);

    int updateInfo(MeetingInfo meetingInfo);

    int  deleteInfoById(Integer id);

    MeetingInfo queryInfoById(Integer id);

    /**
     * 根据用户id 和会议id判断是否有参与了会议
     */
    boolean queryMeeingInfoByMeetIdAndUserId(Integer meetId,
                                          Integer userId);

    /**
     * 用于会议日志查询的接口
     */
    List<MeetingInfo> queryMeetingInfo();

    /**
     * 根据会议室 和会议事件判断当前时间段是否存在会议信息
     * 用来拒绝预约使用
     */
    int getMeeingInfoByRoomIdAndTime(String startTime,
                                     String endTime,
                                     Integer roomId);
    /**
     * 根据用户id查询用户会议列表
     */
    List<MeetingUser> queryMeetInfoByUserId(Integer userId);

}
