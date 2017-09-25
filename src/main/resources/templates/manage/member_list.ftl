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
          <div class="box col-md-12">
            <div class="box-inner">
              <div class="box-header well">
                <h2><i class="glyphicon glyphicon-info-sign"></i> 会员列表</h2>
                <div class="box-icon">
                  <a href="#" class="btn btn-minimize btn-round btn-default"><i
                      class="glyphicon glyphicon-chevron-up"></i></a>
                  <a href="#" class="btn btn-close btn-round btn-default"><i
                      class="glyphicon glyphicon-remove"></i></a>
                </div>
              </div>
              <div class="box-content">
                <div id="userManageAlter"></div>
                <div>
                  <div style="display:inline-block; margin-top:10px;margin-bottom:10px;">
                    <a href="${req.contextPath}/manage/member/save"><i class="glyphicon glyphicon-plus"></i> 新增会员</a>
                    <a href="#" data-toggle="modal" data-target="#queryModal" style="padding-left: 30px;"><i class="glyphicon glyphicon-search"></i> 查找会员</a>
                  </div>
                </div>
                <table class="table table-striped table-bordered responsive">
                    <thead>
                    <tr>
                        <th><i class="glyphicon glyphicon-user"></i> 姓名</th>
                        <th><i class="glyphicon glyphicon-qrcode"></i> 身份证号</th>
                        <th><i class="glyphicon glyphicon-headphones"></i> 手机号码</th>
                        <th><i class="glyphicon glyphicon-tags"></i> 会员级别</th>
                        <th><i class="glyphicon glyphicon-plus-sign"></i> 储值总额</th>
                        <th><i class="glyphicon glyphicon-minus-sign"></i> 消费余额</th>
                        <th><i class="glyphicon glyphicon-exclamation-sign"></i> 积分余额</th>
                        <th><i class="glyphicon glyphicon-calendar"></i> 最后交易时间</th>
                      <th><i class="glyphicon glyphicon-hand-right"></i> 操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list page.resultList as item>
                    <tr>
                        <td>${item.name}</td>
                        <td><span class="label label-default">${item.idCardNo}</span></td>
                        <td>${item.mobile!'--'}</td>
                        <td>
                            <#if item.level == 0>
                                <span class="label label-primary">普通会员</span>
                            <#elseif item.level == 1>
                                <span class="label label-success">银牌会员</span>
                            <#elseif item.level == 2>
                                <span class="label label-warning">金牌会员</span>
                            <#elseif item.level == 3>
                                <span class="label label-info">钻石会员</span>
                            </#if>
                        </td>
                        <td>¥${item.storedAmount}</td>
                        <td>¥${item.consumeAmount}</td>
                        <td>¥${item.integralAmount}</td>
                        <td>${item.lastTransTime!'--'}</td>
                        <td>
                          <div class="btn-group" role="group" aria-label="...">
                            <button class="btn btn-primary">编辑属性</button>
                            <button class="btn btn-success">交易记录</button>
                          </div>
                        </td>
                    </tr>
                    <#else>
                    <tr><td colspan="9">还没有任何记录...</td></tr>
                    </#list>
                    </tbody>
                </table>
                <#include "/pagination.ftl"/>
                <@pagination pageNo=page.pageNo totalPage=page.totalPage totalRows=page.totalRows queryFormId="queryForm"/>
              </div>
            </div>
          </div>
        </div>
    </div>
</div>
<div class="modal fade" id="queryModal" tabindex="-1" role="dialog" aria-labelledby="queryModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h3>查询条件</h3>
      </div>
      <div class="modal-body">
        <form id="queryForm" action="${req.contextPath}/manage/member/list" class="form-horizontal" method="post">
          <input type="hidden" name="pageNo">
          <div class="form-group">
            <label for="member_name" class="col-sm-4 control-label">姓名</label>
            <div class="col-sm-8">
              <input type="text" name="name" value="${RequestParameters.name!}" class="form-control" id="member_name" placeholder="真实姓名" required>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label">身份证号</label>
            <div class="col-sm-8">
              <p class="form-control-static">
                <input type="text" name="idCardNo" value="${RequestParameters.idCardNo!}" class="form-control" id="member_password" placeholder="身份证号">
              </p>
            </div>
          </div>
          <div class="form-group">
            <label for="member_password" class="col-sm-4 control-label">手机号</label>
            <div class="col-sm-8">
              <input type="text" name="mobile" value="${RequestParameters.mobile!}" class="form-control" id="member_password" placeholder="手机号">
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>
        <a href="javascript:$('#queryForm').submit();" class="btn btn-primary">保存</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
