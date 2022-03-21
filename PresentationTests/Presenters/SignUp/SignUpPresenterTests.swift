//  Created by Arthur Neves on 04/03/22.

import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {
  func test_signup_should_call_addAccount_with_correct_values() {
    let addAccountSpy = AddAccountSpy()
    let sut = makeSut(addAccount: addAccountSpy)
    sut.signUp(viewModel: makeSignUpViewModel())
    XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
  }
  
  func test_signup_should_show_generic_error_message_if_addAccount_fails() {
    let alertViewSpy = AlertViewSpy()
    let addAccountSpy = AddAccountSpy()
    let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
    let exp = expectation(description: "waiting")
    alertViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Something went wrong, try again later."))
      exp.fulfill()
    }
    sut.signUp(viewModel: makeSignUpViewModel())
    addAccountSpy.completeWithError(.unexpected)
    wait(for: [exp], timeout: 1)
  }
  
  func test_signup_should_show_email_in_use_error_message_if_addAccount_returns_email_in_use_error() {
    let alertViewSpy = AlertViewSpy()
    let addAccountSpy = AddAccountSpy()
    let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
    let exp = expectation(description: "waiting")
    alertViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "This email is in use."))
      exp.fulfill()
    }
    sut.signUp(viewModel: makeSignUpViewModel())
    addAccountSpy.completeWithError(.emailInUse)
    wait(for: [exp], timeout: 1)
  }
  
  func test_signup_should_show_success_message_if_addAccount_succeeds() {
    let alertViewSpy = AlertViewSpy()
    let addAccountSpy = AddAccountSpy()
    let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
    let exp = expectation(description: "waiting")
    alertViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, AlertViewModel(title: "Success", message: "Account created."))
      exp.fulfill()
    }
    sut.signUp(viewModel: makeSignUpViewModel())
    addAccountSpy.completeWithAccount(makeAccountModel())
    wait(for: [exp], timeout: 1)
  }
  
  func test_signup_should_show_loading_before_and_after_addAccount() {
    let loadingViewSpy = LoadingViewSpy()
    let addAccountSpy = AddAccountSpy()
    let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
    let exp = expectation(description: "waiting")
    loadingViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
      exp.fulfill()
    }
    sut.signUp(viewModel: makeSignUpViewModel())
    wait(for: [exp], timeout: 1)
    let exp2 = expectation(description: "waiting")
    loadingViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
      exp2.fulfill()
    }
    addAccountSpy.completeWithError(.unexpected)
    wait(for: [exp2], timeout: 1)
  }
  
  func test_signUp_should_call_validation_with_correct_values() {
    let validationSpy = ValidationSpy()
    let sut = makeSut(validation: validationSpy)
    let viewModel = makeSignUpViewModel()
    sut.signUp(viewModel: viewModel)
    XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
  }
  
  func test_signup_should_show_error_message_if_validation_fails() {
    let alertViewSpy = AlertViewSpy()
    let validationSpy = ValidationSpy()
    let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
    let exp = expectation(description: "waiting")
    alertViewSpy.observe { viewModel in
      XCTAssertEqual(viewModel, AlertViewModel(title: "Validation failed", message: "Error"))
      exp.fulfill()
    }
    validationSpy.simulateError()
    sut.signUp(viewModel: makeSignUpViewModel())
    wait(for: [exp], timeout: 1)
  }
}

// MARK: - TESTS HELPERS
extension SignUpPresenterTests {
  func makeSut(alertView: AlertViewSpy = AlertViewSpy(), addAccount: AddAccountSpy = AddAccountSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #filePath, line: UInt = #line) -> SignUpPresenter {
    let sut = SignUpPresenter(alertView: alertView, addAccount: addAccount, loadingView: loadingView, validation: validation)
    checkMemoryLeak(for: sut, file: file, line: line)
    return sut
  }
}
