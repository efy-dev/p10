/**
 * Created by Administrator on 2015/11/18 0018.
 */
function show_time(endtime){
    var time_start = new Date().getTime(); //设定当前时间
    var time_end =  new Date(endtime).getTime(); //设定目标时间
    // 计算时间差
    var time_distance = time_end - time_start;
    // 时
    var int_hour = Math.floor(time_distance/3600000)
    time_distance -= int_hour * 3600000;
    // 分
    var int_minute = Math.floor(time_distance/60000)
    time_distance -= int_minute * 60000;
    // 秒
    var int_second = Math.floor(time_distance/1000)
    // 时分秒为单数时、前面加零
    if(int_hour < 10){
        int_hour = "0" + int_hour;
    }
    if(int_minute < 10){
        int_minute = "0" + int_minute;
    }
    if(int_second < 10){
        int_second = "0" + int_second;
    }
    // 显示时间
    $("#time_h").html(int_hour);
    $("#time_m").html(int_minute);
    $("#time_s").html(int_second);
    // 设置定时器
    setTimeout("show_time(endtime)",1000);
}