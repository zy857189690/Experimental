package com.bitnei.cloud.report.mapper;

import com.bitnei.cloud.report.domain.SysTermModelUnitEntity;
/**
 * <p>
 * ----------------------------------------------------------------------------- <br>
 * 工程名 ： 基础框架 <br>
 * 功能： DemoMapper接口<br>
 * 描述： DemoMapper接口，在xml中引用<br>
 * 授权 : (C) Copyright (c) 2017 <br>
 * 公司 : 北京理工新源信息科技有限公司<br>
 * ----------------------------------------------------------------------------- <br>
 * 修改历史 <br>
 * <table width="432" border="1">
 * <tr>
 * <td>版本</td>
 * <td>时间</td>
 * <td>作者</td>
 * <td>改变</td>
 * </tr>
 * <tr>
 * <td>1.0</td>
 * <td>2018-01-08 15:16:18</td>
 * <td>liuhiayuan</td>
 * <td>创建</td>
 * </tr>
 * </table>
 * <br>
 * <font color="#FF0000">注意: 本内容仅限于[北京理工新源信息科技有限公司]内部使用，禁止转发</font> <br>
 *
 * @version 1.0
 *
 * @author liuhiayuan
 * @since JDK1.8
 */
public interface SysTermModelUnitMapper {
    int deleteByPrimaryKey(String id);

    int insert(SysTermModelUnitEntity record);

    int insertSelective(SysTermModelUnitEntity record);

    SysTermModelUnitEntity selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SysTermModelUnitEntity record);

    int updateByPrimaryKey(SysTermModelUnitEntity record);
}