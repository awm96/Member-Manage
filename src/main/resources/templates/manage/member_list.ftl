<!DOCTYPE html>
<html lang="cn">
<head>
<#include "/common.ftl">
</head>

<body>
<#include "/manage/header.ftl">

<div class="ch-container">
    <div class="row">
        <#include '/manage/menu.ftl'/>
        <div id="content" class="col-lg-10 col-sm-10">
            <table class="table table-striped table-bordered responsive">
                <thead>
                <tr>
                    <th><i class="glyphicon glyphicon-screenshot"></i> 姓名</th>
                    <th><i class="glyphicon glyphicon-tags"></i> 身份证号</th>
                    <th><i class="glyphicon glyphicon-shopping-cart"></i> 手机号码</th>
                    <th><i class="glyphicon glyphicon-calendar"></i> 会员级别</th>
                    <th><i class="glyphicon glyphicon-user"></i> 操作员</th>
                </tr>
                </thead>
                <tbody>
                <#list page.resultList as item>
                <tr>
                    <td>${item.masterId}</td>
                    <td>
                        <#if item.transType == 0>
                            <span class="label label-primary">储值</span>
                        <#elseif item.transType == 1>
                            <span class="label label-primary">储值充正</span>
                        <#elseif item.transType == 2>
                            <span class="label label-success">消费</span>
                        <#elseif item.transType == 3>
                            <span class="label label-success">消费充正</span>
                        <#elseif item.transType == 4>
                            <span class="label label-danger">积分</span>
                        <#elseif item.transType == 5>
                            <span class="label label-danger">积分充正</span>
                        </#if>
                    </td>
                    <td>¥${item.amount}</td>
                    <td>${item.createTime}</td>
                    <td>${item.creatorName}</td>
                </tr>
                <#else>
                <tr><td colspan="5">还没有任何记录...<i class="glyphicon glyphicon-question-sign red"></i></td></tr>
                </#list>
                </tbody>
            </table>
        <#include "/pagination.ftl"/>
        <@pagination pageNo=page.pageNo totalPage=page.totalPage totalRows=page.totalRows queryUrl="${req.contextPath}/member/dashboard"/>
        </div>
    </div>
</div>
</body>
</html>
