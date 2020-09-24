package com.bitnei.cloud.report.domain;

import lombok.Data;
import org.springframework.data.annotation.Transient;

import java.util.ArrayList;
import java.util.List;

@Data
public class SysModule {
    private String id;
    private String name;
    private String parentId;
    private Integer isRoot;
    private Integer isFun;
    private String path;
    private String icon;
    private String action;
    private boolean isCheck;
    private Integer orderNum;
    private Integer isFullScreen;
    private String openType;//打开方式1是内部,2是外部

    private String isHidden;//是否隐藏： 0 ，正常，1，隐藏


    public void setCheck(boolean check) {
        isCheck = check;
    }

 

    public void setIsHidden(String isHidden) {
        this.isHidden = isHidden;
    }

    private Integer belong;
  


    private String iconCls;
    private List<SysModule> children;
    private String moduleName;

    private String state;


    @Transient
    public String getIconCls() {
        return icon;
    }

    public void setIconCls(String iconCls) {
        this.icon = iconCls;
    }

    @Transient
    public String getModuleName() {
        String act = getAction();
        if (act != null) {
            String[] acts = act.split("/");
            if (acts.length >= 2)
                return acts[1];
        }
        return "";
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    @Transient
    public List<SysModule> getChildren() {
        if (children == null) {
            children = new ArrayList<SysModule>();
        }
        return children;
    }

    public void setChildren(List<SysModule> children) {
        this.children = children;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public Integer getIsRoot() {
        return isRoot;
    }

    public void setIsRoot(Integer isRoot) {
        this.isRoot = isRoot;
    }


    public Integer getIsFun() {
        return isFun;
    }

    public void setIsFun(Integer isFun) {
        this.isFun = isFun;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getIcon() {
        if (icon == null || icon.equals("")) {
            if (getIsFun() == 1) {
                setIcon("icon_nat_btn");
            } else {
                setIcon("icon-nat_module");
            }
        }

        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SysModule that = (SysModule) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (parentId != null ? !parentId.equals(that.parentId) : that.parentId != null) return false;
        if (isRoot != null ? !isRoot.equals(that.isRoot) : that.isRoot != null) return false;
        if (isFun != null ? !isFun.equals(that.isFun) : that.isFun != null) return false;
        if (path != null ? !path.equals(that.path) : that.path != null) return false;
        if (icon != null ? !icon.equals(that.icon) : that.icon != null) return false;
        if (action != null ? !action.equals(that.action) : that.action != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (parentId != null ? parentId.hashCode() : 0);
        result = 31 * result + (isRoot != null ? isRoot.hashCode() : 0);
        result = 31 * result + (isFun != null ? isFun.hashCode() : 0);
        result = 31 * result + (path != null ? path.hashCode() : 0);
        result = 31 * result + (icon != null ? icon.hashCode() : 0);
        result = 31 * result + (action != null ? action.hashCode() : 0);
        return result;
    }

    @Transient
    public boolean isCheck() {
        return isCheck;
    }

    public void setIsCheck(boolean isCheck) {
        this.isCheck = isCheck;
    }

    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    @Transient
    public String getState() {
//        if (getIsFun()==1){
//            state = "open";
//        }
//        else if (getPath().split("/").length>4){
//            state = "closed";
//        }
        state = "open";
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }


    private String subActions;
    public String getSubActions() {
        return subActions;
    }

    public void setSubActions(String subActions) {
        this.subActions = subActions;
    }

    public String getOpenType() {
        return openType;
    }

    public void setOpenType(String openType) {
        this.openType = openType;
    }
}
