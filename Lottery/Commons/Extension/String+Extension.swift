//
//  String+Extension.swift
//  Restaurants
//
//  Created by Tristate on 24/07/17.
//  Copyright © 2017 Tristate. All rights reserved.
//

import UIKit
import Foundation
import Security
extension Double {
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    var shortStringRepresentation: String {
        let num = self
        var thousandNum = num/1000
        var millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))k")
            }
            return("\(thousandNum.roundToPlaces(places: 1))k")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k")
            }
            return ("\(millionNum.roundToPlaces(places: 1))M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }
}
extension String {
    ///MARK:- Variables
    /*var MD5: String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        
        let hash = data.withUnsafeBytes { (bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes, CC_LONG(data.count), &hash)
            return hash
        }
        
        return (0..<length).map { String(format: "%02x", hash[$0]) }.joined()
    }*/
    var length: Int {
        return self.count
    }
    //MARK:-Functions
    static func formatSecondsToString(_ seconds: TimeInterval) -> String {
        if seconds.isNaN {
            return "00:00"
        }
        let Min = Int(seconds / 60)
        let Sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", Min, Sec)
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    func getDayName(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let strDay = dateFormatter.string(from: date)
        return strDay
    }
    func getMonthName(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let strMonth = dateFormatter.string(from: date)
        return strMonth
    }
    func getTime(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let strMonth = dateFormatter.string(from: date)
        return strMonth
    }
    func getTimewithAMPM(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let strMonth = dateFormatter.string(from: date)
        return strMonth
    }
    func getStartTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startTime = dateFormatter.string(from: Date())
        return  startTime
    }
    func getGMTtoLocalTimeZone() -> String {
        var arrdate = self.components(separatedBy: " ")
        
        var startdate = ""
        if arrdate.count==3 {
            arrdate.removeLast()
            startdate = arrdate.joined(separator: " ")
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let dt = dateFormatter.date(from: startdate)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    func getTimeFromDate(_ strDate:String) -> String {
        let startTime = strDate.getGMTtoLocalTimeZone()
        
        var arrdate = startTime.components(separatedBy: " ")
        var startdate = ""
        if arrdate.count==3 {
            arrdate.removeLast()
            startdate = arrdate.joined(separator: " ")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: startdate)
        
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        let finalDate = df.string(from: date!)
        
        return finalDate
    }
    func getTimeFromSrtingToDataAMPM(_ strDate:String , _ isTime:Bool) -> String {
        var arrdate = strDate.components(separatedBy: " ")
        var startdate = ""
        if arrdate.count==3 {
            arrdate.removeLast()
            startdate = arrdate.joined(separator: " ")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: startdate)
        
        var strtime = ""
        if isTime {
          let df = DateFormatter()
          df.dateFormat = "hh:mm"
          strtime = df.string(from: date!)
        }else{
          let df = DateFormatter()
          df.dateFormat = "a"
          strtime = df.string(from: date!)
        }
        return strtime
    }
    func getSpecificDateFromString(_ strDate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let date = dateFormatter.date(from: strDate)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let strtime = df.string(from: date!)
        return strtime
    }
    func getDatetoSort(_ strDate:String) -> String {
        //Mon-12 FEB,2018
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.date(from: strDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE-dd MMM ,yyyy"
        let strtime = dateFormatter.string(from: date!)
        
        return strtime
    }
    func substringFrom(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    func substringTo(_ to: Int) -> String {
        return self.substring(to: self.characters.index(self.endIndex, offsetBy: to))
    }

        func subString(startIndex: Int, endIndex: Int) -> String {
            let end = (endIndex - self.count) + 1
            let indexStartOfText = self.index(self.startIndex, offsetBy: startIndex)
            let indexEndOfText = self.index(self.endIndex, offsetBy: end)
            let substring = self[indexStartOfText..<indexEndOfText]
            return String(substring)
        }
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
   /* func addInterval(toTime time: String?, withInterval interval: String?) -> String? {
        //convert string object into NSDate object
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        //Set System Timezone
        formatter.timeZone = NSTimeZone.system
        let TimeInDateFormat: Date? = formatter.date(from: time ?? "")
        //Additing 01:00 Houes
        let component = interval?.components(separatedBy: ":")
        let secondsInOnehours = TimeInterval(Int(truncating: component?[0]) ?? 0 * 60 * 60)
        let secondsInOneMinute = TimeInterval(Int(truncating: component?[1]) ?? 0 * 60)
        let dateOneHoursAhead = TimeInDateFormat?.addingTimeInterval(secondsInOnehours + secondsInOneMinute) as? Date
        var endTime: String? = nil
        if let anAhead = dateOneHoursAhead {
            endTime = formatter.string(from: anAhead)
        }
        if let anAhead = dateOneHoursAhead {
            print("after added dateOneHoursAhead: \(anAhead)")
        }
        return endTime
    }*/

    // LEFT
    // Returns the specified number of chars from the left of the string
    // let str = "Hello"
    // print(str.left(3))         // Hel
    func left(_ to: Int) -> String {
        return "\(self[..<self.index(startIndex, offsetBy: to)])"
    }
    
    // RIGHT
    // Returns the specified number of chars from the right of the string
    // let str = "Hello"
    // print(str.left(3))         // llo
    func right(_ from: Int) -> String {
        return "\(self[self.index(startIndex, offsetBy: self.length-from)...])"
    }
    
    // MID
    // Returns the specified number of chars from the startpoint of the string
    // let str = "Hello"
    // print(str.left(2,amount: 2))         // ll
    func mid(_ from: Int, amount: Int) -> String {
        let x = "\(self[self.index(startIndex, offsetBy: from)...])"
        return x.left(amount)
    }
    func trimmed() -> String{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


