package com.bitnei.cloud.report.util;

/**
 * 断言
 * @author chenyl or 13718602502@163.com
 * @see org.springframework.util.Assert
 */
public class Assert {

    public static void isTrue(String var1,String var2,String message){
        if(var1 == null){
            throw new NeedUpdateException(message);
        }
        if(!var1.equals(var2)){
            throw new RuntimeException(message);
        }
    }

    public static void isTrue(boolean expression,String message){
        if(expression){
            throw new RuntimeException(message);
        }
    }

    public static void isTrue(String var1,String var2,String message,int i){
        if(var1 == null){
            throw new NeedUpdateException(message);
        }
        if(i==1){
            if(!var1.equals(var2)){
                throw new ValidateException(message);
            }
        }else{
            if(!var1.equals(var2)){
                throw new RuntimeException(message);
            }
        }
    }
    public static void isTrue(boolean expression,String message,int i){
        if(i==1){
            if(expression){
                throw new ValidateException(message);
            }
        }else{
            if(expression){
                throw new RuntimeException(message);
            }
        }

    }
}
