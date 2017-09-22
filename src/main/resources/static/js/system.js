$(document).ready(function(){

  //datepicker
  $('.datepicker').datepicker({
    showSecond: false,
    dateFormat:'yy-mm-dd'
  });

  //datetimepicker
  $('.datetimepicker').datetimepicker({
    showSecond: true,
    dateFormat:'yy-mm-dd',
    timeFormat: 'hh:mm:ss'
  });
});