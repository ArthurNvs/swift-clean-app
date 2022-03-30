//  Created by Arthur Neves on 30/03/22.

import Foundation

public final class WelcomeRouter {
  private let nav: NavigationController
  private let loginFactory: () -> LoginViewController
  private let signUpFactory: () -> SignUpViewController
  
  public init(nav: NavigationController,
       loginFactory: @escaping () -> LoginViewController,
       signUpFactory: @escaping () -> SignUpViewController) {
    self.nav = nav
    self.loginFactory = loginFactory
    self.signUpFactory = signUpFactory
  }
  
  public func goToLogin() {
    nav.pushViewController(loginFactory())
  }
  
  public func goToSignUp() {
    nav.pushViewController(signUpFactory())
  }
}
