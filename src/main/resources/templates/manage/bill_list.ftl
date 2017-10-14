<!DOCTYPE html>
<html lang="cn">
<head>
<#include "/common.ftl">
<#include "/manage/member_list_chosen.ftl"/>
<@memberListChosen selectEleId="queryMemberId" memberList=memberList defaultNoSelect=true/>
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
                <h2><i class="glyphicon glyphicon-info-sign"></i> 交易列表</h2>
                <div class="box-icon">
                  <a href="#" class="btn btn-minimize btn-round btn-default"><i
                      class="glyphicon glyphicon-chevron-up"></i></a>
                  <a href="#" class="btn btn-close btn-round btn-default"><i
                      class="glyphicon glyphicon-remove"></i></a>
                </div>
              </div>
              <div class="box-content">
                <div>
                  <div style="display:inline-block; margin-top:10px;margin-bottom:10px;">
                    <a href="${req.contextPath}/manage/bill/add"><i class="glyphicon glyphicon-plus"></i> 发起新交易</a>
                    <a href="#" data-toggle="modal" data-target="#queryModal" style="padding-left: 30px;"><i class="glyphicon glyphicon-search"></i> 查找交易</a>
                  </div>
                </div>
                <table class="table table-striped table-bordered responsive">
                    <thead>
                      <tr>
                        <th><i class="glyphicon glyphicon-star-empty"></i> 流水ID</th>
                        <th><i class="glyphicon glyphicon-star"></i> 主流水ID</th>
                        <th><i class="glyphicon glyphicon-user"></i> 会员姓名</th>
                        <th><i class="glyphicon glyphicon-envelope"></i> 会员身份证</th>
                        <th><i class="glyphicon glyphicon-tags"></i> 交易类型</th>
                        <th><i class="glyphicon glyphicon-shopping-cart"></i> 金额</th>
                        <th><i class="glyphicon glyphicon-calendar"></i> 交易时间</th>
                        <th><i class="glyphicon glyphicon-pencil"></i> 操作员</th>
                      </tr>
                      </thead>
                    <tbody>
                    <#list page.resultList as item>
                    <tr>
                      <td>${item.id}</td>
                      <td>${item.masterId}</td>
                      <td>${item.memberName}</td>
                      <td><span class="label label-default">${item.memberIdCardNo}</span></td>
                      <td>
                        <#if item.transType == 0>
                          <span class="label label-primary">储值充值</span>
                        <#elseif item.transType == 1>
                          <span class="label label-warning">储值充值冲正</span>
                        <#elseif item.transType == 2>
                          <span class="label label-primary">消费充值</span>
                        <#elseif item.transType == 3>
                          <span class="label label-warning">消费充值冲正</span>
                        <#elseif item.transType == 4>
                          <span class="label label-success">消费支出</span>
                        <#elseif item.transType == 5>
                          <span class="label label-info">消费支出冲正</span>
                        <#elseif item.transType == 6>
                          <span class="label label-success">积分充值</span>
                        <#elseif item.transType == 7>
                          <span class="label label-info">积分充值冲正</span>
                        <#elseif item.transType == 8>
                          <span class="label label-danger">积分支出</span>
                        <#elseif item.transType == 9>
                          <span class="label label-default">积分支出冲正</span>
                        </#if>
                      </td>
                      <td>¥${item.amount}</td>
                      <td>${item.createTime}</td>
                      <td>${item.creatorName}</td>
                    </tr>
                    <#else>
                    <tr><td colspan="8">还没有任何记录...</td></tr>
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
        <form id="queryForm" action="${req.contextPath}/manage/bill/list" class="form-horizontal" method="post">
          <input type="hidden" name="pageNo">
          <div class="form-group">
            <label class="col-sm-4 control-label">主流水ID</label>
            <div class="col-sm-8">
              <input type="text" name="masterId" value="${RequestParameters.masterId!}" class="form-control" placeholder="主流水号">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label">所属会员</label>
            <div class="col-sm-8">
              <select id="queryMemberId" name="memberId"></select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label">交易类型</label>
            <div class="col-sm-8">
              <select name="transType" class="form-control">
                <option value="">--</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="0")?string('selected','')} value="0">储值充值</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="1")?string('selected','')} value="1">储值充值冲正</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="2")?string('selected','')} value="2">消费充值</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="3")?string('selected','')} value="3">消费充值冲正</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="4")?string('selected','')} value="4">消费支出</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="5")?string('selected','')} value="5">消费支出冲正</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="6")?string('selected','')} value="6">积分充值</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="7")?string('selected','')} value="7">积分充值冲正</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="8")?string('selected','')} value="8">积分支出</option>
                <option ${(RequestParameters.transType?? && RequestParameters.transType=="9")?string('selected','')} value="9">积分支出冲正</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label">交易时间起始</label>
            <div class="col-sm-8">
              <input type="text" name="createTimeStart" value="${RequestParameters.createTimeStart!}" class="form-control datepicker" placeholder="年-月-日格式">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label">交易时间终止</label>
            <div class="col-sm-8">
              <input type="text" name="createTimeEnd" value="${RequestParameters.createTimeEnd!}" class="form-control datepicker" placeholder="年-月-日格式">
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>
        <a href="javascript:$('#queryForm').submit();" class="btn btn-primary">查询</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
