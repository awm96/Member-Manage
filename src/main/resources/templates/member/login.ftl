<!DOCTYPE html>
<html lang="cn">
<head>
<#include "/common.ftl">
</head>

<body>
<div class="ch-container">
  <div class="row">

    <div class="row">
      <div class="col-md-12 center login-header">
        <img src="${req.contextPath}/images/logo.png"/>
        <img src="${req.contextPath}/images/slogan.png"/>
      </div>
      <!--/span-->
    </div><!--/row-->

    <div class="row">
      <div class="well col-md-5 center login-box">
      <#if Request[_Constants.ERROR_MSG_REQUEST_KEY]??>
        <div class="alert alert-danger">
        ${Request[_Constants.ERROR_MSG_REQUEST_KEY]}
        </div>
      <#else>
        <div class="alert alert-info">
          请输入身份证号、密码登陆
        </div>
      </#if>
        <form class="form-horizontal" action="${req.contextPath}/member/login" method="post">
          <fieldset>
            <div class="input-group input-group-lg">
              <span class="input-group-addon"><i class="glyphicon glyphicon-user red"></i></span>
              <input name="idCardNo" type="text" class="form-control" placeholder="身份证号" required>
            </div>
            <div class="clearfix"></div>
            <br>

            <div class="input-group input-group-lg">
              <span class="input-group-addon"><i class="glyphicon glyphicon-lock red"></i></span>
              <input name="password" type="password" class="form-control" placeholder="密码" required>
            </div>
            <div class="clearfix"></div>
            <p class="center col-md-5">
              <button type="submit" class="btn btn-primary">登陆</button>
            </p>
          </fieldset>
        </form>
      </div>
      <!--/span-->
    </div><!--/row-->
  </div><!--/fluid-row-->

</div><!--/.fluid-container-->
</body>
</html>
