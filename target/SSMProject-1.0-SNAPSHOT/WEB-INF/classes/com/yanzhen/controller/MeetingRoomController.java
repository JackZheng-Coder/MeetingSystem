package com.yanzhen.controller;

import com.github.pagehelper.PageInfo;
import com.yanzhen.model.MeetingRoom;
import com.yanzhen.service.MeetRoomService;
import com.yanzhen.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Controller
public class MeetingRoomController {

    @Autowired
    private MeetRoomService meetRoomService;

    /**
     * 查询提供的接口
     */
    @ResponseBody
    @RequestMapping("meetingRoom/queryMeetingRoomAll")
    public R queryMeetingRoomAll(MeetingRoom meetingRoom,
                                 @RequestParam(defaultValue = "1") Integer page,
                                 @RequestParam(defaultValue = "15") Integer limit){
        PageInfo<MeetingRoom> pageInfo=meetRoomService.findMeetingRoomAll(page,limit,meetingRoom);
        return R.ok("ok",pageInfo.getTotal(),pageInfo.getList());//状态信息，记录数，记录信息
    }

    @RequestMapping("meetroom/roomList")
    @ResponseBody
    public List queryRoomList(){
        PageInfo<MeetingRoom> pageInfo=meetRoomService.findMeetingRoomAll(1,100,null);
        return pageInfo.getList();
    }


    /**
     * 添加实现接口
     */
    @ResponseBody
    @RequestMapping("meetingRoom/addInfo")
    public R addInfo(@RequestBody  MeetingRoom meetingRoom){
      int num= meetRoomService.addInfo(meetingRoom);
      if(num>0){
          return R.ok();
      }
      return R.fail("添加失败");
    }

    /**
     * 修改实现接口
     */
    @ResponseBody
    @RequestMapping("meetingRoom/updateInfo")
    public R updateInfo(@RequestBody  MeetingRoom meetingRoom){
        int num= meetRoomService.updateInfo(meetingRoom);
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
    @RequestMapping("meetingRoom/deleteByIds")
    public R deleteUserByIds(String ids){
        //把字符串转成集合对象
        List<String> list= Arrays.asList(ids.split(","));
        int num=0;
        for(String id:list){
            num+= meetRoomService.deleteInfoByID(Integer.parseInt(id));
        }
        if(num>0){
            return R.ok();
        }
        return R.fail("删除失败");
    }


    /**
     * 上传图片
     */
    @ResponseBody
    @RequestMapping("fileUpload")
    public R fileUpload(@RequestParam(value = "file") MultipartFile file){
        if(file.isEmpty()){
            System.out.println("图片不存在");
        }
        //获取文件名称
        String fileName= file.getOriginalFilename();
        //获取文件后缀
        String suffixName=fileName.substring(fileName.lastIndexOf("."));
        //随机生成一个文件名
        fileName= UUID.randomUUID()+suffixName;
        //设置上传文件的路径
        String filePath="E://images//";
        //上传
        File dest=new File(filePath,fileName);
        //判断文件路径是否存在，如果不存在 创建
        if(!dest.getParentFile().exists()){
            dest.getParentFile().mkdirs();
        }
        try {
            file.transferTo(dest);//使用transferTo(dest)方法将上传文件写到服务器上指定的文件
        }catch (Exception e){
            System.out.println("上传出错");
        }

        //设置最终的文件名称信息返回前端
        String fileName2="/images/"+fileName;
        return R.ok(fileName2,null);
    }


    /**
     * 页面的映射层
     */
    @RequestMapping("/meetingRoom")
    public String index(){
     return "meetingRoom/index";
   }

    /**
     * 页面添加
     */
    @RequestMapping("meetingRoom/add")
    public String add(){
        return "meetingRoom/add";
    }

    /**
     * 页面的修改
     */
    @RequestMapping("meetingRoom/update")
    public String update(Integer id, Model model){
        //根据id查询当前的记录信息
        MeetingRoom room= meetRoomService.queryMeetingRoomById(id);
        model.addAttribute("room",room);
        return "meetingRoom/update";
    }


    /**
     * 会议室次数统计
     */
    @RequestMapping("meetingRoomCounts")
    public String meetingRoomCounts(Model model){

       //查询会议室列表
        List<MeetingRoom> meetingRooms = meetRoomService.queryMeetingRoomList();
        List roomList=new ArrayList();
        List dataList=new ArrayList();
        for(MeetingRoom room:meetingRooms){
            String name=room.getName();//会议室名字
            //根据会议室id查询使用次数
            int count=meetRoomService.queryMeetingRoomCounts(room.getId());
            dataList.add(count);
            roomList.add("'"+name+"'");
        }
         model.addAttribute("name",roomList);
         model.addAttribute("counts",dataList);
         return "meetingRoom/getRoomCounts";//映射前端页面
    }



}
