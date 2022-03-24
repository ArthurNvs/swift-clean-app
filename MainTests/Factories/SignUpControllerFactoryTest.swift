//  Created by Arthur Neves on 17/03/22.

import XCTest
import Main
import UI
import Validation

class SignUpControllerFactoryTest: XCTestCase {
  func test_background_request_should_complete_on_main_thread() {
    let (sut, addAccountSpy) = makeSut()
    sut.loadViewIfNeeded()
    sut.signUp?(makeSignUpViewModel())
    let exp = expectation(description: "waiting")
    DispatchQueue.global().async {
      addAccountSpy.completeWithError(.unexpected)
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1)
  }
  
  func test_signUp_compose_with_correct_validations() {
    let validations = makeSignUpValidations()
    XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "name", fieldLabel: "Name"))
    XCTAssertEqual(validations[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
    XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
    XCTAssertEqual(validations[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"))
    XCTAssertEqual(validations[4] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Password Confirmation"))
    XCTAssertEqual(validations[5] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password Confirmation"))
  }
}

extension SignUpControllerFactoryTest {
  func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy) {
    let addAccountSpy = AddAccountSpy()
    let sut = makeSignUpController(addAccount: addAccountSpy)
    checkMemoryLeak(for: sut, file: file, line: line)
    checkMemoryLeak(for: addAccountSpy, file: file, line: line)
    return (sut, addAccountSpy)
  }
}
