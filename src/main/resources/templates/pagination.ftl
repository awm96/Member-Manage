<#--
  分页栏创建器，需要传入query form id或query url
  pageNo: 当前页码
  totalPage: 总的页数
  totalRows: 总的记录数
  queryFormId: 当列表使用条件查询时，传入query form id, 否则不传该参数
  queryUrl: 当列表未使用条件查询时，传入query url, 否则不传该参数
-->
<#macro pagination pageNo totalPage totalRows queryFormId="null" queryUrl="null">
<#assign maxPageNum = 9/>
<#assign halfPageNum = (maxPageNum - 1) / 2/>
<#assign startPageNo = pageNo - halfPageNum/>
<#if startPageNo < 1>
  <#assign startPageNo = 1/>
<#elseif pageNo + halfPageNum gt totalPage>
  <#assign startPageNo = totalPage - maxPageNum + 1/>
  <#if startPageNo < 1>
    <#assign startPageNo = 1/>
  </#if>
</#if>
<script type="text/javascript">
  function gotoPage(pageNo) {
  <#if queryFormId != 'null'>
      $("#${queryFormId}").find(":hidden[name='pageNo']").val(pageNo);
      $("#${queryFormId}").submit();
  </#if>
  <#if queryUrl != 'null'>
      window.location.href='${queryUrl}?pageNo=' + pageNo;
  </#if>
  }
</script>
<nav style="text-align: center;">
  <ul class="pagination">
    <li><a>共 <span class="badge">${totalPage}</span> 页</a></li>
    <#if pageNo gt 1>
    <li><a href="javascript:gotoPage(${pageNo - 1})">&laquo;</a></li>
    <#else>
    <li class="disabled"><span>&laquo;</span></li>
    </#if>
    <#if totalPage < startPageNo + maxPageNum - 1>
      <#assign endIdx = totalPage/>
    <#else>
      <#assign endIdx = startPageNo + maxPageNum - 1/>
    </#if>
    <#list startPageNo..endIdx as i>
    <#if i == pageNo>
    <li class="active"><span>${i}</span></li>
    <#else>
    <li><a href="javascript:gotoPage(${i})">${i}</a></li>
    </#if>
    </#list>
    <#if pageNo < totalPage>
    <li><a href="javascript:gotoPage(${pageNo + 1})">&raquo;</a></li>
    <#else>
    <li class="disabled"><span>&raquo;</span></li>
    </#if>
    <li><a>总计 <span class="badge">${totalRows}</span> 条记录</a></li>
  </ul>
</nav>
</#macro>