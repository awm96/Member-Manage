<#--
  全量会员chosen插件创建器，使用jquery初始化，页面必须提供一个select标签id
  selectEleId: 页面用来绑定chosen的select标签id
  memberList: 会员列表
  defaultNoSelect: 是否默认不选中任何项
-->
<#macro memberListChosen selectEleId memberList defaultNoSelect=false defaultSelectMemberId="0" multiInstance=false>
<script type="text/javascript">
    <#if !multiInstance>
    var memberList = JSON.parse("${_ObjectMapper.writeValueAsString(memberList)?json_string}");
    </#if>
    $(function(){
        <#if defaultNoSelect>
        $("#${selectEleId}").attr("data-placeholder", "--");
        $("#${selectEleId}").append('<option value=""></option>');
        </#if>
        $.each(memberList, function(index, val) {
          var opt = $("<option></option>");
          opt.attr("value", val.id);
          opt.text(val.name + " " + val.idCardNo + (val.mobile ? " " + val.mobile : ""));
          if (${defaultSelectMemberId} == val.id)
            opt.attr("selected", true);
          $("#${selectEleId}").append(opt);
        });
        $("#${selectEleId}").chosen({width: "100%", no_results_text: "没有匹配的会员信息!"<#if defaultNoSelect>, allow_single_deselect: true</#if>});
    });
</script>
</#macro>