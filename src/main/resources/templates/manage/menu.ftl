<#assign mAdmin = Session[_Constants.ADMIN_SESSION_KEY]/>
<div class="col-sm-2 col-lg-2">
    <div class="sidebar-nav">
        <div class="nav-canvas">
            <div class="nav-sm nav nav-stacked">
            </div>
            <ul class="nav nav-pills nav-stacked main-menu">
                <li class="nav-header">主菜单</li>
                <li>
                    <a href="${req.contextPath}/manage/member/list"><i class="glyphicon glyphicon-user"></i><span> 会员管理</span></a>
                </li>
                <li>
                    <a href="/manage/bill/list"><i class="glyphicon glyphicon-shopping-cart"></i><span> 业务交易</span></a>
                </li>
                <#if mAdmin.type == 1>
                <li>
                    <a href="/manage/admin/list"><i class="glyphicon glyphicon-cog"></i><span> 管理员管理</span></a>
                </li>
                <li class="nav-header hidden-md">统计分析</li>
                <li>
                    <a href="/manage/statistics"><i class="glyphicon glyphicon-random"></i><span> 仪表盘</span></a>
                </li>
                </#if>
            </ul>
        </div>
    </div>
</div>