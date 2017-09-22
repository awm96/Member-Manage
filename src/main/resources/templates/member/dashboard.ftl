<!DOCTYPE html>
<html lang="cn">
<head>
<#include "/common.ftl">
</head>

<body>
<#include "/member/header.ftl">
<div class="ch-container" style="padding: 0px 300px;">
  <div class="row">
    <div class="box col-md-6">
      <div class="box-inner">
        <div class="box-header well">
          <h2><i class="glyphicon glyphicon-info-sign"></i> 会员基本信息</h2>
          <div class="box-icon">
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i
                class="glyphicon glyphicon-remove"></i></a>
          </div>
        </div>
        <div class="box-content row">
          <div class="col-lg-7 col-md-12">
            <form class="form-horizontal">
              <div class="form-group">
                <label class="col-sm-4 control-label">姓名</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.name}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">身份证号</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.idCardNo}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">手机号</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.mobile!'--'}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">性别</label>
                <div class="col-sm-8">
                  <p class="form-control-static"><#if !(member.sex??)>--<#elseif member.sex == 0>
                    女<#else>男</#if></p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">生日</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.birthday!'--'}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">级别</label>
                <div class="col-sm-8">
                  <p class="form-control-static">
                  <#if member.level == 0>--<#elseif member.level == 1>
                    银牌会员<#elseif member.level == 2>金牌会员<#else>钻石会员</#if>
                  </p>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="box col-md-6">
      <div class="box-inner">
        <div class="box-header well">
          <h2><i class="glyphicon glyphicon-info-sign"></i> 储值消费金额</h2>
          <div class="box-icon">
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i
                class="glyphicon glyphicon-remove"></i></a>
          </div>
        </div>
        <div class="box-content row">
          <div class="col-lg-7 col-md-12">
            <form class="form-horizontal">
              <div class="form-group">
                <label class="col-sm-4 control-label">储值金额</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.storedAmount}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">消费金额</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.consumeAmount}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">积分金额</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.integralAmount}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">最后交易时间</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.lastTransTime!'--'}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">创建时间</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.createTime}</p>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-4 control-label">更新时间</label>
                <div class="col-sm-8">
                  <p class="form-control-static">${member.updateTime}</p>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="box col-md-12">
      <div class="box-inner">
        <div class="box-header well">
          <h2><i class="glyphicon glyphicon-info-sign"></i> 会员交易记录</h2>
          <div class="box-icon">
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i
                class="glyphicon glyphicon-remove"></i></a>
          </div>
        </div>
        <div class="box-content">
          <table class="table table-striped table-bordered responsive">
            <thead>
            <tr>
              <th><i class="glyphicon glyphicon-screenshot"></i> 主流水号</th>
              <th><i class="glyphicon glyphicon-tags"></i> 交易类型</th>
              <th><i class="glyphicon glyphicon-shopping-cart"></i> 金额</th>
              <th><i class="glyphicon glyphicon-calendar"></i> 交易时间</th>
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
                  <span class="label label-info">消费</span>
                <#elseif item.transType == 3>
                  <span class="label label-info">消费充正</span>
                <#elseif item.transType == 4>
                  <span class="label label-danger">积分</span>
                <#elseif item.transType == 5>
                  <span class="label label-danger">积分充正</span>
                </#if>
              </td>
              <td>${item.amount}</td>
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
  </div>
</div>
</body>
</html>
