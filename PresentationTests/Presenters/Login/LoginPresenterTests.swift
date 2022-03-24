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
  
}

// MARK: - TESTS HELPERS
extension LoginPresenterTests {
  func makeSut(validation: ValidationSpy = ValidationSpy(), file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
    let sut = LoginPresenter(validation: validation)
    checkMemoryLeak(for: sut, file: file, line: line)
    return sut
  }
}
