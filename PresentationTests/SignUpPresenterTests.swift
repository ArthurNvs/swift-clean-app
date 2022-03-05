//  Created by Arthur Neves on 04/03/22.

import XCTest

class SignUpPresenter {
  private let alertView: AlertView
  
  init(alertView: AlertView) {
    self.alertView = alertView
  }
  
  // Presenter sends to AlertView the message (after logic)
  func signUp(viewModel: SignUpViewModel) {
    if viewModel.name == nil || viewModel.name!.isEmpty {
      alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: "Name is required"))
    }
    if viewModel.email == nil || viewModel.email!.isEmpty {
      alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: "Email is required"))
    }
    if viewModel.password == nil || viewModel.password!.isEmpty {
      alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: "Password is required"))
    }
  }
}

protocol AlertView {
  func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable {
  var title: String
  var message: String
}

struct SignUpViewModel {
  var name: String?
  var email: String?
  var password: String?
  var passwordConfirmation: String?
}

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
    let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", passwordConfirmation: "any_pswd")
    sut.signUp(viewModel: signUpViewModel)
    XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation failed", message: "Password is required"))
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
