//
//  File.swift
//  Travcentive
//
//  Created by Vachhani Jaydeep on 14/11/18.
//  Copyright © 2018 Rocky Panchal. All rights reserved.
//

import Foundation



class UserDetail
{
    
    var token = String()
    var user = String()
    var id = String()
    var email_verified = String()
    var gender = String()
    var city = String()
    var created_at = String()
    var google_profile_id = String()
    var phone = String()
    var otp_verified = String()
    var zone = String()
    var status = String()
    var signature = String()
    var sms_verified = String()
    var user_type = String()
    var country = String()
    var wire_information = String()
    var chip = String()
    var fb_profile_id = String()
    var last_login = String()
    var profile_pic = String()
    var text_message = String()
    var state = String()
    var name = String()
    var push_notification = String()
    var email_notification = String()
    var email = String()
    var emoney = String()
    var email_token = String()
    var member_id = String()
    var updated_at = String()
    var number_of_third_user = String()
    var number_of_fifth_user = String()
    var number_of_wins_user = String()
    var number_of_fourth_user = String()
    var highest_win_club = String()
    var number_of_wins_club = String()
    var total_lotteries = String()
    var number_of_second_user = String()
    var highest_win_user = String()
    
    
  
    func inits(dict:Dictionary<String, Any>){

        var tempDict = dict["user"] as! [String:Any]
        
        token = dict["token"] as? String ?? token
        id = tempDict["id"] as? String ?? id
        email_verified =  tempDict["email_verified"] as? String ?? email_verified
        gender =  tempDict["gender"] as? String ?? gender
        city =  tempDict["city"] as? String ?? city
        created_at =  tempDict["created_at"] as? String ?? created_at
        google_profile_id =  tempDict["google_profile_id"] as? String ?? google_profile_id
        phone =  tempDict["phone"] as? String ?? phone
        otp_verified =  tempDict["otp_verified"] as? String ?? otp_verified
        zone =  tempDict["zone"] as? String ?? zone
        status =  tempDict["status"] as? String ?? status
        signature =  tempDict["signature"] as? String ?? signature
        sms_verified =  tempDict["sms_verified"] as? String ?? sms_verified
        user_type =  tempDict["user_type"] as? String ?? user_type
        country =  tempDict["country"] as? String ?? country
        wire_information =  tempDict["wire_information"] as? String ?? wire_information
        chip =  tempDict["chip"] as? String ?? chip
        fb_profile_id =  tempDict["fb_profile_id"] as? String ?? fb_profile_id
        last_login =  tempDict["last_login"] as? String ?? last_login
        profile_pic =  tempDict["profile_pic"] as? String ?? profile_pic
        text_message =  tempDict["text_message"] as? String ?? text_message
        state =  tempDict["state"] as? String ?? state
        name =  tempDict["name"] as? String ?? name
        push_notification =  tempDict["push_notification"] as? String ?? push_notification
        email_notification =  tempDict["email_notification"] as? String ?? email_notification
        email =  tempDict["email"] as? String ?? email
        emoney =  tempDict["emoney"] as? String ?? emoney
        email_token =  tempDict["email_token"] as? String ?? email_token
        member_id =  tempDict["member_id"] as? String ?? member_id
        updated_at =  tempDict["updated_at"] as? String ?? updated_at
        number_of_third_user =  tempDict["number_of_third_user"] as? String ?? number_of_third_user
        number_of_fifth_user =  tempDict["number_of_fifth_user"] as? String ?? number_of_fifth_user
        number_of_wins_user =  tempDict["number_of_wins_user"] as? String ?? number_of_wins_user
        number_of_fourth_user =  tempDict["number_of_fourth_user"] as? String ?? number_of_fourth_user
        highest_win_club =  tempDict["highest_win_club"] as? String ?? highest_win_club
        number_of_wins_club =  tempDict["number_of_wins_club"] as? String ?? number_of_wins_club
        total_lotteries =  tempDict["total_lotteries"] as? String ?? total_lotteries
        number_of_second_user =  tempDict["number_of_second_user"] as? String ?? number_of_second_user
        highest_win_user =  tempDict["highest_win_user"] as? String ?? highest_win_user
        
    }
    
}
