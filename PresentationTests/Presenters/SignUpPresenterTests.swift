//  Created by Arthur Neves on 04/03/22.

import XCTest
import Presentation

class SignUpPresenterTests: XCTestCase {
  func test_signup_should_show_error_message_if_name_is_not_provided() {
    let (sut, alertViewSpy) = makeSut()
    let signUpViewModel = SignUpViewModel(email: "any_email@mail.com", password: "any_pswd", passwordConfirmation: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Name is required"))
  }
  
  func test_signup_should_show_error_message_if_email_is_not_provided() {
    let (sut, alertViewSpy) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", password: "any_pswd", passwordConfirmation: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Email is required"))
  }
  
  func test_signup_should_show_error_message_if_password_is_not_provided() {
    let (sut, alertViewSpy) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", passwordConfirmation: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password is required"))
  }
  
  func test_signup_should_show_error_message_if_password_confirmation_is_not_provided() {
    let (sut, alertViewSpy) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", password: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password confirmation is required"))
  }
  
  func test_signup_should_show_error_message_if_password_confirmation_do_not_match() {
    let (sut, alertViewSpy) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", password: "any_pswd", passwordConfirmation: "wrong_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Passwords don't match"))
  }
}

extension SignUpPresenterTests {
  func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy) {
    let alertViewSpy = AlertViewSpy()
    let sut = SignUpPresenter(alertView: alertViewSpy)
    return (sut, alertViewSpy)
  }
  class AlertViewSpy: AlertView {
    var viewModel: AlertViewModel?
    
    func showMessage(viewModel: AlertViewModel) {
      self.viewModel = viewModel
    }
  }
}
