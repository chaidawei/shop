package com.lppz.back.servlet;

import com.lppz.back.db.MyUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(urlPatterns = {"/updatelunbo.action","/updatabigcate.action","/updatecate.action","/updatemember.action"})
public class Update extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        String action = req.getParameter("action");
        MyUtil mu = new MyUtil();
        PrintWriter out =  resp.getWriter();
        if("updatelunbo".equals(action)) {
            String id1 = req.getParameter("id");
            String s = req.getParameter("select");
            if(!"".equals(id1)) {
                if (mu.count("lunbo", "where id=" + id1) > 0) {
                    if (mu.update("update lunbo set statu = ? where id = ?", new Object[]{s, id1}) > 0) {
                        out.print("修改成功,是否继续修改？");
                    }
                } else {
                    out.print("此编号不存在，是否继续修改？");
                }
            }else {
                out.print("编号不能为空");
            }

        }
        if("updatebigcate".equals(action)){
            String n = req.getParameter("change");
            String id1 =req.getParameter("id");
            if("".equals(n)){
                out.print("名字不能为空，是否返回查看界面？");
            }else {
                int i = mu.update("update bigcate set bname = ? where id = ?",new Object[]{n,id1});
                if(i>0){
                    out.print("修改成功，是否返回查看界面？");
                }else {
                    out.print("修改失败，是否返回查看界面？");
                }
            }
        }

        if("cate".equals(action)){
            String ci = req.getParameter("cid");//小分类编号
            String bi = req.getParameter("bi");//修改后大分类的编号
            String cn = req.getParameter("cn");//修改后小分类的名称
         int i = mu.update("update cate set cname = ? ,b_id = ? where id = ?",new Object[]{cn,bi,ci});
        if(i>0){
            out.print("修改成功，是否返回？");
        }else {
            out.print("修改失败，是否返回？");
        }
        }

        if("member".equals(action)){
            String id = req.getParameter("id");//用户ID
            String rn =req.getParameter("rn");//用户真实姓名
            String un = req.getParameter("una");//用户昵称
            String birthday = req.getParameter("birth");//用户出生日期
            String gender = req.getParameter("gender");//用户性别
            String statu=req.getParameter("statu");//用户账号状态

            int i = mu.update("update user_info set uname=?,realname=?,birthday=?,gender=?,statu=? where id=?",new Object[]{un,rn,birthday,gender,statu,id});
            if(i>0){
                out.print("修改成功，是否继续修改？");
            }else {
                out.print("修改失败，是否继续修改？");
            }


        }



        out.flush();
        out.close();
    }
}
