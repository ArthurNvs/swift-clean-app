//  Created by Arthur Neves on 04/03/22.

import XCTest
import Presentation

class SignUpPresenterTests: XCTestCase {
  func test_signup_should_show_error_message_if_name_is_not_provided() {
    let alertViewSpy = AlertViewSpy()
    let sut = makeSut(alertView: alertViewSpy)
    sut.signUp(viewModel: makeSignUpViewModel(name: nil))
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Name is required"))
  }
  
  func test_signup_should_show_error_message_if_email_is_not_provided() {
    let alertViewSpy = AlertViewSpy()
    let sut = makeSut(alertView: alertViewSpy)
    sut.signUp(viewModel: makeSignUpViewModel(email: nil))
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Email is required"))
  }
  
  func test_signup_should_show_error_message_if_password_is_not_provided() {
    let alertViewSpy = AlertViewSpy()
    let sut = makeSut(alertView: alertViewSpy)
    sut.signUp(viewModel: makeSignUpViewModel(password: nil))
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password is required"))
  }
  
  func test_signup_should_show_error_message_if_password_confirmation_is_not_provided() {
    let alertViewSpy = AlertViewSpy()
    let sut = makeSut(alertView: alertViewSpy)
    sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password confirmation is required"))
  }
  
  func test_signup_should_show_error_message_if_password_confirmation_do_not_match() {
    let alertViewSpy = AlertViewSpy()
    let sut = makeSut(alertView: alertViewSpy)
    sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_pswd"))
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Passwords don't match"))
  }
  
  func test_signup_should_call_emailValidator_with_correct_email() {
    let emailValidatorSpy = EmailValidatorSpy()
    let sut = makeSut(emailValidator: emailValidatorSpy)
    let signUpViewModel = makeSignUpViewModel()
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
  }
  
  func test_signup_should_show_error_message_if_invalid_email_is_provided() {
    let alertViewSpy = AlertViewSpy()
    let emailValidatorSpy = EmailValidatorSpy()
    let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
    emailValidatorSpy.simulateInvalidEmail()
    sut.signUp(viewModel: makeSignUpViewModel())
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Invalid email"))
  }
}

extension SignUpPresenterTests {
  func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {
    let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
    return sut
  }
  
  func makeSignUpViewModel(name: String? = "any_name", email: String? = "any_email@mail.com", password: String? = "any_pswd", passwordConfirmation: String? = "any_pswd") -> SignUpViewModel {
    return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
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
    
    func simulateInvalidEmail() {
      isValid = false
    }
  }
}
