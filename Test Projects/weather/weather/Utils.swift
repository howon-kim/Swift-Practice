//
//  Utils.swift
//  weather
//
//  Created by Howon Kim on 10/9/19.
//  Copyright © 2019 Howon Kim. All rights reserved.
//

import Cocoa

class Utils: NSObject {

}

extension Date {
    // api에 사용될 base_time을 반환하는 메서드
    func getBaseTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        
        guard let hour = Int(formatter.string(from: date)) else {
            return ""
        }
        formatter.dateFormat = "mm"
        guard let minute = Int(formatter.string(from: date)) else {
            return ""
        }
        
        var hourString = ""
        var minuteString = ""
        
        if hour < 10 {
            if minute < 30 {
                hourString = "0\(hour - 1)"
                minuteString = "50"
            } else {
                hourString = "0\(hour)"
                minuteString = String(minute)
            }
            
        } else {
            if minute < 30 {
                hourString = "\(hour - 1)"
                minuteString = "50"
            } else {
                hourString = "\(hour)"
                minuteString = String(minute)
            }
        }
        
        return hourString + minuteString
    }
    // api에 사용될 base_date를 반환하는 메서드
    func getBaseDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    // 오늘 요일을 반환하는 메서드
    func getDayOfWeek() -> String {
        var str = ""
        if let today = Calendar.current.dateComponents([.weekday], from: self).weekday {
            switch today % 7 {
            case 1:
                str = "일요일"
            case 2:
                str = "월요일"
            case 3:
                str = "화요일"
            case 4:
                str = "수요일"
            case 5:
                str = "목요일"
            case 6:
                str = "금요일"
            default:
                str = "토요일"
            }
        }
        return str
    }
}
