package com.yanzhen.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yanzhen.mapper.MeetingInfoMapper;
import com.yanzhen.model.MeetingInfo;
import com.yanzhen.model.MeetingUser;
import com.yanzhen.service.MeetingInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("meetingInfoService")
public class MeetingInfoServiceImpl  implements MeetingInfoService {
    @Autowired
    private MeetingInfoMapper meetingInfoDao;
    @Override
    public PageInfo<MeetingInfo> queryMeetingInfo(int page, int pageSize, MeetingInfo meetingInfo) {
        PageHelper.startPage(page,pageSize);
        List<MeetingInfo> list=meetingInfoDao.queryMeetingInfoAll(meetingInfo);
        PageInfo<MeetingInfo> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public int insertInfo(MeetingInfo meetingInfo) {
        return meetingInfoDao.insert(meetingInfo);
    }

    @Override
    public int updateInfo(MeetingInfo meetingInfo) {
        return meetingInfoDao.updateByPrimaryKey(meetingInfo);
    }

    @Override
    public int deleteInfoById(Integer id) {
        return meetingInfoDao.deleteByPrimaryKey(id);
    }

    @Override
    public MeetingInfo queryInfoById(Integer id) {
        return meetingInfoDao.selectByPrimaryKey(id);
    }

    @Override
    public boolean queryMeeingInfoByMeetIdAndUserId(Integer meetId, Integer userId) {
        int num=meetingInfoDao.queryMeeingInfoByMeetIdAndUserId(meetId,userId);
        if(num>0){
            return true;
        }
        return false;
    }

    @Override
    public List<MeetingInfo> queryMeetingInfo() {
        return meetingInfoDao.queryMeetingInfoAll(null);
    }

    @Override
    public int getMeeingInfoByRoomIdAndTime(String startTime,String endTime, Integer roomId) {
        return meetingInfoDao.getMeeingInfoByRoomIdAndTime(startTime,endTime,roomId);
    }


    @Override
    public List<MeetingUser> queryMeetInfoByUserId(Integer userId) {
        return meetingInfoDao.queryMeetInfoByUserId(userId);
    }
}
