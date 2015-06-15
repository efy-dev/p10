package com.ming800.core.util;

import org.springframework.context.i18n.LocaleContextHolder;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtil {

    private static final String BUNDLE_KEY = "ApplicationResources";
    private static SimpleDateFormat datetimeFormat = new SimpleDateFormat(
            "yyyy-MM-dd HH:mm:ss", java.util.Locale.US);
    private static SimpleDateFormat formatMinute = new SimpleDateFormat(
            "yyyy-MM-dd HH:mm", java.util.Locale.US);
    private static SimpleDateFormat dateFormat = new SimpleDateFormat(
            "yyyy-MM-dd", java.util.Locale.US);
    private static SimpleDateFormat dateFormatMonth = new SimpleDateFormat(
            "yyyy-MM", java.util.Locale.US);
    private static SimpleDateFormat dateFormatMonthDay = new SimpleDateFormat(
            "MM-dd", java.util.Locale.US);
    private static SimpleDateFormat dateAndWeekFormat = new SimpleDateFormat(
            "yyyy-MM-dd E", java.util.Locale.US);
    private static SimpleDateFormat YRAndWeekFormat = new SimpleDateFormat(
            "MM-dd E", java.util.Locale.US);
    private static SimpleDateFormat datetimeFormatYM = new SimpleDateFormat(
            "yyyy/MM", java.util.Locale.US);
    private static SimpleDateFormat dateFormatNyr = new SimpleDateFormat(
            "yyyy年M月d日", java.util.Locale.US);
    private static SimpleDateFormat simpleformat = new SimpleDateFormat(
            "yyyy年M月d日 E", java.util.Locale.CHINA);
    private static SimpleDateFormat dateFormatSimple = new SimpleDateFormat(
            "yyyyMMdd", java.util.Locale.US);

    public static List<Date> getDateList(Calendar from, Calendar to) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(from.getTime());
        List<Date> dateList = new ArrayList<Date>();
        while (compareDate(calendar, to) <= 0) {
            dateList.add(calendar.getTime());
            calendar.add(Calendar.DAY_OF_MONTH, 1);
        }
        return dateList;
    }

    public static void sortTextDate(List<String> dateList) {
        Collections.sort(dateList, new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                return compareDate(o1, o2);
            }
        });
    }

    public static void sort(List<Date> dateList) {
        Collections.sort(dateList, new Comparator<Date>() {
            @Override
            public int compare(Date o1, Date o2) {
                return compareDate(o1, o2);
            }
        });
    }

    public static int compareDate(String d1, String d2) {
        Calendar c1 = Calendar.getInstance();
        c1.setTime(parseDate(d1));
        Calendar c2 = Calendar.getInstance();
        c2.setTime(parseDate(d2));
        return compareDate(c1, c2);
    }

    public static int compareDateMinute(String d1, String d2) {
        Calendar c1 = Calendar.getInstance();
        c1.setTime(parseDateTimeMinute(d1));
        Calendar c2 = Calendar.getInstance();
        c2.setTime(parseDateTimeMinute(d2));
        return compareDateTime(c1, c2);
    }

    public static int compareDate(Date d1, Date d2) {
        Calendar c1 = Calendar.getInstance();
        c1.setTime(d1);
        Calendar c2 = Calendar.getInstance();
        c2.setTime(d2);
        return compareDate(c1, c2);
    }

    public static int compareDate(Calendar c1, Date d2) {
        Calendar c2 = Calendar.getInstance();
        c2.setTime(d2);
        return compareDate(c1, c2);
    }

    public static int compareDate(Date d1, Calendar c2) {
        Calendar c1 = Calendar.getInstance();
        c1.setTime(d1);
        return compareDate(c1, c2);
    }

    public static int compareDate(Calendar c1, Calendar c2) {
        int yearC1 = c1.get(Calendar.YEAR);
        int yearC2 = c2.get(Calendar.YEAR);
        if (yearC1 == yearC2) {
            int monthC1 = c1.get(Calendar.MONTH);
            int monthC2 = c2.get(Calendar.MONTH);
            if (monthC1 == monthC2) {
                int dayC1 = c1.get(Calendar.DAY_OF_MONTH);
                int dayC2 = c2.get(Calendar.DAY_OF_MONTH);
                if (dayC1 == dayC2) {
                    return 0;
                }
                return dayC1 > dayC2 ? 1 : -1;
            }
            return monthC1 > monthC2 ? 1 : -1;
        }
        return yearC1 > yearC2 ? 1 : -1;
    }

    public static int compareDateTime(Calendar c1, Calendar c2) {
        int yearC1 = c1.get(Calendar.YEAR);
        int yearC2 = c2.get(Calendar.YEAR);
        if (yearC1 == yearC2) {
            int monthC1 = c1.get(Calendar.MONTH);
            int monthC2 = c2.get(Calendar.MONTH);
            if (monthC1 == monthC2) {
                int dayC1 = c1.get(Calendar.DAY_OF_MONTH);
                int dayC2 = c2.get(Calendar.DAY_OF_MONTH);
                if (dayC1 == dayC2) {
                    int hourC1 = c1.get(Calendar.HOUR_OF_DAY);
                    int hourC2 = c2.get(Calendar.HOUR_OF_DAY);
                    if (hourC1 == hourC2) {
                        int minuteC1 = c1.get(Calendar.MINUTE);
                        int minuteC2 = c1.get(Calendar.MINUTE);
                        if (minuteC1 == minuteC2) {
                            int secondC1 = c1.get(Calendar.SECOND);
                            int secondC2 = c1.get(Calendar.SECOND);
                            if (secondC1 == secondC2) {
                                return 0;
                            }
                            return secondC1 > secondC2 ? 1 : -1;
                        }
                        return minuteC1 > minuteC2 ? 1 : -1;
                    }
                    return hourC1 > hourC2 ? 1 : -1;
                }
                return dayC1 > dayC2 ? 1 : -1;
            }
            return monthC1 > monthC2 ? 1 : -1;
        }
        return yearC1 > yearC2 ? 1 : -1;
    }

    public static String getCurrentDateTime() {
        Date now = new Date();
        return formatDateTime(now);
    }

    public static String getCurrentDate() {
        Date now = new Date();
        return formatDate(now);
    }

    public static Date parseDateTimeMinute(final String str) {
        Date date = null;
        try {
            date = formatMinute.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static Date parseDate(final String str) {
        Date date = null;
        try {
            date = dateFormat.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static Date parseAllDate(final String str) {
        Date date = null;
        try {
            if (str.length() == 10) {
                date = dateFormat.parse(str);
            } else if (str.length() == 16) {
                date = formatMinute.parse(str);
            } else {
                date = datetimeFormat.parse(str);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static String formatDateTime(final java.util.Date datetime) {
        return datetimeFormat.format(datetime);
    }

    public static String formatDateTime(final long datetime) {
        return datetimeFormat.format(new Date(datetime));
    }

    public static String formatDate(final java.util.Date date) {
        return dateFormat.format(date);
    }

    public static String formatDateMonthDay(final java.util.Date date) {
        return dateFormatMonthDay.format(date);
    }

    public static String formatYRDate(final java.util.Date date) {
        return YRAndWeekFormat.format(date);
    }

    public static String formatDateWeek(final java.util.Date date) {
        return dateAndWeekFormat.format(date);
    }

    public static String formatDateSimply(final java.util.Date date) {
        return dateFormatSimple.format(date);
    }

    public static int formatDateToNum(Date date) {
        return Integer.parseInt(formatDate(date).replace("-", ""));
    }

    public static int formatDateToNum(Calendar date) {
        return formatDateToNum(date.getTime());
    }

    public static String formatDateTimeYM(final long datetime) {
        return datetimeFormatYM.format(new Date(datetime));
    }

    public static String formatDateMinute2(final long datetime) {
        return formatMinute.format(new Date(datetime));
    }

    public static String formatDateMinute(Date datetime) {
        return formatMinute.format(datetime);
    }

    public static String formatDateDay(final long date) {
        return dateFormat.format(new Date(date));
    }

    public static long parseLongMinute(String date) {
        long time = 0;
        try {
            time = formatMinute.parse(date).getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return time;
    }

    public static List<String> getDateList(Date beginDate, Date endDate, String type) {
        List<String> dateList = new ArrayList();

        Calendar calBegin = Calendar.getInstance();
        Calendar calEnd = Calendar.getInstance();
        calBegin.setTime(beginDate);
        calEnd.setTime(endDate);

        String tempCalBegin = null;
        String tempCalEnd = null;
        if (type.equals("date_day")) {
            tempCalBegin = dateFormat.format(calBegin.getTime());
            tempCalEnd = dateFormat.format(calEnd.getTime());
            dateList.add(dateFormat.format(beginDate));
        } else {
            tempCalBegin = dateFormatMonth.format(calBegin.getTime());
            tempCalEnd = dateFormatMonth.format(calEnd.getTime());
            dateList.add(dateFormatMonth.format(beginDate));
        }

        if (type.equals("date_day")) {
            while (tempCalEnd.compareTo(tempCalBegin) > 0) {
                calBegin.add(Calendar.DAY_OF_MONTH, 1);
                tempCalBegin = dateFormat.format(calBegin.getTime());
                dateList.add(tempCalBegin);
            }
        } else {
            while (tempCalEnd.compareTo(tempCalBegin) > 0) {
                calBegin.add(Calendar.MONTH, 1);
                tempCalBegin = dateFormatMonth.format(calBegin.getTime());
                dateList.add(tempCalBegin);
            }
        }

        /*// 测试此日期是否在指定日期之后
        while (endDate.after(calBegin.getTime())) {
            // 根据日历的规则，为给定的日历字段添加或减去指定的时间量
            if (type.equals("date_day")) {
                calBegin.add(Calendar.DAY_OF_MONTH, 1);
                dateList.add(dateFormat.format(calBegin.getTime()));
            } else {
                calBegin.add(Calendar.MONTH, 1);
                dateList.add(dateFormatMonth.format(calBegin.getTime()));
            }
        }*/

        return dateList;
    }

    public static long parseLongDay(String date) {
        long time = 0;
        try {
            time = dateFormat.parse(date).getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return time;
    }

    public static String getNowDateTime(String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date now = new Date();
        return sdf.format(now);
    }

    public static int getLastDateForDateTime(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int month = calendar.get(Calendar.MONTH);
        int year = calendar.get(Calendar.YEAR);
        int[] days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
            days[1] = days[1] + 1;
        }
        return days[month];
    }

    public static int getWeeksOfMonthForDateTime(Date date) {
        int days = getLastDateForDateTime(date);
        String format = formatDate(date);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(parseDate(format.substring(0, format.lastIndexOf("-")) + days));
        return calendar.get(Calendar.WEEK_OF_MONTH);
    }

    public static int getWeeksOfMonth(String date) {
        int days = getLastDateForDateTime(parseDate(date.split("-").length < 3 ? date + "-01" : date));
        Calendar calendar = Calendar.getInstance();
        if (date.split("-").length > 2) {
            date = date.substring(0, date.lastIndexOf("-") - 1);
        }
        calendar.setTime(parseDate(date + "-" + days));
        return calendar.get(Calendar.WEEK_OF_MONTH);
    }

    public static String getDate(Date date) {
        SimpleDateFormat df;
        if (date != null) {
            df = new SimpleDateFormat(getDatePattern());
            return df.format(date);
        }
        return "";
    }

    public static String getDatePattern() {
        Locale locale = LocaleContextHolder.getLocale();
        String defaultDatePattern;
        try {
            defaultDatePattern = ResourceBundle.getBundle(BUNDLE_KEY,
                    locale).getString("date.format");
        } catch (MissingResourceException mse) {
            defaultDatePattern = "MM/dd/yyyy";
        }

        return defaultDatePattern;
    }

    public static String getDate() {
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1;
        int day = cal.get(Calendar.DAY_OF_MONTH);
        return year + "-" + month + "-" + day;
    }

    public static Date parseDateTime(String str) {
        Date date = null;
        try {
            date = datetimeFormat.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static long parseLongTime(String date) {
        long time = 0;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            time = format.parse(date).getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return time;
    }

    public static String getNowTime(String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date now = new Date();
        return sdf.format(now);
    }

    public static String formatDateNyr(final long date) {
        String str = dateFormatNyr.format(new Date(date));
        return str;
    }

    public static String getDateTimePattern() {
        return DateUtil.getDatePattern() + " HH:mm:ss.S";
    }

    public static Date getSimpleCurrentDate() {
        return new Date();
    }

    public static String getCurrentCalendarString() {
        return simpleformat.format(new Date());
    }

    public static String getFirstDayOfCurrentMonth() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DATE, 1);
        return formatDate(cal.getTime());
    }

    public static Date addOrSubDays(Date date, int days, int type) {
        Date d = new Date();
        if (date != null) d = date;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String dateStr = "";
        if (type == 0) dateStr = df.format(new Date(d.getTime() - (long) days * 24 * 60 * 60 * 1000));
        if (type == 1) dateStr = df.format(new Date(d.getTime() + (long) days * 24 * 60 * 60 * 1000));
        try {
            return dateFormat.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String getDayOfPrivousMonth() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) - 1);
        return formatDate(cal.getTime());
    }

    public static String getDayOfNextMonth(String date) {
        String dt[] = date.split("-");
        int month = Integer.parseInt(dt[1]);
        int year = Integer.parseInt(dt[0]) + month / 12;
        month = month % 12 + 1;
        return year + "-" + month + "-" + dt[2];
    }

    public static String getLastDayOfMonth(String date) {
        String dt[] = date.split("-");
        int year = Integer.parseInt(dt[0]);
        int month = Integer.parseInt(dt[1]);
        int days[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {
            days[1] = 29;
        }
        return year + "-" + month + "-" + days[month - 1];
    }

    public static int distanceBetweenDays(Date date1, Date date2) {
        long date_long1 = date1.getTime();
        long date_long2 = date2.getTime();
        if (date_long1 <= date_long2) {
            return (int) ((date_long2 - date_long1) / 1000 / 60 / 60 / 24);
        }
        return 0;
    }
}
