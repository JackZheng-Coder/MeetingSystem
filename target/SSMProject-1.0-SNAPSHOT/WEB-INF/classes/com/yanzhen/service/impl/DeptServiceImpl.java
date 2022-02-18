package com.yanzhen.service.impl;

import com.yanzhen.mapper.DeptMapper;
import com.yanzhen.model.Dept;
import com.yanzhen.model.Node;
import com.yanzhen.service.DeptService;
import com.yanzhen.util.TreeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("deptService")
public class DeptServiceImpl implements DeptService {
    @Autowired
    private DeptMapper deptDao;
    @Override
    public List<Dept> queryDeptAll() {
        List<Dept> list=deptDao.queryDeptAll();
        return list;
    }

    @Override
    public int addInfo(Dept dept) {
        return deptDao.insert(dept);
    }

    @Override
    public Dept queryDeptById(Integer id) {
        return deptDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateDeptInfo(Dept dept) {
        return deptDao.updateByPrimaryKey(dept);
    }

    @Override
    public int deleteById(Integer id) {
        return deptDao.deleteByPrimaryKey(id);
    }

    @Override
    public List<Dept> queryListByFid(Integer fjd) {
        return deptDao.queryListByFid(fjd);
    }

    @Override
    public List<Node> queryDeptTree() {
        //获取列表
        List<Node> list=deptDao.queryDeptTree();
        TreeUtil util=new TreeUtil(); //构架树结构树形json工具类
        List<Node> treeList=util.build(list);
        return treeList;
    }
}
