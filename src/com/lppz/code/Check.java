package com.lppz.code;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.*;

/**
 * Created by webrx on 2017/5/4.
 * 验证码
 */
@WebServlet("/code")
public class Check extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int w = 80;
        int h = 38;
        int len = 4;
        Random r = new Random();
        BufferedImage image = new BufferedImage(w, h, 1);
        Graphics2D g = image.createGraphics();
        g.setBackground(new Color(240, 240, 240, 255));
        g.fillRect(0, 0, w, h);
        //添加干扰线
        for (int i = 0; i <= 10; i++) {
            g.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255), r.nextInt(180) + 75));
            int x = r.nextInt(w);
            int y = r.nextInt(h);
            g.setStroke(new BasicStroke(r.nextInt(3)));
            g.drawLine(r.nextInt(w), r.nextInt(h), r.nextInt(w), r.nextInt(h));
        }

        //添加验证码文字
        String str = "abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ0123456789";
        String cs = "";
        g.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255), r.nextInt(75) + 180));
        for (int n = 0; n < 4; n++) {
            int b = r.nextInt(str.length());
            g.setFont(new Font("宋体", Font.BOLD, 25));
            String s = str.substring(b, b + 1);
            cs += s;
            int x = n * 20 + 5;
            int y = r.nextInt(5) + 20;
            g.drawString(s, x, y);
        }
        req.getSession().setAttribute("code",cs);
        ImageIO.write(image, "png", resp.getOutputStream());
    }
}
