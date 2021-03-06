//  Created by Arthur Neves on 29/03/22.

import XCTest
import UIKit
import UI

class WelcomeRouterTests: XCTestCase {
  func test_goToLogin_calls_nav_with_correct_view_controller() {
    let (sut, nav) = makeSut()
    sut.goToLogin()
    XCTAssertEqual(nav.viewControllers.count, 1)
    XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
  }
  
  func test_goToSignUp_calls_nav_with_correct_view_controller() {
    let (sut, nav) = makeSut()
    sut.goToSignUp()
    XCTAssertEqual(nav.viewControllers.count, 1)
    XCTAssertTrue(nav.viewControllers[0] is SignUpViewController)
  }
}

extension WelcomeRouterTests {
  func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
    let loginFactorySpy = LoginFactorySpy()
    let signUpFactorySpy = SignUpFactorySpy() 
    let nav = NavigationController()
    let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLoginViewController, signUpFactory: signUpFactorySpy.makeSignUpViewController)
    return (sut, nav)
  }
}

extension WelcomeRouterTests {
  class LoginFactorySpy {
    func makeLoginViewController() -> LoginViewController {
      return LoginViewController.instantiate()
    }
  }
  
  class SignUpFactorySpy {
    func makeSignUpViewController() -> SignUpViewController {
      return SignUpViewController.instantiate()
    }
  }
}
