package com.yanzhen.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yanzhen.mapper.MeetingInfoMapper;
import com.yanzhen.mapper.MeetingRoomMapper;
import com.yanzhen.model.MeetingRoom;
import com.yanzhen.service.MeetRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("meetRoomService")
public class MeetRoomServiceImpl implements MeetRoomService {

    @Autowired
    private MeetingRoomMapper meetingRoomDao;

    @Override
    public PageInfo<MeetingRoom> findMeetingRoomAll(int page,int pageSize,MeetingRoom meetingRoom) {
        PageHelper.startPage(page,pageSize);
        List<MeetingRoom> list= meetingRoomDao.queryMeetingRoomAll(meetingRoom);
        PageInfo<MeetingRoom> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public int addInfo(MeetingRoom meetingRoom) {
        return meetingRoomDao.insert(meetingRoom);
    }

    @Override
    public int updateInfo(MeetingRoom meetingRoom) {
        return meetingRoomDao.updateByPrimaryKey(meetingRoom);
    }

    @Override
    public int deleteInfoByID(Integer id) {
        return meetingRoomDao.deleteByPrimaryKey(id);
    }

    @Override
    public MeetingRoom queryMeetingRoomById(Integer id) {
        return meetingRoomDao.selectByPrimaryKey(id);
    }

    @Override
    public int queryMeetingRoomCounts(Integer roomId) {
        return meetingRoomDao.queryMeetingRoomCounts(roomId);
    }

    @Override
    public List<MeetingRoom> queryMeetingRoomList() {
        return meetingRoomDao.queryMeetingRoomAll(null);
    }
}
