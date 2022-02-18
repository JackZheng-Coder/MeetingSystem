package com.yanzhen.controller;

import com.yanzhen.model.Dept;
import com.yanzhen.model.Node;
import com.yanzhen.service.DeptService;
import com.yanzhen.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {


    @Autowired
    private DeptService deptService;

    /**
     * 查询所有的部门列表信息
     *
     * @return
     */
    @RequestMapping("dept/deptIndex")
    @ResponseBody
    public R queryDeptIndex() {
        //查询所有的记录信息
        List<Dept> list = deptService.queryDeptAll();
        return R.ok("成功", list.size(), list);
    }

    /**
     * 添加部门功能
     */
    @ResponseBody
    @RequestMapping("dept/addInfo")
    public R addInfo(@RequestBody Dept dept) {
        int num = deptService.addInfo(dept);
        if (num > 0) {
            return R.ok();
        }
        return R.fail("添加失败");
    }

    @ResponseBody
    @RequestMapping("dept/updateInfo")
    public R updateInfo(@RequestBody Dept dept) {
        int num = deptService.updateDeptInfo(dept);
        if (num > 0) {
            return R.ok();
        }
        return R.fail("修改失败");
    }

    /**
     * 根据id删除 节点信息
     * @return
     */
    @ResponseBody
    @RequestMapping("dept/deleteInfo")
    public R deleteInfoById(Integer id){
         //根据id获取当前对象信息
         Dept dept=deptService.queryDeptById(id);
         if(dept.getType()==1){//如果是部门
           //查询以id为父节点的所有的记录信息
            List<Dept> list=deptService.queryListByFid(id);
            for(Dept zid:list){
                deptService.deleteById(zid.getId());
            }
             deptService.deleteById(id);
         }else{//如果子部门
             deptService.deleteById(id);
         }
         return R.ok();
    }


    /**
     * 返回树结构信息
     * @return
     */
    @ResponseBody
    @RequestMapping("queryDeptTree")
    public List queryDeptTree(){
        List<Node> list=deptService.queryDeptTree();
        return list;
    }

    //页面映射
    @RequestMapping("dept")
    public String deptIndex() {
        //web-inf/page/dept/index.jsp
        return "dept/indexs";
    }
    //页面映射
    @RequestMapping("dept/add")
    public String deptAdd(Integer id, String fname, Integer type, Model model) {
        if (id == null) {
            id = 1;
        }
        model.addAttribute("fid", id);//获得所属部门或公司的编号
        model.addAttribute("fname", fname);//获得所属部门或公司的名字
        model.addAttribute("type", type + 1);//获得所属部门或公司的层次(是部门还是子部门)
        //web-inf/page/dept/index.jsp
        return "dept/add";
    }

    /**
     * 修改相关接口映射
     * 映射处理
     * @return
     */
    @RequestMapping("dept/update")
    public String deptUpdate(Integer id,Model model) {
        //web-inf/page/dept/update.jsp
        //通过id获取当前记录信息 然后放置到model中
        Dept dept=deptService.queryDeptById(id);
        model.addAttribute("dept",dept);
        return "dept/update";
    }


}
