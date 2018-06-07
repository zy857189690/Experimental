package com.bitnei.cloud.report.domain;

import com.bitnei.cloud.common.annotation.DictName;
import com.bitnei.cloud.common.annotation.LinkName;
import com.bitnei.cloud.common.bean.TailBean;

/**
 * Created by Administrator on 2018/6/6.
 */
public class DayMileageCheck  extends TailBean {
    /** 主键  **/
    private String id;
    /** 名称 **/
    private String name;
    /** 字典值 **/
    private Integer dictField;
    /** 名称值 **/
    private String nameField;
    /** 创建时间 **/
    private String createTime;
    /** 创建人 **/
    private String createBy;
    /** 更新时间 **/
    private String updateTime;
    /** 更新人 **/
    private String updateBy;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    @DictName(code = "REPORT_DEMO1_DICT_FIELD")
    public Integer getDictField() {
        return dictField;
    }

    public void setDictField(Integer dictField) {
        this.dictField = dictField;
    }
    @LinkName(table = "base_role")
    public String getNameField() {
        return nameField;
    }

    public void setNameField(String nameField) {
        this.nameField = nameField;
    }
    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }
    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }
    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }
}
