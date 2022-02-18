package com.yanzhen.service.impl;

import com.yanzhen.mapper.MeetingUserMapper;
import com.yanzhen.model.MeetingUser;
import com.yanzhen.service.MeetingUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("meetingUserService")
public class MeetingUserServiceImpl implements MeetingUserService {
    @Autowired
    private MeetingUserMapper meetingUserDao;
    @Override
    public int deleteMeetUserByMeetId(Integer meetId) {
        return meetingUserDao.deleteMeetUserByMeetId(meetId);
    }

    @Override
    public int insertPathInfo(List<MeetingUser> meetingUserList) {
        return meetingUserDao.insertPathInfo(meetingUserList);
    }
}
