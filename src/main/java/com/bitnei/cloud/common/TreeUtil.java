package com.bitnei.cloud.common;


import com.bitnei.cloud.report.domain.SysModule;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;

public class TreeUtil {

    //根据模块列表转化为树结果
    public static TreeNode moduleTree(List<SysModule> modules, String root_id) {
        TreeNode root = new TreeNode();
        //查找根
        for (SysModule entity : modules) {
            if (entity.getId().equals(root_id)) {
                root.setId(entity.getId());
                root.setText(entity.getName());
                root.setIconCls(entity.getIcon());
                root.setOpenType(entity.getOpenType());
                Map<String, Object> map = new java.util.HashMap<String, Object>();
                if (entity.getAction() != null && !StringUtils.isEmpty(entity.getAction())) {
                    map.put("url", entity.getAction());
                    String action = entity.getAction();
                    if (action.indexOf(".") > -1) {
                        action = action.substring(1, action.indexOf("."));
                    }
                    String[] split = action.split("/");
                    map.put("divs", split[0]);
                    // 针对模块化服务，菜单为直接修改原系统模块菜单地址的iframe页面name处理
                    if (action.contains("/evsmc_monitor_service/") && split.length > 2) {
                        String divs = "";
                        for (int t = 2; t < split.length; t++) {
                            divs += split[t];
                        }
                        map.put("divs", divs);
                    } else {
                        // 获取ctx，针对新模块化服务的iframe页面name处理
                        String[] idTemps = entity.getId().split("_");
                        if (idTemps.length == 2) {
                            map.put("ctx", idTemps[0]);
                            if (StringUtils.isEmpty(split[0])) {
                                String url = entity.getAction().replace("/" + idTemps[0], "");
                                map.put("divs", url.replaceAll("/", "").replaceAll("=", "").replaceAll("\\?", ""));
                            }
                        }
                    }
                }

                root.setAttributes(map);
                if (entity.getPath() != null && entity.getPath().split("/").length > 3)
                    root.setState("closed");
                break;
            }
        }
        //modules.remove(root);
        //查找所有子结点
        for (SysModule en : modules) {
            if (en.getParentId().equals(root.getId()) && en.getIsFun() == 0) {
                root.getChildren().add(TreeUtil.moduleTree(modules, en.getId()));
            }
        }
        return root;

    }

    //根据模块列表转化为树结果
    public static TreeNode moduleTreeWithFun(List<SysModule> modules, String root_id, List<String> ready_list, Integer level) {

        TreeNode root = new TreeNode();
        //查找根
        for (SysModule entity : modules) {
            if (entity.getId().equals(root_id)) {
                root.setId(entity.getId());
                root.setText(entity.getName());
                root.setIconCls(entity.getIcon());
                root.setState(entity.getState());
//                if (entity.getPath()!=null && entity.getPath().split("/").length > 5){
//                    root.setState("closed");
//                    if (en.get)
//                }


                if (ready_list.contains(entity.getId())) {
                    root.setChecked(true);
                }
                break;
            }
        }
        //查找所有子结点
        for (SysModule en : modules) {
//            if (en.getParentId().equals(root.getId())  && (level.intValue() == 1 || en.isCheck())) {
//                root.getChildren().add(TreeUtil.moduleTreeWithFun(modules, en.getId(), ready_list, level));
//            }
            if (en.getParentId().equals(root.getId())) {
                TreeNode treeNode = TreeUtil.moduleTreeWithFun(modules, en.getId(), ready_list, null);
                if ("0".equals(treeNode.getId())){
                    treeNode.setState("open");
                }else{
                    treeNode.setState("closed");
                }
                if (treeNode.getChildren() == null || treeNode.getChildren().size() == 0){
                    treeNode.setChildren(null);
                    treeNode.setState(null);
                }
                root.getChildren().add(treeNode);
            }
        }
        return root;

    }

    //获取树表格
    public static SysModule moduleTreeGird(List<SysModule> modules, String root_id) {
        SysModule root = new SysModule();
        int i = 0;

        for (i = 0; i < modules.size(); i++) {
            SysModule mod = modules.get(i);
            if (mod.getId().equals(root_id)) {
                root = mod;
                root.getChildren().clear();
                break;
            }

        }

        //查找所有子结点
        for (i = 0; i < modules.size(); i++) {
            SysModule en = modules.get(i);
            if (en.getParentId().equals(root.getId())) {
                SysModule tm = TreeUtil.moduleTreeGird(modules, en.getId());

                root.getChildren().add(tm);
            }
        }

        return root;
    }








}
