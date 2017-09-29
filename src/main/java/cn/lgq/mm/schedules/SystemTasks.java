package cn.lgq.mm.schedules;

import cn.lgq.mm.service.BillService;
import cn.lgq.mm.util.DateUtils;
import java.sql.Timestamp;
import java.util.Date;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Created by Ligq on 2017/9/29.
 */
@Component
@Slf4j
public class SystemTasks {

  @Autowired
  private BillService billService;

  @Scheduled(cron = "${system.tasks.integralPresentTaskCron}")
  public void integralPresentTask() {
    try {
      Date current = new Date();
      Date preMonth = DateUtils.addMonths(current, -1);
      Timestamp start = new Timestamp(DateUtils.getFirstDayOfMonth(preMonth, true).getTime());
      Timestamp end = new Timestamp(DateUtils.getFirstDayOfMonth(current, true).getTime());
      billService.execIntegralPresent(start, end);
    } catch (Exception e) {
      log.error("积分赠送定时任务执行失败!", e);
    }
  }
}
