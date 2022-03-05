//  Created by Arthur Neves on 04/03/22.

import XCTest
import Presentation

class SignUpPresenterTests: XCTestCase {
  func test_signup_should_show_error_message_if_name_is_not_provided() {
    let (sut, alertViewSpy, _) = makeSut()
    let signUpViewModel = SignUpViewModel(email: "any_email@mail.com", password: "any_pswd", passwordConfirmation: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Name is required"))
  }
  
  func test_signup_should_show_error_message_if_email_is_not_provided() {
    let (sut, alertViewSpy, _) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", password: "any_pswd", passwordConfirmation: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Email is required"))
  }
  
  func test_signup_should_show_error_message_if_password_is_not_provided() {
    let (sut, alertViewSpy, _) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", passwordConfirmation: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password is required"))
  }
  
  func test_signup_should_show_error_message_if_password_confirmation_is_not_provided() {
    let (sut, alertViewSpy, _) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", password: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password confirmation is required"))
  }
  
  func test_signup_should_show_error_message_if_password_confirmation_do_not_match() {
    let (sut, alertViewSpy, _) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", password: "any_pswd", passwordConfirmation: "wrong_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Passwords don't match"))
  }
  
  func test_signup_should_call_emailValidator_with_correct_email() {
    let (sut, _, emailValidatorSpy) = makeSut()
    let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", password: "any_pswd", passwordConfirmation: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
  }
}

extension SignUpPresenterTests {
  func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy, emailValidatorSpy: EmailValidatorSpy) {
    let alertViewSpy = AlertViewSpy()
    let emailValidatorSpy = EmailValidatorSpy()
    let sut = SignUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
    return (sut, alertViewSpy, emailValidatorSpy)
  }
  
  class AlertViewSpy: AlertView {
    var viewModel: AlertViewModel?
    
    func showMessage(viewModel: AlertViewModel) {
      self.viewModel = viewModel
    }
  }
  
  class EmailValidatorSpy: EmailValidator {
    var isValid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
      self.email = email
      return isValid
    }
  }
}
