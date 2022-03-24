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
    sut.login(viewModel: makeLoginViewModel())
    wait(for: [exp], timeout: 1)
  }
}

// MARK: - TESTS HELPERS
extension LoginPresenterTests {
  func makeSut(alertView: AlertViewSpy = AlertViewSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
    let sut = LoginPresenter(validation: validation, alertView: alertView)
    checkMemoryLeak(for: sut, file: file, line: line)
    return sut
  }
}
