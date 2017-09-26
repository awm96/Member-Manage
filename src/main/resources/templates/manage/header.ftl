<#assign hAdmin = Session[_Constants.ADMIN_SESSION_KEY]/>
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
                    class="hidden-sm hidden-xs"> 管理员[${hAdmin.name}]</span>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#" data-toggle="modal" data-target="#adminModal">修改个人信息</a></li>
                <li class="divider"></li>
                <li><a href="${req.contextPath}/manage/logout">退出登陆</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="modal fade" id="adminModal" tabindex="-1" role="dialog" aria-labelledby="adminModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h3>管理员基本信息</h3>
            </div>
            <div class="modal-body">
                <form id="adminForm" action="${req.contextPath}/manage/update" class="form-horizontal" method="post">
                    <div class="form-group">
                        <label for="h_admin_name" class="col-sm-4 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="name" value="${hAdmin.name}" class="form-control" id="h_admin_name" placeholder="管理员名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="h_admin_password" class="col-sm-4 control-label">密码</label>
                        <div class="col-sm-8">
                            <input type="password" name="password" class="form-control" id="h_admin_password" placeholder="登陆密码，不修改请留空">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="h_admin_type" class="col-sm-4 control-label">类型</label>
                        <div class="col-sm-8">
                            <select name="type" id="h_admin_type" class="form-control">
                                <option ${(hAdmin.type == 0)?string("selected","")} value="0">普通管理员</option>
                                <option ${(hAdmin.type == 1)?string("selected","")} value="1">超级管理员</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>
                <a href="javascript:$('#adminForm').submit();" class="btn btn-primary">保存</a>
            </div>
        </div>
    </div>
</div>