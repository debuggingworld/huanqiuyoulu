package com.hq.db;

/**
 * @author zth
 * @Date 2019-04-20 15:58
 */
public class Test {
    public static void main(String[] args)  {


    }
@org.junit.Test
    public void test(){
        Class clazz = this.getClass();
        String allname = clazz.getName();
    int lastdot=allname.lastIndexOf(".");
    String re=allname.substring(lastdot+1,lastdot+2).toLowerCase()+allname.substring(lastdot+2);
    System.out.println(re);
    }
}
