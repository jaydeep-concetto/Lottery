//
//  Data+Extension.swift
//  NowConfer
//
//  Created by Tristate on 14/06/18.
//  Copyright © 2018 Tristate. All rights reserved.
//

import Foundation


extension Date {
    
    func getTimeIntervalFromTwoDate(fromDate : String , toDate : String) -> String {
        //2018-07-20 17:40 PM
        
        /*let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm a"
        
        let dateS = df.date(from: fromDate)
        let dateE = df.date(from: toDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+05:30")
        let startdate = dateFormatter.string(from: dateS!)
        let enddate = dateFormatter.string(from: dateE!)*/
        
        var arrdate = fromDate.components(separatedBy: " ")
        var arrDate1 = toDate.components(separatedBy: " ")

        var startdate = ""
        if arrdate.count==3 {
            arrdate.removeLast()
            startdate = arrdate.joined(separator: " ")
        }
         var enddate = ""
        if arrDate1.count==3 {
            arrDate1.removeLast()
            enddate = arrDate1.joined(separator: " ")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateA = dateFormatter.date(from: startdate)
        let dateB = dateFormatter.date(from: enddate)
        
        //let timeInterval = date?.timeIntervalSince(date1!)
        
        let calendar = NSCalendar.current
        let timeDifference = calendar.dateComponents([.hour,.minute], from: dateA!, to: dateB!)
        let count =  timeDifference.value(for: .hour)!
        let count1 =  timeDifference.value(for: .minute)!
        
        if(count > 0){
            return "\(String(format: "%02d",count)):\(String(format: "%02d",count1)) hr"
        }else {
            return "\(String(format: "%02d",count1)) min"
        }
        
    }
    
//    func getGMTtoLocalTimeZone(date:String) -> String {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
//
//        let dt = dateFormatter.date(from: date)
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
//
//        return dateFormatter.string(from: dt!)
//    }
    
    func getDifferBtwnDatesWithOnlyHr(fromDate : String , toDate : String) -> String {
        //2018-07-20 17:40 PM
        
        var arrdate = fromDate.components(separatedBy: " ")
        var arrDate1 = toDate.components(separatedBy: " ")
        
        var firstDate = ""
        if arrdate.count==3 {
            arrdate.removeLast()
            firstDate = arrdate.joined(separator: " ")
        }
        var lastDate = ""
        if arrDate1.count==3 {
            arrDate1.removeLast()
            lastDate = arrDate1.joined(separator: " ")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let date = dateFormatter.date(from: firstDate)
        let date1 = dateFormatter.date(from: lastDate)
        
        //let timeInterval = date?.timeIntervalSince(date1!)
        
        let calendar = NSCalendar.current
        let timeDifference = calendar.dateComponents([.hour,.minute], from: date!, to: date1!)
        let count =  timeDifference.value(for: .hour)!
        let count1 =  timeDifference.value(for: .minute)!
        
        return "\(String(format: "%02d",count)):\(String(format: "%02d",count1))"
    }
    
    func getStringFromTimeStamp(_ timeinterval  : TimeInterval) -> String {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: timeinterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    func getDateFromString(_ strDate:String) -> Date {
        if strDate == "" || strDate == nil {
            return Date()
        }else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
            let dateValue = dateFormatter.date(from: strDate)
            return dateValue!
        }
    }
    
    func getTimeFromDate(_ strDate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//"MM/dd/yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        
        let date = dateFormatter.date(from: strDate)
        dateFormatter.dateFormat = "HH:mm a"
        let strValue = dateFormatter.string(from: date!)
        
        return strValue
    }
    
    func getTimeFromHoursDate(_ strDate:String) -> String {
        let dateFormatter = DateFormatter()
        if(strDate == ""){
            return ""
        }
        if(strDate.count > 6) {
            dateFormatter.dateFormat = "HH:mm:ss"
        }else{
            dateFormatter.dateFormat = "HH:mm"
        }
        //"MM/dd/yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        
        let date = dateFormatter.date(from: strDate)
        dateFormatter.dateFormat = "HH:mm"
        let strValue = dateFormatter.string(from: date!)
        
        return strValue
    }
    
    func getTimeStampValue(_ strDate:String) -> TimeInterval {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //"MM/dd/yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        
        let date = dateFormatter.date(from: strDate)
        let timeInterval = date?.timeIntervalSince1970
        return timeInterval!
        
    }
    
    func getTimeStampValueFromDateFormat(_ strDate:String) -> TimeInterval {
        if strDate == nil || strDate == "" {
            return Date().timeIntervalSince1970
        }
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //"MM/dd/yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        
        let date = dateFormatter.date(from: strDate)
        let timeInterval = date?.timeIntervalSince1970
        return timeInterval!
        
    }
    
    func dayDifference(from interval : TimeInterval) -> String
    {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: interval)
        if calendar.isDateInYesterday(date) { return "YESTERDAY" }
        else if calendar.isDateInToday(date) { return "TODAY" }
        else if calendar.isDateInTomorrow(date) { return "TOMORROW" }
        else {
            
            let date = Date(timeIntervalSince1970: interval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd. MMMM YYYY"
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.string(from: date)
            return localDate
            /*let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(abs(day)) days ago" }
            else { return "In \(day) days" } */
        }
    }
    
    func addOneDay(_ interval : TimeInterval) -> String {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: interval+86400)
        if calendar.isDateInYesterday(date) { return "YESTERDAY" }
        else if calendar.isDateInToday(date) { return "TODAY" }
        else if calendar.isDateInTomorrow(date) { return "TOMORROW" }
        else {
            
            let date = Date(timeIntervalSince1970: interval+86400)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd. MMMM YYYY"
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.string(from: date)
            if date > Date() {
                return localDate
            }else {
                return "YESTERDAY"
            }
            
        }
    }
    
    func setWeekDate(_ interval : TimeInterval) -> String {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: interval+604800)
        
        if calendar.isDateInToday(date) {
            
            let date1 = Date().addingTimeInterval(86400)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM"
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.string(from: date1)
            
            let newLocalDate = dateFormatter.string(from: Date().addingTimeInterval(691200))
            let newDate = localDate + "-" + newLocalDate
            return newDate
        }
        else {
            if date < Date() {
                let date1 = Date(timeIntervalSince1970: interval)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM"
                dateFormatter.timeZone = TimeZone.current
                let localDate = dateFormatter.string(from: date1)
                let newLocalDate = dateFormatter.string(from: date)
                let newDate = localDate + "-" + newLocalDate
                return newDate
            }
            else {
                let date1 = Date(timeIntervalSince1970: interval)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM"
                dateFormatter.timeZone = TimeZone.current
                let localDate = dateFormatter.string(from: date1)
                let newLocalDate = dateFormatter.string(from: date)
                let newDate = localDate + "-" + newLocalDate
                return newDate
            }
            
        }
    }
    
