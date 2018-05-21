package com.bitnei.cloud.report.web;

import com.bitnei.cloud.common.bean.AppBean;
import com.bitnei.cloud.report.domain.Demo1;
import com.bitnei.cloud.report.service.IDemo1Service;
import com.bitnei.cloud.common.annotation.*;
import com.bitnei.commons.annotation.TakeTime;
import com.bitnei.commons.config.DBEnum;
import com.bitnei.commons.datatables.PagerModel;
import com.bitnei.commons.datatables.DataGridOptions;
import com.bitnei.commons.datatables.LayModel;
import com.bitnei.commons.util.PagerUtil;
import com.bitnei.commons.util.UtilHelper;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
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
* 功能： 演示管理1<br>
* 描述： 演示管理1控制器<br>
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
* <td>2018-03-13 17:07:14</td>
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
@Module(name = "演示管理1")
@Controller
@RequestMapping(value = "/report/demo1")
public class Demo1Controller{

    //模板文件目录
    public final static String BASE="/module/report/demo1/";

    private final Logger logger = Logger.getLogger(getClass());
    //模块基础请求前缀
    public final static String BASE_REQ_PATH ="/report/demo1";
    //新增
    public final static String URL_LIST = BASE_REQ_PATH +"/list";
    //新增
    public final static String URL_ADD = BASE_REQ_PATH +"/add";
    //编辑
    public final static String URL_UPDATE = BASE_REQ_PATH +"/update";
    //查看
    public final static String URL_VIEW = BASE_REQ_PATH +"/view";
    //删除
    public final static String URL_DEL = BASE_REQ_PATH +"/del";
    //导出
    public final static String URL_EXPORT = BASE_REQ_PATH +"/export";
    //导入
    public final static String URL_IMPORT = BASE_REQ_PATH +"/import";



    @Autowired
    private IDemo1Service demo1Service;


    /**
     * 管理页面
     * @param model
     * @return
     */
    @GetMapping(value = "/list")
    @RequiresPermissions(URL_LIST)
    @SLog(action = "演示管理1列表")
    public String list(Model model){

        return BASE+"list";
    }


    /**
     * 表格查询
     * @return
     */
    @PostMapping(value = "/datagrid")
    @ResponseBody
    @RequiresPermissions(URL_LIST)
    public PagerModel datagrid(){

        PagerModel pm = demo1Service.pageQuery();
        return pm;

    }

    /**
    * 导出
    * @return
    */
    @GetMapping(value = "/export")
    @RequiresPermissions(URL_EXPORT)
    public void export(){

        demo1Service.export();
        return ;

    }



    /**
     * 新增页面
     * @param model
     * @return
     */
    @GetMapping(value = "/add")
    @RequiresPermissions(URL_ADD)
    @SLog(action = "新增页面")
    public String add(Model model) {

        return BASE+"add";
    }



    /**
     * 查看页面
     * @param model
     * @return
     */
    @GetMapping(value = "/view")
    @RequiresPermissions(URL_VIEW)
    @SLog(action = "查看页面")
    public String view(Model model,String id) {
        Demo1 obj = demo1Service.findById(id);
        model.addAttribute("obj",obj);
        return BASE+"view";
    }


    /**
    * 保存
    * @param demo1
    * @return
    */
    @PostMapping(value = "/add")
    @ResponseBody
    @RequiresPermissions(URL_ADD)
    public AppBean add(Demo1 demo1){
        demo1Service.insert(demo1);
        return new AppBean("增加成功");
    }

    /**
     * 编辑页面
     * @param model
     * @return
     */
    @GetMapping(value = "/update")
    @RequiresPermissions(URL_UPDATE)
    @SLog(action = "编辑页面")
    public String update(Model model,String id){

        Demo1 obj = demo1Service.findById(id);
        model.addAttribute("obj",obj);
        return BASE+"update";
    }

    /**
    * 保存
    * @param demo1
    * @return
    */
    @PostMapping(value = "/update")
    @ResponseBody
    @RequiresPermissions(URL_UPDATE)
    public AppBean update(Demo1 demo1){

        demo1Service.update(demo1);
        return new AppBean("更新成功");
    }




    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping(value = "/del")
    @ResponseBody
    @RequiresPermissions(URL_DEL)
    @SLog(action = "删除")
    public AppBean delete(String ids){

        int count = demo1Service.deleteMulti(ids);
        return new AppBean(String.format("删除成功，共删除了%d条记录", count));

    }


}
