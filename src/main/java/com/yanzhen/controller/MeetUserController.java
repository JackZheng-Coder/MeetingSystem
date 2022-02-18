package com.yanzhen.controller;

import com.yanzhen.model.MeetingUser;
import com.yanzhen.service.MeetingUserService;
import com.yanzhen.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class MeetUserController {

    @Autowired
    private MeetingUserService meetingUserService;

    @ResponseBody
    @RequestMapping("meetUser/setingUserIds")
    @Transactional(rollbackFor = {Exception.class})
    public R setingUserIds(String ids, Integer meetId){
        /*
         * 1、获取会议id参会人员 并删除
         * 2、获取ids 用户id列表 重新添加到关联人员表中
         */
        meetingUserService.deleteMeetUserByMeetId(meetId);
        List<String> list= Arrays.asList(ids.split(","));
        List <MeetingUser> li=new ArrayList();
        for(String uid:list){
            MeetingUser meetingUser=new MeetingUser();
            meetingUser.setUserId(Integer.parseInt(uid));
            meetingUser.setMeetingId(meetId);
            li.add(meetingUser);
        }
       //批量添加
        meetingUserService.insertPathInfo(li);
        return R.ok();
    }
}
