package com.bitnei.cloud.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


/**
 * 日期处理单元
 */
public class DateUtil
{
    public static final int SECOND = 1000;
    public static final int MINUTE = SECOND * 60;
    public static final int HOUR = MINUTE * 60;
    public static final long DAY = HOUR * 24;
    public static final long WEEK = DAY * 7;
    public static final long YEAR = DAY * 356;

    public static final String DEFAULT_VALID_TIME = "2099-12:30 00:00:00";

    final static public String FULL_ST_FORMAT = "yyyy-MM-dd HH:mm:ss";
    final static public String FULL_ST_FORMAT_S = "yyyy-MM-dd HH:mm:ss.SSSS";
    final static public String FULL_J_FORMAT = "yyyy/MM/dd HH:mm:ss";
    final static public String CURRENCY_ST_FORMAT = "yyyy-MM-dd HH:mm";
    final static public String CURRENCY_J_FORMAT = "yyyy/MM/dd HH:mm";
    final static public String DATA_FORMAT = "yyyyMMddHHmmss";
    final static public String ST_FORMAT = "yyyy-MM-dd HH:mm";
    final static public String ST_CN_FORMAT = "yyyy年MM月dd日 HH:mm";
    final static public String ST_CN_FORMATS = "yyyy年MM月dd日";
    final static public String CN_FORMAT = "yy年MM月dd日HH:mm";
    final static public String DAY_FORMAT = "yyyy-MM-dd";
    final static public String SHORT_DATE_FORMAT = "yy-MM-dd";
    final static public String YEAR_FORMAT = "yyyy";
    final static public String DATA_FORMAT_DAY = "yyyyMMdd";



    public static String getDate(long second){
        SimpleDateFormat sdf = new SimpleDateFormat(FULL_ST_FORMAT);
        return sdf.format(new Date(second));
    }
    public static String getShortDate(long milliS){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
        return sdf.format(new Date(milliS));
    }
    public static String getNow(){
        SimpleDateFormat sdf = new SimpleDateFormat(FULL_ST_FORMAT);
        return sdf.format(new Date());
    }
    public static String getNow2(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(new Date());
    }
    public static String getNowTimeInMillis(){
        SimpleDateFormat sdf = new SimpleDateFormat(DATA_FORMAT);
        return sdf.format(new Date());
    }
    public static String getNowTime(){
        SimpleDateFormat sdf = new SimpleDateFormat(FULL_ST_FORMAT_S);
        return sdf.format(new Date());
    }
    public static String getNows(){
        SimpleDateFormat sdf = new SimpleDateFormat(ST_CN_FORMATS);
        return sdf.format(new Date());
    }

    public static String getShortDate(){
        SimpleDateFormat sdf=new SimpleDateFormat(DAY_FORMAT);
        return sdf.format(new Date());
    }

    public static String getShoDate(){
        SimpleDateFormat sdf=new SimpleDateFormat(DATA_FORMAT);
        return sdf.format(new Date());
    }
    public static String getShoDateDay(){
        SimpleDateFormat sdf=new SimpleDateFormat(DATA_FORMAT_DAY);
        return sdf.format(new Date());
    }

