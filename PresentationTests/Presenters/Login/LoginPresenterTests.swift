//  Created by Arthur Neves on 23/03/22.

import XCTest
import Presentation

class LoginPresenterTests: XCTestCase {
  func test_login_should_call_validation_with_correct_values() {
    let validationSpy = ValidationSpy()
    let sut = makeSut(validation: validationSpy)
    let viewModel = makeLoginViewModel()
    sut.login(viewModel: viewModel)
    XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
  }
  
  func test_login_should_show_error_message_if_validation_fails() {
    let alertViewSpy = AlertViewSpy()
    let validationSpy = ValidationSpy()
    let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
    let exp = expectation(description: "waiting")
    alertViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, AlertViewModel(title: "Validation failed", message: "Error"))
      exp.fulfill()
    }
    validationSpy.simulateError()
    sut.login(viewModel: makeLoginViewModel())
    wait(for: [exp], timeout: 1)
  }
  
  func test_login_should_call_authentication_with_correct_values() {
    let authenticationSpy = AuthenticationSpy()
    let sut = makeSut(authentication: authenticationSpy)
    sut.login(viewModel: makeLoginViewModel())
    XCTAssertEqual(authenticationSpy.authenticationModel, makeAuthenticationModel())
  }
  
  func test_login_should_show_generic_error_message_if_authentication_fails() {
    let alertViewSpy = AlertViewSpy()
    let authenticationSpy = AuthenticationSpy()
    let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
    let exp = expectation(description: "waiting")
    alertViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Something went wrong, try again later."))
      exp.fulfill()
    }
    sut.login(viewModel: makeLoginViewModel())
    authenticationSpy.completeWithError(.unexpected)
    wait(for: [exp], timeout: 1)
  }
  
  func test_login_should_show_expired_session_error_message_if_authentication_completes_with_expired_session() {
    let alertViewSpy = AlertViewSpy()
    let authenticationSpy = AuthenticationSpy()
    let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
    let exp = expectation(description: "waiting")
    alertViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Invalid email or password."))
      exp.fulfill()
    }
    sut.login(viewModel: makeLoginViewModel())
    authenticationSpy.completeWithError(.expiredSession)
    wait(for: [exp], timeout: 1)
  }
  
  func test_login_should_show_success_message_if_authentication_succeeds() {
    let alertViewSpy = AlertViewSpy()
    let authenticationSpy = AuthenticationSpy()
    let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
    let exp = expectation(description: "waiting")
    alertViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, AlertViewModel(title: "Success", message: "Welcome!"))
      exp.fulfill()
    }
    sut.login(viewModel: makeLoginViewModel())
    authenticationSpy.completeWithAccount(makeAccountModel())
    wait(for: [exp], timeout: 1)
  }
  
  func test_signup_should_show_loading_before_and_after_authentication() {
    let loadingViewSpy = LoadingViewSpy()
    let authenticationSpy = AuthenticationSpy()
    let sut = makeSut(authentication: authenticationSpy, loadingView: loadingViewSpy)
    let exp = expectation(description: "waiting")
    loadingViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
      exp.fulfill()
    }
    sut.login(viewModel: makeLoginViewModel())
    wait(for: [exp], timeout: 1)
    let exp2 = expectation(description: "waiting")
    loadingViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
      exp2.fulfill()
    }
    authenticationSpy.completeWithError(.expiredSession)
    wait(for: [exp2], timeout: 1)
  }
}

// MARK: - TESTS HELPERS
extension LoginPresenterTests {
  func makeSut(alertView: AlertViewSpy = AlertViewSpy(), authentication: AuthenticationSpy = AuthenticationSpy(), validation: ValidationSpy = ValidationSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
    let sut = LoginPresenter(validation: validation, alertView: alertView, authentication: authentication, loadingView: loadingView)
    checkMemoryLeak(for: sut, file: file, line: line)
    return sut
  }
}
