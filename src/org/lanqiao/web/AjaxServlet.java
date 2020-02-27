package org.lanqiao.web;

import com.alibaba.fastjson.JSON;
import org.lanqiao.domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ajax.do")
public class AjaxServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charSet=utf-8");
        String id = req.getParameter("id");
        String username = req.getParameter("username");
        System.out.println("接收到ajax请求"+ id + "-----" + username);
        //服务器响应Ajax方式
        PrintWriter out = resp.getWriter();
        User user = new User("张三1",12);
        User user2 = new User("张三2",13);
        User user3 = new User("张三3",14);
        List<User> users = new ArrayList<>();
        users.add(user);
        users.add(user2);
        users.add(user3);
        //将JavaBean转换成了json字符串
        //String userStr = JSON.toJSONString(user);
        String userListStr = JSON.toJSONString(users);


       // System.out.println(userStr);
        System.out.println(userListStr);
       // out.print(userStr);
        out.print(userListStr);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
