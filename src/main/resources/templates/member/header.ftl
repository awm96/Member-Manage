<div class="navbar navbar-default" role="navigation">
  <div class="navbar-inner">
    <button type="button" class="navbar-toggle pull-left animated flip">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="/">
      <img alt="Charisma Logo" src="${req.contextPath}/images/favicon.ico" class="hidden-xs"/>
      <span>大众天成会员管理系统</span>
    </a>
    <div class="btn-group pull-right theme-container animated tada">
      <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
        <i class="glyphicon glyphicon-tint"></i><span class="hidden-sm hidden-xs"> 主题/皮肤</span>
        <span class="caret"></span>
      </button>
      <ul class="dropdown-menu" id="themes">
        <li><a data-value="classic" href="#"><i class="whitespace"></i> 经典</a></li>
        <li><a data-value="cerulean" href="#"><i class="whitespace"></i> 蔚蓝</a></li>
        <li><a data-value="cyborg" href="#"><i class="whitespace"></i> 机械</a></li>
        <li><a data-value="simplex" href="#"><i class="whitespace"></i> 简单</a></li>
        <li><a data-value="darkly" href="#"><i class="whitespace"></i> 黑暗</a></li>
        <li><a data-value="lumen" href="#"><i class="whitespace"></i> 明亮</a></li>
        <li><a data-value="slate" href="#"><i class="whitespace"></i> 岩石</a></li>
        <li><a data-value="spacelab" href="#"><i class="whitespace"></i> 太空</a></li>
        <li><a data-value="united" href="#"><i class="whitespace"></i> 橙黄</a></li>
      </ul>
    </div>
    <div class="btn-group pull-right">
      <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
        <i class="glyphicon glyphicon-user"></i><span
          class="hidden-sm hidden-xs"> ${Session[_Constants.MEMBER_SESSION_KEY].name}</span>
        <span class="caret"></span>
      </button>
      <ul class="dropdown-menu">
        <li><a href="${req.contextPath}/member/update">修改个人信息</a></li>
        <li class="divider"></li>
        <li><a href="${req.contextPath}/member/logout">退出登陆</a></li>
      </ul>
    </div>
  </div>
</div>