package com.yanzhen.test;

import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @ClassName:
 * @Description:
 * @author:
 * @date:
 * @Version:
 * @Copyright:
 */

public class test {
    @Test
    public void jdbcall() throws ClassNotFoundException, SQLException {

        Class.forName("com.mysql.cj.jdbc.Driver");//加载驱动类
        String url="jdbc:mysql://localhost:3306/roomsystem?useUnicode=true&amp&characterEncoding=utf-8&serverTimezone=UTC";
        String username="root";
        String password="123456";
        Connection conn= DriverManager.getConnection(url,username,password);//用参数得到连接对象
        System.out.println("连接成功！");
        System.out.println(conn);
    }

}
