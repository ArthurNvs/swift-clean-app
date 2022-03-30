//  Created by Arthur Neves on 29/03/22.

import XCTest
import UIKit
import UI
@testable import MainTests

public final class WelcomeRouter {
  private let nav: NavigationController
  private let loginFactory: () -> LoginViewController
  
  init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController) {
    self.nav = nav
    self.loginFactory = loginFactory
  }
  
  public func goToLogin() {
    nav.pushViewController(loginFactory())
  }
}

class WelcomeRouterTests: XCTestCase {
  func test_goToLogin_calls_nav_with_correct_view_controller() {
    let loginFactorySpy = LoginFactorySpy()
    let nav = NavigationController()
    let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLoginViewController)
    sut.goToLogin()
    XCTAssertEqual(nav.viewControllers.count, 1)
    XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
  }
  
  class LoginFactorySpy {
    func makeLoginViewController() -> LoginViewController {
      return LoginViewController.instantiate()
    }
  }
}
