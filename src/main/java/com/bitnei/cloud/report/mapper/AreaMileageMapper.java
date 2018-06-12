package com.bitnei.cloud.report.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;


public interface AreaMileageMapper {

    /**
     * 获得所有的运营区域
     * @return
     */
    @Select("select name from    sys_unit ")
    List<String>  getUnit();


    /**
     * 获得所有的省级地区
     * @return
     */
    @Select(" select name as text,code as id ,id as mmd   from  sys_area  where  levels=1  and code is not null")
    List<Map<String,Object>> getProvince();

    /**
     * 通过省级地区获得市级地区
     * @param parentId
     * @return
     */
    @Select(" select name as text ,code as id   from  sys_area   where parent_id=#{0}  and code is not null ")
    List<Map<String,Object>>  getArea(String parentId);

    /**
     * 查询区域里程月报
     * @param map
     * @return
     */
/*
   @Select(
            "<script> "+
            "select u.*,u.quYuZong/u.zong*100 as zhanBi from ("+
            "select "+
            "'${shiJian}' as shiJian,"+
            "cveh.license_plate as chePai,"+
            "cveh.vin as VIN,"+
            "f.name as shangPai,"+
            "e.name as xingShi,"+
            "c.name as yunYing,"+
            "b.veh_model_name as cheLiangMing,"+
            "sum(meter_total_mileage) as quYuZong,"+
            "sum(gps_total_mileage) as  quYuGPS,"+
            "g.zong as zong, "+
            "sd.name as jieDuan "+
            "from veh_dayreport_region a "+
            "inner join  sys_vehicle CVEH   on  a.vid=CVEH.id "+
            "left join   sys_veh_model b    on  b.id=CVEH.veh_model_id "+
            "left join   sys_unit  c        on  c.id=CVEH.use_uint_id "+
            "left join   sys_area e         on  e.code=a.city "+
            "left join   sys_area f         on  f.id=cveh.sys_division_id "+
            "left join "+
            "(select  t.last_end_mileage zong,vid from  veh_dayreport_summary  t where t.report_date=#{date2} "+
            " )      g        on   g.vid=a.vid "+
            "LEFT JOIN sys_dict sd ON CVEH.registerstatus=sd.val AND sd.type='500' "+
            "where "+
            "<![CDATA[ a.report_date>= #{date1} and a.report_date<= #{date2} ]]> "+//时间判断
            "<if test= 'xingShi!=null '>  and (a.city = #{xingShi} or a.province = #{xingShi} )"+
             "</if>"+
            "<if test= 'shangPai!=null '> and f.name like #{shangPai} </if>"+
            "<if test= 'chePai!=null '> and cveh.license_plate like #{chePai} </if> "+
            "<if test= 'VIN!=null '> and cveh.vin like #{VIN} </if>"+
            "<if test= 'cheLiangMing!=null '> and b.veh_model_name like #{cheLiangMing} </if>"+
            "<if test= 'yunYing!=null '> and c.path like #{yunYing} </if> "+
            "<if test= 'jieDuan!=null '> and  CVEH.registerstatus = #{jieDuan} </if> "+
            "group by cveh.license_plate,  a.city "+
            ") u "+
            " where 1=1  "+
            "<if test ='quYuZong!=null '> <![CDATA[and  u.quYuZong> #{quYuZong}]]> </if> "+
            " order by u.xingShi asc,u.zong desc "+

            " limit ${begin},${end} "+
             "</script>"
            )*/
    List<Map<String,Object>> queryAreaMonthly(Map<String,Object> map);

