package com.bitnei.cloud.common;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class TreeNode implements Serializable {

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }
    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }
    public Map<String, Object> getAttributes() {
        return attributes;
    }
    public void setAttributes(Map<String, Object> attributes) {
        this.attributes = attributes;
    }
    public List<TreeNode> getChildren() {
        if (children==null)
            children = new ArrayList<TreeNode>();
        return children;
    }
    public void setChildren(List<TreeNode> children) {
        this.children = children;
    }
    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }
    public String getIconCls() {
        return iconCls;
    }
    public boolean isChecked() {
        return checked;
    }
    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    //by chenpeng
    //系统所有的ID都为整型，将原先的string改为integer
    private String id;
    private String text;
    private String state;
    private String iconCls;
    private boolean checked;
    private Map<String,Object> attributes;
    private List<TreeNode> children;
    private Double lng;
    private Double lat;
    private Integer level;
    private Integer statist;
    private String name;
//  用户菜单的打开方式，1是内部打开 2是外部打开
    private String openType;

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Double getLng() {
        return lng;
    }

    public void setLng(Double lng) {
        this.lng = lng;
    }

    public Double getLat() {
        return lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    public Integer getStatist() {
        return statist;
    }

    public void setStatist(Integer statist) {
        this.statist = statist;
    }

    public String getName() {
        return text;
    }

    public String getOpenType() {
        return openType;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setOpenType(String openType) {
        this.openType = openType;
    }
}
