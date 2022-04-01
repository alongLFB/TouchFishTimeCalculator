//
//  main.swift
//  TouchFishTimeCalculator
//
//  Created by lialong on 30/03/2022.
//

import Foundation

private let timeZoneString = "Asia/Shanghai"
private let timeZoneString2 = "Asia/Dubai"

func getDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
    var dateComponents = DateComponents(
        calendar: Calendar(identifier: .gregorian),
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second
    )
    let timeZone = TimeZone(identifier: timeZoneString) ?? TimeZone.current
    dateComponents.timeZone = timeZone
    return dateComponents.date
}

func dayFromDate1WithDate2(date1: Date, date2: Date) -> (day: Int, hour:Int) {
    var calendar = Calendar.current
//    let timeZone = TimeZone(identifier: timeZoneString) ?? TimeZone.current
//    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.day, .hour], from: date1, to: date2)
    return (components.day ?? -1, components.hour ?? -1)
}

func dayFromNowWithDate(date: Date) -> (day: Int, hour:Int) {
    let date1 = Date.now
    return dayFromDate1WithDate2(date1: date1, date2: date)
}

let formatter = DateFormatter()
formatter.dateFormat = "yyyy年MM月dd日"
let todayString = formatter.string(from: Date.now)

let calendar: Calendar = Calendar(identifier: .gregorian)
var comps: DateComponents = DateComponents()
comps = calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: Date())

let weekDay = comps.weekday! - 1

let array = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]

let weekDayString = array[weekDay]

var toSat = 0
let Sat = 6
if weekDay < Sat {
    toSat = Sat - weekDay
} else {
    toSat = Sat - weekDay + 7
}

let currentYear =  comps.year!
let currentMonth = comps.month!

var totalDaysThisMonth = 31
let month = currentMonth == 12 ? 1 : currentMonth + 1
let year = currentMonth == 12 ? currentYear + 1 : currentYear
let day = 1
let data1 = getDate(year: currentYear, month: currentMonth, day: day)
let data2 = getDate(year: year, month: month, day: day)
totalDaysThisMonth = dayFromDate1WithDate2(date1: data1!, date2: data2!).day

func getTodayToDay(day: Int) -> Int {
    if let today = comps.day {
        return (today > day) ? (totalDaysThisMonth - today + day) : (day - today)
    }
    return -1
}

let monthEnd = getTodayToDay(day: totalDaysThisMonth)
let five = getTodayToDay(day: 5)
let ten = getTodayToDay(day: 10)
let fifteen = getTodayToDay(day: 15)
let twenty = getTodayToDay(day: 20)

/*
 一、元旦：2022年1月1日至3日放假，共3天。

 二、春节：1月31日至2月6日放假调休，共7天。1月29日（星期六）、1月30日（星期日）上班。

 三、清明节：4月3日至5日放假调休，共3天。4月2日（星期六）上班。

 四、劳动节：4月30日至5月4日放假调休，共5天。4月24日（星期日）、5月7日（星期六）上班。

 五、端午节：6月3日至5日放假，共3天。

 六、中秋节：9月10日至12日放假，共3天。

 七、国庆节：10月1日至7日放假调休，共7天。10月8日（星期六）、10月9日（星期日）上班。
 */

let nowDate = Date.now
// 清明 Qingming Festival
let qingming_Festival = getDate(year: 2022, month: 4, day: 3)
let qingming_Festival_components_day = dayFromNowWithDate(date: qingming_Festival!)

// 五一劳动节 Labor Day
let labor_Day = getDate(year: 2022, month: 5, day: 1)
let labor_Day_components_day = dayFromNowWithDate(date: labor_Day!)

// 端午 Dragon Boat Festival
let dragon_Boat_Festival = LunarToSolar.convert(year: 2022, month: 5, day: 5)
let dragon_Boat_Festival_Date = getDate(year: dragon_Boat_Festival.year, month: dragon_Boat_Festival.month, day: dragon_Boat_Festival.day)
let dragon_Boat_Festival_Date_day = dayFromNowWithDate(date: dragon_Boat_Festival_Date!)

// 中秋 Mid-Moon Festival
let mid_Moon_Festival = LunarToSolar.convert(year: 2022, month: 8, day: 15)
let mid_Moon_Festival_Date = getDate(year: mid_Moon_Festival.year, month: mid_Moon_Festival.month, day: mid_Moon_Festival.day)
let mid_Moon_Festival_Date_day = dayFromNowWithDate(date: mid_Moon_Festival_Date!)

// 国庆 National Day
let national_Date = getDate(year: 2022, month: 10, day: 1)
let national_Date_day = dayFromNowWithDate(date: national_Date!)

// 元旦 New Year’s Day
let newYearDate = getDate(year: 2023, month: 1, day: 1)
let newYearDate_day = dayFromNowWithDate(date: newYearDate!)

// 春节 Spring Festival
let spring_Festival = LunarToSolar.convert(year: 2022, month: 12, day: 30)
let Spring_Festival_Date = getDate(year: spring_Festival.year, month: spring_Festival.month, day: spring_Festival.day)
let Spring_Festival_Date_day = dayFromNowWithDate(date: Spring_Festival_Date!)

let thisNewYearDate = getDate(year: 2022, month: 1, day: 1)
let days = dayFromDate1WithDate2(date1: thisNewYearDate!, date2: nowDate)

print("""
 【摸鱼办】提醒您:
 今天是\(todayString)，\(weekDayString)，（时区\(timeZoneString)）你好，摸鱼人!工作再忙，一定不要忘记摸鱼哦!有事没事起身去茶水间，去厕所，去走廊走走，去找同事聊聊八卦别老在工位上坐着，钱是老板的但命是自己的。
 温馨提示：
 2022年 已经过去 \(days.day) 天\(days.hour)小时
 距离【月底发工资】：\(monthEnd)天
 距离【05号发工资】：\(five)天
 距离【10号发工资】：\(ten)天
 距离【15号发工资】：\(fifteen)天
 距离【20号发工资】：\(twenty)天
 距离【周六】还有\(toSat)天
 距离【清明】还有\(qingming_Festival_components_day.day)天\(qingming_Festival_components_day.hour)小时。清明节：4月3日至5日放假调休，共3天。4月2日（星期六）上班。
 距离【五一】还有\(labor_Day_components_day.day)天\(labor_Day_components_day.hour)小时。劳动节：4月30日至5月4日放假调休，共5天。4月24日（星期日）、5月7日（星期六）上班。
 距离【端午】还有\(dragon_Boat_Festival_Date_day.day)天\(dragon_Boat_Festival_Date_day.hour)小时。端午节：6月3日至5日放假，共3天。
 距离【中秋】还有\(mid_Moon_Festival_Date_day.day)天\(mid_Moon_Festival_Date_day.hour)小时。中秋节：9月10日至12日放假，共3天。
 距离【国庆】还有\(national_Date_day.day)天\(national_Date_day.hour)小时。国庆节：10月1日至7日放假调休，共7天。
 距离【元旦】还有\(newYearDate_day.day)天\(newYearDate_day.hour)小时。
 距离【春节】还有\(Spring_Festival_Date_day.day)天\(Spring_Festival_Date_day.hour)小时。
""")

