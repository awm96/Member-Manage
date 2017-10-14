<!DOCTYPE html>
<html lang="cn">
<head>
<#include "/common.ftl">
<#include "/manage/member_list_chosen.ftl"/>
<@memberListChosen selectEleId="refererId" memberList=memberList defaultNoSelect=true/>
<@memberListChosen selectEleId="q_refererId" memberList=memberList defaultNoSelect=true defaultSelectMemberId=RequestParameters.referrerId multiInstance=true/>
<script type="text/javascript">
    function showMemberDialog(memberId) {
      if (memberId) {
        var json = $("#member_" + memberId).attr("json");
        json = JSON.parse(json);
        $("#member_id").val(json.id);
        $("#member_name").val(json.name);
        $("#member_idCardNo").val(json.idCardNo);
        $("#member_mobile").val(json.mobile);
        $("#member_sex").val(json.sex);
        $("#member_birthday").val(json.birthday);
        $("#member_password").val("");
        $("#refererBar").hide();
      } else {
        $("#member_id").val("");
        $("#member_name").val("");
        $("#member_idCardNo").val("");
        $("#member_mobile").val("");
        $("#member_sex").val("");
        $("#member_birthday").val("");
        $("#member_password").val("${_Constants.DEFAULT_MEMBER_PASSWORD}");
        $("#refererBar").show();
      }
      $('#saveModal').modal('show');
    }
</script>
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
                    <a href="javascript:showMemberDialog(null)"><i class="glyphicon glyphicon-plus"></i> 新增会员</a>
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
                        <th><i class="glyphicon glyphicon-magnet"></i> 推荐人</th>
                        <th><i class="glyphicon glyphicon-calendar"></i> 推荐人数</th>
                        <th><i class="glyphicon glyphicon-hand-right"></i> 操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list page.resultList as item>
                    <tr id="member_${item.id}" json='${_ObjectMapper.writeValueAsString(item)}'>
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
                        <td>${item.referrerName!'--'}</td>
                        <td>${item.recommendNum!}</td>
                        <td>
                          <div class="btn-group" role="group" aria-label="...">
                            <button class="btn btn-primary btn-sm btn-round" onclick="showMemberDialog(${item.id})">修改会员</button>
                            <a class="btn btn-success btn-sm btn-round" href="${req.contextPath}/manage/bill/list?memberId=${item.id}">交易记录</a>
                          </div>
                        </td>
                    </tr>
                    <#else>
                    <tr><td colspan="10">还没有任何记录...</td></tr>
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
            <label class="col-sm-4 control-label">姓名</label>
            <div class="col-sm-8">
              <input type="text" name="name" value="${RequestParameters.name!}" class="form-control" placeholder="真实姓名" required>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label">身份证号</label>
            <div class="col-sm-8">
              <p class="form-control-static">
                <input type="text" name="idCardNo" value="${RequestParameters.idCardNo!}" class="form-control" placeholder="身份证号">
              </p>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label">手机号</label>
            <div class="col-sm-8">
              <input type="text" name="mobile" value="${RequestParameters.mobile!}" class="form-control" placeholder="手机号">
            </div>
          </div>
            <div id="refererBar" class="form-group">
                <label class="col-sm-4 control-label">推荐人</label>
                <div class="col-sm-8">
                    <select id="q_refererId" name="referrerId"></select>
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
<div class="modal fade" id="saveModal" tabindex="-1" role="dialog" aria-labelledby="saveModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h3>新增/修改会员</h3>
      </div>
      <div class="modal-body">
        <form id="saveForm" action="${req.contextPath}/manage/member/save" class="form-horizontal" method="post">
          <input type="hidden" name="id" id="member_id">
          <div class="form-group">
            <label for="member_name" class="col-sm-4 control-label">姓名</label>
            <div class="col-sm-8">
              <input type="text" name="name" class="form-control" id="member_name" placeholder="真实姓名" required>
            </div>
          </div>
          <div class="form-group">
            <label for="member_idCardNo" class="col-sm-4 control-label">身份证号</label>
            <div class="col-sm-8">
              <p class="form-control-static">
                <input type="text" name="idCardNo" class="form-control" id="member_idCardNo" placeholder="身份证号">
              </p>
            </div>
          </div>
          <div class="form-group">
            <label for="member_mobile" class="col-sm-4 control-label">手机号</label>
            <div class="col-sm-8">
              <input type="text" name="mobile" class="form-control" id="member_mobile" placeholder="手机号">
            </div>
          </div>
          <div class="form-group">
            <label for="member_password" class="col-sm-4 control-label">密码</label>
            <div class="col-sm-8">
              <a data-toggle="tooltip" title="默认密码:${_Constants.DEFAULT_MEMBER_PASSWORD}" href="#">
              <input type="password" name="password" class="form-control" id="member_password" placeholder="登陆密码，不修改请留空">
              </a>
            </div>
          </div>
          <div class="form-group">
            <label for="member_sex" class="col-sm-4 control-label">性别</label>
            <div class="col-sm-8">
              <select name="sex" id="member_sex" class="form-control">
                <option value="">--</option>
                <option value="0">女</option>
                <option value="1">男</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="member_birthday" class="col-sm-4 control-label">生日</label>
            <div class="col-sm-8">
              <input type="text" name="birthday" class="form-control datepicker" id="member_birthday" placeholder="生日">
            </div>
          </div>
          <div id="refererBar" class="form-group">
            <label class="col-sm-4 control-label">推荐人</label>
            <div class="col-sm-8">
              <select id="refererId" name="referrerId"></select>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>
        <a href="javascript:$('#saveForm').submit();" class="btn btn-primary">保存</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
