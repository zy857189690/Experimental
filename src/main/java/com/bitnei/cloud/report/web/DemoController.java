package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.annotation.Module;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.report.domain.Demo;
import com.bitnei.cloud.report.service.IDemoService;
import com.bitnei.commons.datatables.LayModel;
import com.bitnei.commons.datatables.PagerModel;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
* <p>
* ----------------------------------------------------------------------------- <br>
* 工程名 ： 基础框架 <br>
* 功能： 演示管理<br>
* 描述： 演示管理控制器<br>
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
* <td>chenpeng</td>
* <td>创建</td>
* </tr>
* </table>
* <br>
* <font color="#FF0000">注意: 本内容仅限于[北京理工新源信息科技有限公司]内部使用，禁止转发</font> <br>
*
* @version 1.0
*
* @author chenpeng
* @since JDK1.8
*/
@Module(name = "演示管理")
@Controller
@RequestMapping(value = "/report/demo")
public class DemoController {


    public final static String BASE="/module/report/demo/";
    //模块基础请求前缀
    public final static String BASE_REQ_PATH ="/report/demo/";

    private final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private IDemoService demoService;


    /**
     * 管理页面
     * @param model
     * @return
     */
    @GetMapping(value = "/list")
    @RequiresPermissions(BASE_REQ_PATH+"list")
    @SLog(action = "演示管理列表")
    public String list(Model model){

        return BASE+"list";
    }


    /**
     * 表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    @RequiresPermissions(BASE_REQ_PATH+"list")
    public PagerModel datagrid(){

        PagerModel m = demoService.pageQuery();
        return m;

    }

    /**
    * 导出
    * @return
    */
    @GetMapping(value = "/export")
    @RequiresPermissions(BASE_REQ_PATH+"export")
    public void export(){

        demoService.export();
        return ;

    }



    /**
     * 新增页面
     * @param model
     * @return
     */
    @GetMapping(value = "/add")
    @RequiresPermissions(BASE_REQ_PATH+"add")
    @SLog(action = "新增页面")
    public String add(Model model) {

        return BASE+"add";
    }



    /**
     * 新增页面
     * @param model
     * @return
     */
    @GetMapping(value = "/view")
    @RequiresPermissions(BASE_REQ_PATH+"view")
    @SLog(action = "查看页面")
    public String view(Model model,String id) {
        Demo obj = demoService.findById(id);
        model.addAttribute("obj",obj);
        return BASE+"view";
    }


    /**
    * 保存
    * @param demo
    * @return
    */
    @PostMapping(value = "/add")
    @ResponseBody
    @RequiresPermissions(BASE_REQ_PATH+"add")
    public AppBean add(Demo demo){
        demoService.insert(demo);
        return new AppBean("增加成功");
    }

    /**
     * 编辑页面
     * @param model
     * @return
     */
    @GetMapping(value = "/update")
    @RequiresPermissions(BASE_REQ_PATH+"update")
    @SLog(action = "编辑页面")
    public String update(Model model,String id){

        Demo obj = demoService.findById(id);
        model.addAttribute("obj",obj);
        return BASE+"update";
    }

    /**
    * 保存
    * @param demo
    * @return
    */
    @PostMapping(value = "/update")
    @ResponseBody
    @RequiresPermissions(BASE_REQ_PATH+"update")
    public AppBean update(Demo demo){

        demoService.update(demo);
        return new AppBean("更新成功");
    }




    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping(value = "/del")
    @ResponseBody
    @RequiresPermissions(BASE_REQ_PATH+"del")
    @SLog(action = "删除")
    public AppBean delete(String ids){

        int count = demoService.deleteMulti(ids);
        return new AppBean(String.format("删除成功，共删除了%d条记录", count));

    }


}
