package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.JsonUtil;
import com.bitnei.cloud.common.TreeNode;
import com.bitnei.cloud.common.TreeUtil;
import com.bitnei.cloud.report.domain.SysModule;
import com.bitnei.cloud.report.service.IndexService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@Controller
@RequestMapping(value = "/report/admin")
public class IndexController {

    public final static String BASE = "/module/report/admin/";
    public final static String BASE2 = "/module/report/demo1/";

    @Autowired
    private IndexService indexService;
    @RequestMapping("/index")
    public String index(ModelMap modelMap, HttpServletRequest request) {
        modelMap.put("component", "hellotest");
        return BASE+"index";
    }


    @RequestMapping("/west")
    public String west(ModelMap modelMap, HttpServletRequest request,Model model) {

        List<SysModule> list=indexService.findSysMoudle();
        TreeNode treeNode = TreeUtil.moduleTree(list, "0");
        for (int i = 0; i < treeNode.getChildren().size(); i++) {
            if (i == 0) {
                treeNode.getChildren().get(i).setState("open");
                for (TreeNode node : treeNode.getChildren().get(i).getChildren()) {
                    node.setState(null);
                }
            } else {
                treeNode.getChildren().get(i).setState("closed");
            }
        }
        String root = JsonUtil.object2json(treeNode);
        model.addAttribute("root", root);
        return BASE+"west";
    }
    @RequestMapping("/center")
    public String center(ModelMap modelMap, HttpServletRequest request) {
        return BASE+"center";
      //  return BASE2+"list";
    }

    @RequestMapping("/north")
    public String north(ModelMap modelMap, HttpServletRequest request) {
        return BASE+"north";
    }

    @RequestMapping("/drug")
    public String drug(ModelMap modelMap, HttpServletRequest request) {
        return "/module/report/drug/list";
    }
    @RequestMapping("/experimentalStage")
    public String experimentalStage(ModelMap modelMap, HttpServletRequest request) {
        return "/module/report/experimentalStage/list";
    }
    @RequestMapping("/formula")
    public String formula(ModelMap modelMap, HttpServletRequest request) {
        return "/module/report/formula/list";
    }
    @RequestMapping("/rawData")
    public String rawData(ModelMap modelMap, HttpServletRequest request) {
        return "/module/report/rawData/list";
    }

    @RequestMapping("/position")
    public String position(ModelMap modelMap, HttpServletRequest request) {
        return "/module/report/demo1/list";
    }

}
