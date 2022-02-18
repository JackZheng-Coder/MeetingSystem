package com.yanzhen.service;

import com.yanzhen.model.MeetingUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MeetingUserService {

    /**
     * 根据会议id删除参会人员
     */
    int deleteMeetUserByMeetId( Integer meetId);

    /**
     * 批量添加参会人员
     */
    int insertPathInfo(List<MeetingUser> meetingUserList) ;
}

