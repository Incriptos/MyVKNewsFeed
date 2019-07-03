//
//  LoginViewController.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var loginWithVK: UIButton! {
    didSet {
      loginWithVK.layer.cornerRadius = 10
    }
  }
  
  private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
      authService = AppDelegate.shared().authService
    }
  
  
  @IBAction func signInTapped(_ sender: UIButton) {
    authService.wakeUpSession()
  }
  
}
