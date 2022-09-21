//
//  Global Constants.swift
//  Food Values
//
//  Created by MAC on 17/03/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

// MARK: -
var isDevelopmentMode = false
var SELECTED_OPTION = "selected_option"
var SOUND_ON = "sound_on"
let HeaderKey = "KlUet6y43te8Jg6G9bkDxN36f9X9ZiTkm"
let BearerKey = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NTcxMjgxMDcsImV4cCI6MjI4Nzg0ODEwNywidXNlcl9pZCI6MTA4NTk5OTF9.Qu__pA6AXusnK0vDpx2rxMussY0IxzSrhQFGonRXJj6eSGA0PrbwVTmvozmYtZoBpdNUHx4qm5gjL-LSFxXVQzjOs7nU9GhVEuZIeEpeR6P90DIhqpum_WhZlJGOPQ59QonslfS6aP_UzhjKzlly47kIfitOFB37GIXVHGiGWXZpTGmu_sPhnPq5tkJZK3KoZNXqNhUBMOrHSfJ2p43yFBt7nEPBfM9DmWcewdQmGrk6KOlUYh7gmouaYCpIOMSU8Ju2VbKR04jGEtEVUfDrAAKUKO3dUGwtW4ihIct3VkzQZbISC8p8kr8QBZNKbhxSzgbkpnaiOiLvB190HF6suQ"

let networkError = "We're having trouble reaching the network. Check your connection or try again in a few minutes."

// MARK: - Storyboard
enum Storyboard : String {
    case Main = "Main"
}
 
func setAfter(_ delay: Double = 0.01, closure: @escaping @convention(block) () -> Swift.Void) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}


struct AppColor {
    
    static let App_BackGround = UIColor(named: "App_Background")!
    static let App_Text_Color = UIColor(named: "App_Text_Color")!
    static let Black = UIColor(named: "App_Black")!
    static let White = UIColor(named: "App_White")!
    static let App_Cell_Color = UIColor(named: "App_Cell_Color")!
    static let AppButtonGradiantEnd = UIColor(named: "App_Button_Gradiant_End")!
    static let AppKeybord = UIColor(named: "App_Keybord")!
    static let AppMessageSender = UIColor(named: "App_Message_Sender")!
    static let AppText = UIColor(named: "App_Text")!
    static let AppTextOpacity = UIColor(named: "App_TextOpacity")!
    static let AppDarkBlue = UIColor(named: "App_Dark_Blue")!
//    static let AppTextfieldShadow = UIColor(named: "App_Textfield_Shadow")!
    static let AppSkyBlue = UIColor(named: "App_Sky_Blue")!
    static let AppOrange = UIColor(named: "App_Orange")!
    static let AppUnselected = UIColor(named: "App_Unselected")!
    
    
}

struct AppFont {
    static let AppRegualer = UIFont(name: "Inter-Regular.ttf", size: 20)
    static let AppSemiBold = UIFont(name: "Inter-SemiBold.ttf", size: 20)
}


