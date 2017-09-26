<!DOCTYPE html>
<html lang="cn">
<head>
<#include "/common.ftl">
<script type="text/javascript">
    function showAdminDialog(adminId) {
      if (adminId) {
        var json = $("#admin_" + adminId).attr("json");
        json = JSON.parse(json);
        $("#admin_id").val(json.id);
        $("#admin_name").val(json.name);
        $("#admin_type").val(json.type);
      } else {
        $("#admin_id").val("");
        $("#admin_name").val("");
        $("#admin_type").val("0");
      }
      $('#saveModal').modal('show');
    }
    function deleteAdmin(adminId) {
      location.href = "${req.contextPath}/manage/admin/delete?adminId=" + adminId;
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
                <h2><i class="glyphicon glyphicon-info-sign"></i> 管理员列表</h2>
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
                    <a href="javascript:showAdminDialog(null)"><i class="glyphicon glyphicon-plus"></i> 新增管理员</a>
                    <a href="#" data-toggle="modal" data-target="#queryModal" style="padding-left: 30px;"><i class="glyphicon glyphicon-search"></i> 查找管理员</a>
                  </div>
                </div>
                <table class="table table-striped table-bordered responsive">
                    <thead>
                    <tr>
                        <th><i class="glyphicon glyphicon-user"></i> 姓名</th>
                        <th><i class="glyphicon glyphicon-tags"></i> 类型</th>
                        <th><i class="glyphicon glyphicon-calendar"></i> 创建时间</th>
                        <th><i class="glyphicon glyphicon-calendar"></i> 更新时间</th>
                      <th><i class="glyphicon glyphicon-hand-right"></i> 操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list page.resultList as item>
                    <tr id="admin_${item.id}" json='${_ObjectMapper.writeValueAsString(item)}'>
                        <td>${item.name}</td>
                        <td>
                            <#if item.type == 0>
                                <span class="label label-success">普通管理员</span>
                            <#elseif item.type == 1>
                                <span class="label label-danger">超级管理员</span>
                            </#if>
                        </td>
                        <td>${item.createTime}</td>
                        <td>${item.updateTime}</td>
                        <td>
                          <div class="btn-group" role="group" aria-label="...">
                            <button class="btn btn-primary btn-sm btn-round" onclick="showAdminDialog(${item.id})">修改</button>
                            <button class="btn btn-success btn-sm btn-round" onclick="deleteAdmin(${item.id})">删除</button>
                          </div>
                        </td>
                    </tr>
                    <#else>
                    <tr><td colspan="5">还没有任何记录...</td></tr>
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
        <form id="queryForm" action="${req.contextPath}/manage/admin/list" class="form-horizontal" method="post">
          <input type="hidden" name="pageNo">
          <div class="form-group">
            <label class="col-sm-4 control-label">名称</label>
            <div class="col-sm-8">
              <input type="text" name="name" value="${RequestParameters.name!}" class="form-control" placeholder="管理员名称" required>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label">类型</label>
            <div class="col-sm-8">
              <select name="type" class="form-control">
                <option <#if !(RequestParameters.type??)>selected</#if> value="">--</option>
                <option <#if RequestParameters.type?? && RequestParameters.type == "0">selected</#if> value="0">普通管理员</option>
                <option <#if RequestParameters.type?? && RequestParameters.type == "1">selected</#if> value="1">超级管理员</option>
              </select>
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
<div class="modal fade" id="saveModal" tabindex="-1" role="dialog" aria-labelledby="saveModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h3>新增/修改管理员</h3>
      </div>
      <div class="modal-body">
        <form id="saveForm" action="${req.contextPath}/manage/admin/save" class="form-horizontal" method="post">
          <input type="hidden" name="id" id="admin_id">
          <div class="form-group">
            <label for="admin_name" class="col-sm-4 control-label">名称</label>
            <div class="col-sm-8">
              <input type="text" name="name" class="form-control" id="admin_name" placeholder="管理员名称" required>
            </div>
          </div>
          <div class="form-group">
            <label for="admin_password" class="col-sm-4 control-label">密码</label>
            <div class="col-sm-8">
              <input type="password" name="password" class="form-control" id="admin_password" placeholder="密码">
            </div>
          </div>
          <div class="form-group">
            <label for="admin_type" class="col-sm-4 control-label">类型</label>
            <div class="col-sm-8">
              <select name="type" id="admin_type" class="form-control">
                <option value="0">普通管理员</option>
                <option value="1">超级管理员</option>
              </select>
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
