//
//  AuthService.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
  func authServiceShouldShow(_ viewController: UIViewController)
  func authServiceSignIn()
  func authServiceSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
  
  private let appID = "7037999"
  private let vkSdk: VKSdk
  
  weak var delegate: AuthServiceDelegate?
  
  var token: String? {
    return VKSdk.accessToken()?.accessToken
  }
  
  var userId: String? {
    return VKSdk.accessToken()?.userId
  }
  
  override init() {
    vkSdk = VKSdk.initialize(withAppId: appID)
    super.init()
    
    vkSdk.register(self)
    vkSdk.uiDelegate = self
  }
  
  func wakeUpSession() {
    let scope = ["wall", "friends"]
    
    VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
      if state == VKAuthorizationState.authorized {
        print("Your status: VKAuthorizationState.authorized")
        delegate!.authServiceSignIn()
      } else if state == VKAuthorizationState.initialized {
        print("Your status: VKAuthorizationState.initialized")
        VKSdk.authorize(scope)
      } else {
        print("Auth problems, State: \(state), Error: \(String(describing: error))")
        delegate!.authServiceSignInFail()
      }
      
    }
  }
  
  
  // MARK: - VKSDK Delegate
  
  func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
    if result.token != nil {
      delegate!.authServiceSignIn()
    }
  }
  
  func vkSdkUserAuthorizationFailed() {
    
  }
  
  // MARK: - VKSDK UIDelegate
  
  func vkSdkShouldPresent(_ controller: UIViewController!) {
    delegate!.authServiceShouldShow(controller)
  }
  
  func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    
  }
  
}

