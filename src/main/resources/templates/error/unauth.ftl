<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>无访问权限</title>
    <link rel="stylesheet" href="/lib/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field">
    <legend>错误信息</legend>
    <div class="layui-field-box layui-bg-red"  >
        对不起，您无权访问${url!}。如有疑问，请联系管理员！
    </div>
</fieldset>

<hr>
<pre class="layui-code">
${exception!}
</pre>

<script src="/lib/layui/layui.js"></script>
<script>
    //一般直接写在一个js文件中
    layui.use(['code'], function(){
        layui.code({
            title: '详细异常信息'
        }); //引用code方法
    });
</script>
</body>
</html>
          