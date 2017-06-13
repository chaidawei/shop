package com.lppz.back.db;

import sun.font.FontDesignMetrics;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Random;


public class ImgUtil {
    //向图片添加水印文字
    public  void text(String imgurl, String text, Color color,int size,int pos,String newurl){
        try {
            BufferedImage image= ImageIO.read(new File(imgurl));//读入一个图片到画板中
            Graphics2D g = (Graphics2D) image.getGraphics();//生成一个画笔操作图片
            int w = image.getWidth();//获取图片的宽度
            int h = image.getHeight();//获取图片的高度
            g.setColor(color);//设置字体颜色
            Font f = new Font("宋体",Font.BOLD,size);//设置水印文字的样式和大小(宋体，加粗，25号字体)
            FontDesignMetrics fm = FontDesignMetrics.getMetrics(f);//已知字体的大小确定字体的长度和高度
           g.setFont(f);
            int tw = fm.stringWidth(text);//获取文本的宽度
            int th = fm.getHeight();//获取文本的高度
            //设置文本位置
            int x = 0;int y = 0;
                switch (pos){
                    case 1:
                        //左上角
                        x = 5;y = th+5;break;
                    case 5:
                        //中间
                        x = (w - tw)/2;y = (h - th)/2;break;
                    case 9:
                        //右下角
                        x = w -tw -10;y = h - 10;break;
                    default:
                        //随机
                        Random r = new Random();x = r.nextInt(w - tw -15);y = r.nextInt(h-th -15);
                }
            g.drawString(text,x,y);//写入水印文字
            ImageIO.write(image,"jpeg",new File(newurl));//将添加水印文字的图片以jpeg格式存入新地址newurl
            g.dispose();//释放资源
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    //像图片添加水印图标
    public  void logo(String imgurl,String logourl,int pos,String newurl){
        try {
            BufferedImage image = ImageIO.read(new File(imgurl));//读入一张图片到画板中
            Graphics2D g = (Graphics2D) image.getGraphics();//生成画笔操作图片
            int w = image.getWidth();//获取图片的宽度
            int h = image.getHeight();//获取图片的高度
            BufferedImage logo = ImageIO.read(new File(logourl));//读入一张logo图片
            int lw = logo.getWidth();//获取logo的宽度
            int lh = logo.getHeight();//获取logo的高度
            //设置logo的位置
            int x = 0;
            int y = 0;
            switch (pos){
                case 1://左上角
                    x = 5;y = 5;break;
                case 5://中间
                    x = (w - lw)/2;y = (h - lh)/2;break;
                case 9://右下角
                    x = w -lw-5;y = h -lh-5;break;
                default://随机
                    Random r = new Random();x = r.nextInt(w - lw -10);y = r.nextInt(h - lh -10);
            }
            g.drawImage(logo,x,y,null);
            ImageIO.write(image,"jpeg",new File(newurl));//将添加logo后的图片以jpeg的格式存入newurl
            g.dispose();//释放内存
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


        //实现图片的缩略
    public void thumb(String imgurl,int width,String newurl){
        try {
            BufferedImage image = ImageIO.read(new File(imgurl));//读入一张图片到画板中
            int w = image.getWidth();//获取图片的宽度
            int h = image.getHeight();//获取图片的高度
            int nw = width;//设置缩小后的图片的宽度
            int nh = (int)(nw/1.8);//按照比例设置图片的的高度
            BufferedImage newimage = new BufferedImage(nw,nh,1);//制作一个画板用来存放缩放后的图片
            Graphics2D gn = (Graphics2D) newimage.getGraphics();//生成画笔操作缩略图
            gn.drawImage(image,0,0,nw,nh,0,0,w,h,null);//将原图按照宽高缩略
            ImageIO.write(newimage,"jpeg",new File(newurl));//将缩率后的图片存到newurl中
            gn.dispose();//释放资源
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //实现图片的剪切
    public  void cut(String imurl,int x,int y ,int w ,int h ,String newurl){
        try {
            BufferedImage image = ImageIO.read(new File(imurl));//读入一个图片文件用于剪切
            BufferedImage newimage= new BufferedImage(w,h,BufferedImage.TYPE_INT_RGB);//生成一个画板用于存放剪切后的图片
            Graphics2D g = (Graphics2D)newimage.getGraphics();//生成画笔用于操作剪切图片
            g.drawImage(image,0,0,w,h,x,y,w+x,h+y,null);//将image图片从x,y坐标开始剪切，剪切宽度w，高度h
        ImageIO.write(newimage,"jpeg",new File(newurl));//将剪切好的图片存入文件中
        g.dispose();//释放资源
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
