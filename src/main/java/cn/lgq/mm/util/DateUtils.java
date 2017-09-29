package cn.lgq.mm.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DateUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(DateUtils.class);
	public static final DateFormat SHORT = new SimpleDateFormat("yyyy-MM-dd");
	public static final DateFormat MIDDLE = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public static final DateFormat LONG = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final DateFormat MILLISECOND = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
	
	public enum Format {
		SHORT(DateUtils.SHORT),
		MIDDLE(DateUtils.MIDDLE),
		LONG(DateUtils.LONG),
		MILLISECOND(DateUtils.MILLISECOND);
		private DateFormat df;
		private Format(DateFormat df){
			this.df = df;
		}
	}

	public static Timestamp nowTimestamp(){
		return new Timestamp(System.currentTimeMillis());
	}
	
	public static Date nowDate(){
		return new Date();
	}
	
	public static Timestamp getTimestamp(String time, Format format){
		return new Timestamp(getDate(time, format).getTime());
	}
	
	public static Timestamp getTimestamp(String time, String format){
		return new Timestamp(getDate(time, format).getTime());
	}
	
	public static String getDate(Date date, Format format){
		return format.df.format(date);
	}
	
	public static String getDate(Date date, String format){
		return new SimpleDateFormat(format).format(date);
	}
	
	public static Date getDate(String date, Format format){
		try {
			return format.df.parse(date);
		} catch (ParseException e) {
			logger.error("DateFormat parse Exception!", e);
			return null;
		}
	}
	
	public static Date getDate(String date, String format){
		try {
			return new SimpleDateFormat(format).parse(date);
		} catch (ParseException e) {
			logger.error("DateFormat parse Exception!", e);
			return null;
		}
	}
	
	public static Date addDays(Date date, int days){
		return org.apache.commons.lang3.time.DateUtils.addDays(date, days);
	}

	public static Date addMonths(Date date, int months){
		return org.apache.commons.lang3.time.DateUtils.addMonths(date, months);
	}

	public static Date addYears(Date date, int years){
		return org.apache.commons.lang3.time.DateUtils.addYears(date, years);
	}
	
	public static int getWeekOfYear(Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.WEEK_OF_YEAR);
	}
	
	public static int getYear(Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.YEAR);
	}
	
	public static int getMonth(Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.MONTH) + 1;
	}
	
	public static Date getFirstDayOfMonth(Date date, boolean truncate){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		if (truncate)
			calendar = truncate(calendar);
		return calendar.getTime();
	}
	
	public static Date getLastDayOfMonth(Date date, boolean truncate){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		if (truncate)
			calendar = truncate(calendar);
		return calendar.getTime();
	}

	public static String getTimeDuration(long millseconds) {
		return org.apache.commons.lang3.time.DurationFormatUtils.formatDurationHMS(millseconds);
	}

	public static int getDaysBetween(Date start, Date end) {
		int days = (int) ((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24));
		return days;
	}

	public static String getTimeDuration(long millseconds, String format) {
		return org.apache.commons.lang3.time.DurationFormatUtils.formatDuration(millseconds, format);
	}

	public static Date truncate(Date date) {
		return org.apache.commons.lang3.time.DateUtils.truncate(date, Calendar.DAY_OF_MONTH);
	}

	public static Calendar truncate(Calendar date) {
		return org.apache.commons.lang3.time.DateUtils.truncate(date, Calendar.DAY_OF_MONTH);
	}
}