    func setOneWeekDateFormat(_ interval : TimeInterval) -> String {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: interval+518400)
        
        let date1 = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.timeZone = TimeZone.current
        let localDate = dateFormatter.string(from: date1)
        let newLocalDate = dateFormatter.string(from: date)
        let newDate = localDate + "-" + newLocalDate
        return newDate
    }
    func setAddOneWeekDate(_ interval : TimeInterval) -> String {
        let calendar = NSCalendar.current
        let newTimeInterval = interval+691200
        let date = Date(timeIntervalSince1970: newTimeInterval+604800)
        
        if calendar.isDateInToday(date) {
            let date1 = Date(timeIntervalSince1970: interval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM"
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.string(from: date1)
            let newLocalDate = dateFormatter.string(from: Date())
            let newDate = localDate + "-" + newLocalDate
            return newDate
        }
        else {
            if date < Date() {
                let date1 = Date(timeIntervalSince1970: interval)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM"
                dateFormatter.timeZone = TimeZone.current
                let localDate = dateFormatter.string(from: date1)
                let newLocalDate = dateFormatter.string(from: date)
                let newDate = localDate + "-" + newLocalDate
                return newDate
            }
            else {
                
                let date1 = Date(timeIntervalSince1970: newTimeInterval)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM"
                dateFormatter.timeZone = TimeZone.current
                let localDate = dateFormatter.string(from: date1)
                let newLocalDate = dateFormatter.string(from: date)
                let newDate = localDate + "-" + newLocalDate
                return newDate
            }
            
        }
    }
    
    func setAddOneWeekAndGetDateFormat(_ interval : TimeInterval) -> String {
        let calendar = NSCalendar.current
        let newTimeInterval = interval+604800
        let date = Date(timeIntervalSince1970: newTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func setMonthDate(_ interval : TimeInterval) -> String {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: interval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.timeZone = TimeZone.current
        let localDate = dateFormatter.string(from: date)
        let currentYear = dateFormatter.string(from: Date())
        if localDate == currentYear {
            dateFormatter.dateFormat = "LLLL"
            dateFormatter.timeZone = TimeZone.current
            let currentMonth = dateFormatter.string(from: date)
            return currentMonth
        }else{
            dateFormatter.dateFormat = "LLLL yyyy"
            dateFormatter.timeZone = TimeZone.current
            let dateNew = dateFormatter.string(from: date)
            return dateNew
        }
    }
    
    func setAddOneMonthDate(_ interval : TimeInterval) -> String {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: interval)
        let newDate = calendar.date(byAdding: .month, value: 1, to: date)
        
        if newDate! > Date() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.string(from: newDate!)
            let currentYear = dateFormatter.string(from: Date())
            if localDate == currentYear {
                dateFormatter.dateFormat = "LLLL"
                dateFormatter.timeZone = TimeZone.current
                let currentMonth = dateFormatter.string(from: newDate!)
                return currentMonth
            }else{
                dateFormatter.dateFormat = "LLLL yyyy"
                dateFormatter.timeZone = TimeZone.current
                let dateNew = dateFormatter.string(from: newDate!)
                return dateNew
            }
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL"
            dateFormatter.timeZone = TimeZone.current
            let currentMonth = dateFormatter.string(from: Date())
            return currentMonth
        }
        
    }
    //    func dayDifference(from interval : TimeInterval) -> String
    //    {
    //        let calendar = NSCalendar.current
    //        let date = Date(timeIntervalSince1970: interval)
    //        if calendar.isDateInYesterday(date) { return "YESTERDAY" }
    //        else if calendar.isDateInToday(date) { return "TODAY" }
    //        else if calendar.isDateInTomorrow(date) { return "TOMORROW" }
    //        else {
    //            let startOfNow = calendar.startOfDay(for: Date())
    //            let startOfTimeStamp = calendar.startOfDay(for: date)
    //            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
    //            let day = components.day!
    //            if day < 1 { return "\(abs(day)) days ago" }
    //            else { return "In \(day) days" }
    //        }
    //    }
}
