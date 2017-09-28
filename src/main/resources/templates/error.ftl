<!DOCTYPE html>
<html lang="cn">
<head>
  <meta charset="utf-8">
  <link href='http://fonts.googleapis.com/css?family=Creepster|Audiowide' rel='stylesheet'
        type='text/css'>
  <link href='${req.contextPath}/css/error.css' rel='stylesheet' type='text/css'>
  <title>大众天成会员管理系统</title>
</head>
<body>
<p class="error-code">${status}</p>
<p class="error-msg">${error}</p>
<div class="clear"></div>
<div class="content">
${message!}<br><br>
<#if Session[_Constants.ADMIN_SESSION_KEY]?? && Session[_Constants.ADMIN_SESSION_KEY].type == 1 && exception??>
  <div class="row">
    <div class="col-md-12">
      <h3>异常详细信息: ${exception}</h3>
      <code>${trace!}</code>
    </div>
  </div>
</#if>
  <a href="${req.contextPath}">返回首页</a>
</div>
</body>
</html>
