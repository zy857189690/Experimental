<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>演示管理1-新增</title>
    <<#include "../../../../inc/meta.ftl">
    <<#include  "../../../../inc/js.ftl">
</head>
<body class="body">
<form class="layui-form layui-form-pane"  method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                        <input type="text" name="name" autocomplete="off" placeholder="请输入名称" class="layui-input" lay-verify="required|name" lay-verType="tips" maxlength="50">
            </div>
            <div class="layui-form-mid layui-word-aux">选填</div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">字典值</label>
            <div class="layui-input-inline">
                        <@core.select name="dictField" ds="dict" key="REPORT_DEMO1_DICT_FIELD" value="1" />
            </div>
            <div class="layui-form-mid layui-word-aux">选填</div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">名称值</label>
            <div class="layui-input-inline">
                        <input type="text" name="nameField" autocomplete="off" placeholder="请输入名称值" class="layui-input" lay-verify="required|nameField" lay-verType="tips" maxlength="36">
            </div>
            <div class="layui-form-mid layui-word-aux">选填</div>
        </div>
    <hr>
    <div class="layui-form-item ">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="save" style="margin-left:115px;">立即提交</button>
        </div>
    </div>

</form>
<script>

    layui.use(['form', 'layedit', 'layer','laydate'], function(){
        var form = layui.form,layer = layui.layer;

        //注册自定义验证
        form.verify({
                // 名称
                name: function(value){
                    return '请完善校验规则！';
                },
                // 字典值
                dictField: function(value){
                    return '请完善校验规则！';
                },
                // 名称值
                nameField: function(value){
                    return '请完善校验规则！';
                },
        });
        //监听提交
        form.on('submit(save)', function(data){

            saveAjax('post',"/report/demo1/add",data.field,'json');
            return false;
        });
    });
</script>

</body>
</html>