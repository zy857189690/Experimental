<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>演示管理1-编辑</title>
<#include "../../../../inc/css.ftl">
</head>
<body class="body">
<form class="layui-form layui-form-pane"  method="post">
    <input type="hidden" name="id" value="${(obj.id)!}">
            <div class="layui-form-item">
                <label class="layui-form-label">名称</label>
                <div class="layui-input-inline">
                            <input type="text" name="name" autocomplete="off" value="${(obj.name)!}"  placeholder="请输入名称" class="layui-input" lay-verify="required|name" lay-verType="tips" maxlength="50">
                </div>
                <div class="layui-form-mid layui-word-aux">选填</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">字典值</label>
                <div class="layui-input-inline">
                            <@core.select name="dictField" ds="dict" key="REPORT_DEMO1_DICT_FIELD" value="${(obj.dictField)!}" />
                </div>
                <div class="layui-form-mid layui-word-aux">选填</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">名称值</label>
                <div class="layui-input-inline">
                            <input type="text" name="nameField" autocomplete="off" value="${(obj.nameField)!}"  placeholder="请输入名称值" class="layui-input" lay-verify="required|nameField" lay-verType="tips" maxlength="36">
                </div>
                <div class="layui-form-mid layui-word-aux">选填</div>
            </div>
    <hr>
    <div class="layui-form-item ">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="save">立即提交</button>
        </div>
    </div>


</form>
<#include "../../../inc/js.ftl">
<script>

    layui.use(['form', 'layedit','layer', 'laydate'], function(){
        var form = layui.form,layer = layui.layer, laydate = layui.laydate;

        //注册自定义验证
        form.verify({
                name: function(value){
                    return '请完善校验规则！';
                },
                dictField: function(value){
                    return '请完善校验规则！';
                },
                nameField: function(value){
                    return '请完善校验规则！';
                },
        });
        //监听提交
        form.on('submit(save)', function(data){

            saveAjax('post',"/report/demo1/update",data.field,'json');
            return false;
        });
    });
</script>

</body>
</html>