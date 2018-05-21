package com.bitnei.cloud.report.web;

import com.alibaba.fastjson.JSONObject;
import com.bitnei.cloud.common.annotation.SLog;
import com.bitnei.cloud.report.service.IChangeTBoxService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/changeTBox")
public class ChangeTBoxController {

    //模板文件目录
    private final static String BASE="/module/report/changeTBox/";
    private final Logger LOGGER = Logger.getLogger(getClass());

    //模块基础请求前缀
    private final static String BASE_REQ_PATH ="/report/changeTBox";
    //新增
    private final static String URL_ADD = BASE_REQ_PATH +"/add";

    @Autowired
    private IChangeTBoxService changeTBoxService;

    /**
     * 编辑页面
     * @param model
     * @return
     */
    @GetMapping(value = "/add")
    @SLog(action = "编辑页面")
    public String add(Model model, String vin, String sign){
        model.addAttribute("vin", vin);
        model.addAttribute("sign", sign);
        return BASE+"add";
    }

    @PostMapping(value = "/changeTBox")
    @ResponseBody
    @SLog(action = "更换T-BOX")
    public Map<String,Object> changeTBox(@RequestParam Map<String,String> map){
        Map<String,Object> result = new HashMap<String,Object>();
        result.put("res", false);

        try {
            JSONObject jsonObject = changeTBoxService.changeTBox(map);
            String retCode = (String) jsonObject.get("ret_code");
            if(retCode.equals("0")){
                result.put("msg", "更换成功");
                result.put("res", true);
            }else{
                result.put("msg", "更换失败，" + jsonObject.get("ret_msg"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

}
