//
//  StringConstants.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation
import AWSCore

struct OnboardingStrings{
    
    static let shared = OnboardingStrings()
    
    let phoneNumberError = "Please enter valid phone number"
    let phoneNumberLength = 13
    let indianCountryCode = "+91"
    let mobileTextFieldPlaceHolder = "Mobile number"
}

struct CreateProfileString{
    
    static let shared = CreateProfileString()
    
    let firstNameHeading = "First name"
    let lastNameHeading = "Last name"
    let emailHeading = "Email address"
    let navigationTitle = "Create Profile"
    let firstNameError = "Please enter first name"
    let lastNameError = "Please enter last name"
    let emailError = "Please enter email address"
    let emailValidError = "Please enter valid email address"
}


struct SettingStrings {
    
    static let shared = SettingStrings()
    
    let mailError = "Please configure your email first"
}

struct S3Constants {
    static let shared = S3Constants()
    
    let bucketS3 = "abcd"
    let accessKeyS3 = ""
    let secretKeyS3 = ""
    let uploadImageQuality = 0.5
    let regionS3 = AWSRegionType.USEast1
}
