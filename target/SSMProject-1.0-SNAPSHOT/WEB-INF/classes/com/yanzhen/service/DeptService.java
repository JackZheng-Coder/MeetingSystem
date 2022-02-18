package com.yanzhen.service;

import com.yanzhen.model.Dept;
import com.yanzhen.model.Node;

import java.util.List;

public interface DeptService {
    List<Dept> queryDeptAll();

    /**
     * 添加功能
     */
    int addInfo(Dept dept);

    /**
     * 根据id查询部门信息
     */
    Dept queryDeptById(Integer id);

    /**
     * 修改功能实现
     */
    int updateDeptInfo(Dept dept);

    /**
     * 根据id删除信息
     */
    int deleteById(Integer id);

    /**
     * 根据父节点查询下面的部门列表
     * @param fjd
     * @return
     */
    List <Dept> queryListByFid(Integer fjd);

    /**
     * 查询部门树结构
     */
    List<Node> queryDeptTree();

}