    /**
     * 获取几年之后的今天的日期
     * @param i
     * @return
     */
    public static Date getYearDate(int i){
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.YEAR, i);//上面的第一个参数应该是1，表示年份
        return cal.getTime();
    }

   /* public static void main(String[] args) {
        System.out.println(getNumDay("2017-11-16",15));
    }*/
    
    /**
     * 求两个时间中间间隔的天数
     * @param time1
     * @param time2
     * @return
     */
    public static long getQuots(String time1, String time2){
        long quot = 0;
        SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date1 = ft.parse( time1 );
            Date date2 = ft.parse( time2 );
            quot = date1.getTime() - date2.getTime();
            quot = quot / 1000 / 60 / 60 / 24;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return quot;
    }
    public static Date strToDate(String dateStr){
        if (dateStr==null)
            return  null;
        SimpleDateFormat sdf =   new SimpleDateFormat(CURRENCY_ST_FORMAT);
        String str = dateStr;
        if (str.length()<17){
            str+=":00";
        }
        try {
            return sdf.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     *
     * @param dateStr
     * @return
     */
    public static Date strToDate_ex_full(String dateStr){
        if (dateStr==null)
            return  null;
        SimpleDateFormat sdf =   new SimpleDateFormat(FULL_ST_FORMAT);
        String str = dateStr;
        try {
            return sdf.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     *
     * @param dateStr
     * @return
     */
    public static Date strToDate_ex(String dateStr){
        if (dateStr==null)
            return  null;
        SimpleDateFormat sdf =   new SimpleDateFormat(DATA_FORMAT);
        String str = dateStr;
        try {
            return sdf.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String formatTime(Date date,String format){
        if (date==null){
            return "";
        }
        if (format.equals(""))
            format = CURRENCY_ST_FORMAT;
        SimpleDateFormat ft = new SimpleDateFormat(format);
        return ft.format(date);
    }



    //获取当周周末起止日期
    public static List<Date> weekByDate(){;
        Calendar cal = Calendar.getInstance();
        int cur = cal.get(Calendar.DAY_OF_WEEK);

        Date start =null;
        Date end = null;
        //周五到周日
        int bfday = 0;
        if (cur== Calendar.SUNDAY ){
            cal.add(Calendar.DAY_OF_YEAR,1);
            end = cal.getTime();
            cal.add(Calendar.DAY_OF_YEAR,-3);
            start = cal.getTime();
        }
        else {
            bfday = Calendar.FRIDAY - cur;
            cal.add(Calendar.DAY_OF_YEAR,bfday);
            start = cal.getTime();
            cal.add(Calendar.DAY_OF_YEAR,3);
            end = cal.getTime();
        }

        List<Date> dates = new ArrayList<Date>();
        dates.add(start);
        dates.add(end);
        return dates;

    }

    public static long  getSeconds(String datestr){
        Date date = strToDate_ex(datestr);
        return date.getTime()/1000;
    }

    public static long  getSeconds(Date date){
        return date.getTime()/1000;
    }

    /**
     * 根据毫秒获取时间的描述
     * @param dif
     * @return
     */
    public static String getTimeDesc(long dif){
        long dayMs = 1000*60*60*24;
        long hourMs = 1000*60*60;
        long minuteMs = 1000*60;
        String result =  "";
        if (dif>=dayMs){
            long day = dif/dayMs;
            long hour = (dif%dayMs)/hourMs;
            result = String.format("%d天%d小时", day, hour);
        }
        else if (dif>=hourMs){
            long hour = dif/hourMs;
            long minutes = (dif%hourMs)/minuteMs;
            result = String.format("%d小时%d分钟", hour, minutes);
        }
        else{
            long minutes = dif/minuteMs;
            result = String.format("%d分钟", minutes);
        }

        return result;

    }

    public static String getDate(){
        SimpleDateFormat sdf=new SimpleDateFormat(YEAR_FORMAT);
        return sdf.format(new Date());
    }
    //获取本周周一日期
    public static String getWeekStartDate(){
        SimpleDateFormat sdf = new SimpleDateFormat(FULL_ST_FORMAT);
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        Date date = cal.getTime();
        return sdf.format(date);
    }

    /**
     * 获取前一天日期
     * @param date
     * @return
     */
    public static String getBeforeDay(String date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(str2Date(date));
        calendar.add(Calendar.DAY_OF_MONTH,-1);
//        date = calendar.getTime().toString();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        date = sdf.format(calendar.getTime());
        return date;
    }


    /**
     * 获取前30天的日期
     * @param date
     * @return
     */
    public static String getBeforeyear(String date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(str3Date(date));
        calendar.add(Calendar.DATE,-30);
//        date = calendar.getTime().toString();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        date = sdf.format(calendar.getTime());
        return date;
    }
    /**
     * String转Date
     * @param dateString
     * @return
     */
    public static Date str3Date(String dateString){
        Date date = null;
        try{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            date = sdf.parse(dateString);
        }catch (ParseException  e){
            e.printStackTrace();
        }
        return date;
    }
    /**
     * 获取一个日期的前几天或后几天
     * @param date yyyy-MM-dd
     * @return
     */
    public static String getNumDay(String date ,Integer num){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(str2Date(date));
        calendar.add(Calendar.DAY_OF_MONTH,num);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        date = sdf.format(calendar.getTime());
        return date;
    }

    /**
     * String转Date
     * @param dateString
     * @return
     */
    public static Date str2Date(String dateString){
        Date date = null;
        try{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            date = sdf.parse(dateString);
        }catch (ParseException  e){
            e.printStackTrace();
        }
        return date;
    }
    /**
     *获取有字符串类型转日期类型
     * @param dateStr
     * @return
     */
    public static Date strToDateSection(String dateStr){
        if (dateStr==null)
            return  null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return sdf.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 日期类型转换成字符串
     * @param date
     * @return
     */
    public static String getShortDate(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }

    /**
     *两个字符串类型的时间比较
     * @param dateStr1,dateStr2
     * @return
     */
    public static Integer compareStrDate(String dateStr1,String dateStr2){
        if (dateStr1==null || dateStr2 == null)
            return  null;
        SimpleDateFormat sdf =   new SimpleDateFormat(FULL_ST_FORMAT);
        try {
            long longTime1 = sdf.parse(dateStr1).getTime();
            long longTime2 = sdf.parse(dateStr2).getTime();
            long differ = longTime1 - longTime2;
            if(differ > 0) {
                return 1;
            } else if(differ == 0) {
                return 0;
            } else {
                return -1;
            }
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
    //获取前一秒
    public static String getBeforemin(String date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(str2Date(date));
        calendar.add(Calendar.DAY_OF_MONTH,-1);
//        date = calendar.getTime().toString();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        date = sdf.format(calendar.getTime());
        return date;
    }
    //获取后一秒
    public static String getAftermin(String date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(str2Date(date));
        calendar.add(Calendar.DAY_OF_MONTH,+1);
//        date = calendar.getTime().toString();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        date = sdf.format(calendar.getTime());
        return date;
    }
}
