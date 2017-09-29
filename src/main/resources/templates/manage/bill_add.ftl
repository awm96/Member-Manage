<!DOCTYPE html>
<html lang="cn">
<head>
<#include "/common.ftl">
<#include "/manage/member_list_chosen.ftl"/>
<@memberListChosen selectEleId="memberId" memberList=memberList defaultSelectMemberId=RequestParameters.memberId/>
<script type="text/javascript">
  var submitTransType = ${RequestParameters.transType!"0"};
  var submitAmount = "${RequestParameters.amount!}";
  $(function(){
    $("#transType").val(submitTransType);
    $("#amount").val(submitAmount);
    reloadMemberAmountInfo($("#memberId").val());
  });
  function reloadMemberAmountInfo(memberId) {
    $.each(memberList, function(index, val) {
      if (memberId == val.id) {
        $("#storedAmount").text("¥" + val.storedAmount);
        $("#consumeAmount").text("¥" + val.consumeAmount);
        $("#integralAmount").text("¥" + val.integralAmount);
        return false;
      }
    });
  }
</script>
</head>

<body>
<#include "/manage/header.ftl">

<div class="ch-container">
    <div class="row">
        <#include '/manage/menu.ftl'/>
        <div id="content" class="col-lg-10 col-sm-10">
          <div class="box col-md-8">
            <div class="box-inner">
              <div class="box-header well">
                <h2><i class="glyphicon glyphicon-info-sign"></i> 发起新交易</h2>
                <div class="box-icon">
                  <a href="#" class="btn btn-minimize btn-round btn-default"><i class="glyphicon glyphicon-chevron-up"></i></a>
                  <a href="#" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
              </div>
              <div class="box-content">
                <#if Request[_Constants.ERROR_MSG_REQUEST_KEY]??>
                <div class="alert alert-danger">
                  <button type="button" class="close" data-dismiss="alert">&times;</button>
                  <strong>交易失败!</strong> ${Request[_Constants.ERROR_MSG_REQUEST_KEY]}
                </div>
                </#if>
                <form action="${req.contextPath}/manage/bill/add" method="POST">
                  <div class="form-group">
                    <label for="memberId">所属会员</label>
                    <select id="memberId" name="memberId" onchange="reloadMemberAmountInfo(this.value)"></select>
                  </div>
                  <div class="form-group">
                    <label for="transType">交易类型</label>
                    <select id="transType" name="transType" class="form-control">
                      <option value="0">储值充值</option>
                      <option value="4">消费支出</option>
                      <option value="8">积分支出</option>
                    </select>
                  </div>
                  <div class="form-group">
                    <label for="amount">交易金额</label>
                    <input type="text" id="amount" name="amount" class="form-control" placeholder="金额">
                  </div>
                  <button type="submit" class="btn btn-default">提交</button>
                </form>
              </div>
            </div>
          </div>
          <div class="box col-md-4">
            <div class="box-inner">
              <div class="box-header well">
                <h2><i class="glyphicon glyphicon-info-sign"></i> 提示信息</h2>
                <div class="box-icon">
                  <a href="#" class="btn btn-minimize btn-round btn-default"><i class="glyphicon glyphicon-chevron-up"></i></a>
                  <a href="#" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
              </div>
              <div class="box-content">
                <ul class="dashboard-list" style="padding: 0px">
                  <li>会员储值总额：<span id="storedAmount" class="label label-primary">¥0</span></li>
                  <li>会员消费余额：<span id="consumeAmount" class="label label-success">¥0</span></li>
                  <li>会员积分余额：<span id="integralAmount" class="label label-danger">¥0</span></li>
                  <#list storePresentRule?keys as key>
                  <li>
                    储值 <span id="integralAmount" class="label label-info">¥${key}</span>,
                    赠送 <span id="integralAmount" class="label label-warning">¥${storePresentRule[key]}</span>
                  </li>
                  </#list>
                </ul>
              </div>
            </div>
          </div>
        </div>
    </div>
</div>
</body>
</html>
