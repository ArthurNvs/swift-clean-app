//  Created by Arthur Neves on 24/03/22.

import XCTest
import Main
import UI
import Validation

class LoginControllerFactoryTest: XCTestCase {
  func test_background_request_should_complete_on_main_thread() {
    let (sut, authenticationSpy) = makeSut()
    sut.loadViewIfNeeded()
    sut.login?(makeLoginViewModel())
    let exp = expectation(description: "waiting")
    DispatchQueue.global().async {
      authenticationSpy.completeWithError(.unexpected)
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1)
  }
  
  func test_login_compose_with_correct_validations() {
    let validations = makeLoginValidations()
    XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
    XCTAssertEqual(validations[1] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
    XCTAssertEqual(validations[2] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"))
  }
}

extension LoginControllerFactoryTest {
  func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: LoginViewController, authenticationSpy: AuthenticationSpy) {
    let authenticationSpy = AuthenticationSpy()
    let sut = makeLoginControllerWith(authentication: MainQueueDispatchDecorator(authenticationSpy))
    checkMemoryLeak(for: sut, file: file, line: line)
    checkMemoryLeak(for: authenticationSpy, file: file, line: line)
    return (sut, authenticationSpy) 
  }
}
