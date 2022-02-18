package com.yanzhen.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.yanzhen.model.DataValue;
import com.yanzhen.model.MeetingInfo;
import com.yanzhen.model.User;
import com.yanzhen.service.MeetingInfoService;
import com.yanzhen.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
public class MeetingController {

    @Autowired
    private MeetingInfoService meetingInfoService;
    /**
     * 支持查询以及高级查询
     */
    @ResponseBody
    @RequestMapping("meeting/queryAll")
    public R queryAll(MeetingInfo meetingInfo,
                      @RequestParam(defaultValue = "1") Integer page,
                      @RequestParam(defaultValue = "15")Integer limit){
        PageInfo<MeetingInfo> pageInfo=meetingInfoService.queryMeetingInfo(page,limit,meetingInfo);
        return R.ok("ok",pageInfo.getTotal(),pageInfo.getList());//获得状态信息，记录数，记录信息
    }

    @ResponseBody
    @RequestMapping("meeting/queryAll2")
    public R queryAll2(MeetingInfo meetingInfo,
                       @RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "15")Integer limit,
                       HttpServletRequest request){
        HttpSession session = request.getSession();
        User u= (User) session.getAttribute("user");
        meetingInfo.setCreateBy(u.getId());
        PageInfo<MeetingInfo> pageInfo=meetingInfoService.queryMeetingInfo(page,limit,meetingInfo);
        return R.ok("ok",pageInfo.getTotal(),pageInfo.getList());
    }


    @ResponseBody
    @RequestMapping("meeting/addInfo")
    public R addInfo(@RequestBody  MeetingInfo info,HttpServletRequest request){
        HttpSession session = request.getSession();
        User u= (User) session.getAttribute("user");
        info.setCreateBy(u.getId());
        info.setCreateTime(new Date());
        //判断是否该会议室预定预定的话，不支持再次预定
        //select * from meeting_info info
        //where info.end_time > '2021-09-02 13:00:00'
        //and info.start_time<'2021-09-02 13:00:00'
        //把事件转
        SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time=sf.format(info.getStartTime());
        String time2=sf.format(info.getEndTime());
        //这里传值一个开始时间即可，结束时间不用传，因后端接口需更改多，暂时不动
        int nums=meetingInfoService.getMeeingInfoByRoomIdAndTime(time,time2,info.getRoomId());
        if(nums>0){
            return R.fail("该时间段会议室已经被预定，请重新预定新的信息....");
        }
        int num= meetingInfoService.insertInfo(info);
        if(num>0){
            return R.ok();
        }
        return R.fail("添加失败");
    }

    @ResponseBody
    @RequestMapping("meeting/updateInfo")
    public R updateInfo(@RequestBody  MeetingInfo info){
        int num= meetingInfoService.updateInfo(info);
        if(num>0){
            return R.ok();
        }
        return R.fail("修改失败");
    }

    /**
     * 用户删除功能 支持批量删除和单个删除
     *  1,2,3,4
     */
    @ResponseBody
    @RequestMapping("meeting/deleteByIds")
    public R deleteUserByIds(String ids){
        //把字符串转成集合对象
        List<String> list= Arrays.asList(ids.split(","));
        int num=0;
        for(String id:list){
            num+= meetingInfoService.deleteInfoById(Integer.parseInt(id));
        }
        if(num>0){
            return R.ok();
        }
        return R.fail("删除失败");
    }







    /**
     * 映射会议主页
     */
    @RequestMapping("/meetingInfo")
    public String meetingIndex(){
        return "meeting/index";
    }




    /**
     * 映射会议添加主页
     */
    @RequestMapping("meeting/add")
    public String add(){
        return "meeting/add";
    }

    /**
     * 映射会议修改主页
     */
    @RequestMapping("meeting/update")
    public String update(Integer id, Model model){
        MeetingInfo info=meetingInfoService.queryInfoById(id);
        model.addAttribute("info",info);
        return "meeting/update";
    }

    /**
     * 关联人员映射
     */
    @RequestMapping("meeting/seting")
    public String setUserList(Integer id,Model model){
        //会议id
        model.addAttribute("id",id);
        return "meeting/set";
    }



    //会议日程实现
    @RequestMapping("meetingList")
    public String meetingList(Model model){
        //查询会议列表信息
        List<MeetingInfo> meetingInfos = meetingInfoService.queryMeetingInfo();
        List dataList=new ArrayList();
        for(MeetingInfo info:meetingInfos){
            DataValue dv=new DataValue();//会议日程中的会议信息：会议主题和会议开始时间
            //会议主题
            dv.setTitle(info.getSubject());
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String format = sdf.format(info.getStartTime());
            dv.setStart(format);
            dataList.add(dv);
        }
        String json = JSON.toJSONString(dataList);//传给前端页面，要转为json格式
        model.addAttribute("info",json);
        return "meetingList/index";//映射会议日程页面
    }


    @RequestMapping("/mymeeting")
    public String mymeeting(){
       return "other/my_meeting";
    }
    @RequestMapping("/meetingLists")
    public String meetingLists(){
        return "other/meeting_list";
    }


    /**
     * 个人会议流水线
     */
    @RequestMapping("meetinfo/queryMeetByUserId")
    public String queryMeetByUserId(HttpServletRequest request, Model model){
        HttpSession session=request.getSession();
        User user= (User) session.getAttribute("user");//获取当前用户
        //根据用户id查询流程
        List list=  meetingInfoService.queryMeetInfoByUserId(user.getId());
        model.addAttribute("info",list);
        return "other/mymeet_info";
    }

}
