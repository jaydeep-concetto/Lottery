//
//  Constant.swift
//  Restaurants
//
//  Created by Tristate on 10/07/17.
//  Copyright © 2017 Tristate. All rights reserved.
//

import UIKit
var users  = UserDetail()


class Constant_Url : NSObject {
    public static var liveUrl:String = "http://aimtechnowebs.com/lotteryapp/api/"
    public static var localUrl:String = ""
    public static var Url:String = liveUrl
}

//MARK:- Restaurants
struct Constant_String {
    
    public static let APP_NAME = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    public static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    public static let APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    public static let APP_SYSYTEM_VERSION  = UIDevice.current.systemVersion
    public static let DEVICE_ID  = UIDevice.current.identifierForVendor!.uuidString
    public static let DEVICE_NAME  = UIDevice.current.systemName
    
    public static let No_Friend_To_Display = "No friend to display"
    public static let No_Result_To_Display = "No Result to display"
   public static let None = "None"
}


struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
//MARK:- DeviceType Check
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

struct URL_NAME {
    public static let login  = "login"
    public static let register = "register"
    public static let loginWithSocialMedia = "loginWithSocialMedia"
    public static let socialAccountMap = "socialAccountMap"
    public static let uploadProfilePic =  "uploadProfilePic"
    public static let uploadSignature =  "uploadSignature"
    public static let update_password = "update_password"
    public static let update_email = "update_email"
    public static let update_phone = "update_phone"
    public static let add_wire_information = "add_wire_information"
    public static let verify_otp = "verify_otp"
    public static let notification_setting = "notification_setting"
    public static let mailbox_item_list = "mailbox_item_list"
    public static let mailbox_read_item = "mailbox_read_item"
    public static let friend_list = "friend_list"
    public static let give_get_status = "give_get_status"
    public static let agree_reject_status = "agree_reject_status"
    public static let add_friend = "add_friend"
    public static let lottery_company_list = "lottery_company_list"
    public static let user_lottery_list = "user_lottery_list"
    public static let clubListFilter = "clubListFilter"
    public static let club_detail = "club_detail"
    public static let changeClub = "changeClub"
    public static let joinNewClub = "joinNewClub"
    public static let clubList = "clubList"
    public static let add_lottery_ticket = "add_lottery_ticket"
    public static let ticket_detail = "ticket_detail"
    public static let lottery_result = "lottery_result"
    public static let announcement = "announcement"
//    public static let
//    public static let
//    public static let
//    public static let
//    public static let
//    public static let
//    public static let
//    public static let
//    public static let
    
    
    
}