    /*
    @Select(
            "<script> "+
                    "select count(1) from ("+
                    "select "+
                    "sum(meter_total_mileage) as quYuZong "+
                    "from veh_dayreport_region a "+
                    "inner join  sys_vehicle CVEH   on  a.vid=CVEH.id "+
                    "left join   sys_veh_model b    on  b.id=CVEH.veh_model_id "+
                    "left join   sys_unit  c        on  c.id=CVEH.use_uint_id "+
                    "left join   sys_area e         on  e.code=a.city "+
                    "left join   sys_area f         on  f.id=cveh.sys_division_id "+
                    "left join "+
                    "(select  t.last_end_mileage zong,vid from  veh_dayreport_summary  t where t.report_date= #{date2}"+
                    " )      g        on   g.vid=a.vid "+
                    "LEFT JOIN sys_dict sd ON CVEH.registerstatus=sd.val AND sd.type='500' "+
                    "where "+
                    "<![CDATA[ a.report_date>= #{date1} and a.report_date<= #{date2}]]> "+//时间判断
                    "<if test= 'xingShi!=null '>  and (a.city = #{xingShi} or a.province = #{xingShi} )"+
                    "</if>"+
                    "<if test= 'shangPai!=null '> and f.name like #{shangPai} </if>"+
                    "<if test= 'chePai!=null '> and cveh.license_plate like #{chePai} </if> "+
                    "<if test= 'VIN!=null '> and cveh.vin like #{VIN} </if>"+
                    "<if test= 'cheLiangMing!=null '> and b.veh_model_name like #{cheLiangMing} </if>"+
                    "<if test= 'yunYing!=null '> and c.path like #{yunYing} </if> "+
                    "<if test= 'jieDuan!=null '> and  CVEH.registerstatus = #{jieDuan} </if> "+
                    "group by cveh.license_plate,  a.city "+
                    ") u "+
                    " where 1=1  "+
                    "<if test ='quYuZong!=null '> <![CDATA[and  u.quYuZong> #{quYuZong}]]> </if> "+
                    "</script>"
    )*/
    Long countAreaMonthly(Map<String,Object> map);

/*
    @Select(
            "<script> "+
                    "select u.*,u.quYuZong/u.zong as zhanBi from ("+
                    "select "+
                    "'${shiJian}' as shiJian,"+
                    "cveh.license_plate as chePai,"+
                    "cveh.vin as VIN,"+
                    "f.name as shangPai,"+
                    "e.name as xingShi,"+
                    "c.name as yunYing,"+
                    "b.veh_model_name as cheLiangMing,"+
                    "sum(meter_total_mileage) as quYuZong,"+
                    "sum(gps_total_mileage) as  quYuGPS,"+
                    "g.zong as zong, "+
                    "sd.name as jieDuan "+
                    "from veh_dayreport_region a "+
                    "inner join  sys_vehicle CVEH   on  a.vid=CVEH.id "+
                    "left join   sys_veh_model b    on  b.id=CVEH.veh_model_id "+
                    "left join   sys_unit  c        on  c.id=CVEH.use_uint_id "+
                    "left join   sys_area e         on  e.code=a.city "+
                    "left join   sys_area f         on  f.id=cveh.sys_division_id "+
                    "left join "+
                    "(select  t.last_end_mileage zong,vid from  veh_dayreport_summary  t where t.report_date= #{date2}"+
                    " )      g        on   g.vid=a.vid "+
                    "LEFT JOIN sys_dict sd ON CVEH.registerstatus=sd.val AND sd.type='500' "+
                    "where "+
                    "<![CDATA[ a.report_date>= #{date1} and a.report_date< = #{date2} ]]> "+//时间判断
                    "<if test= 'xingShi!=null '>  and (a.city = #{xingShi} or a.province = #{xingShi} )"+
                    "</if>"+
                    "<if test= 'shangPai!=null '> and f.name like #{shangPai} </if>"+
                    "<if test= 'chePai!=null '> and cveh.license_plate like #{chePai} </if> "+
                    "<if test= 'VIN!=null '> and cveh.vin like #{VIN} </if>"+
                    "<if test= 'cheLiangMing!=null '> and b.veh_model_name like #{cheLiangMing} </if>"+
                    "<if test= 'yunYing!=null '> and c.path like #{yunYing} </if> "+
                    "<if test= 'jieDuan!=null '> and  CVEH.registerstatus = #{jieDuan} </if> "+
                    "group by cveh.license_plate,  a.city "+
                    ") u "+
                    " where 1=1  "+
                    "<if test ='quYuZong!=null '> <![CDATA[and  u.quYuZong> #{quYuZong}]]> </if> "+
                    " order by u.xingShi asc,u.zong desc "+
                    "</script>"
    )*/
    List<Map<String,Object> > downloadAreaMonthly(Map<String,Object> map);

}
