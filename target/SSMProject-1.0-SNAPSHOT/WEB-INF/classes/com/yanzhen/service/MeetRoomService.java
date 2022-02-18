package com.yanzhen.service;

import com.github.pagehelper.PageInfo;
import com.yanzhen.model.MeetingRoom;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MeetRoomService {

    /**
     * 高级查询
     */
    PageInfo<MeetingRoom> findMeetingRoomAll(int page,int pageSize,MeetingRoom meetingRoom);

    /**
     * 新增
     */
    int addInfo(MeetingRoom meetingRoom);

    /**
     * 修改
     */
    int updateInfo(MeetingRoom meetingRoom);

    /**
     * 删除
     */
    int deleteInfoByID(Integer id);

    /**
     * 根据id查询会议室信息
     */
    MeetingRoom queryMeetingRoomById(Integer id);


    /**
     * 根据会议室id查询该会议室 会议使用的次数
     */
    int queryMeetingRoomCounts( Integer roomId);

    /**
     * 查询会议室列表
     */
    List<MeetingRoom> queryMeetingRoomList();

}
