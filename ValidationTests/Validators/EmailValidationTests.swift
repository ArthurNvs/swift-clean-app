//  Created by Arthur Neves on 19/03/22.

import Foundation
import XCTest
import Presentation
import Validation

class EmailValidationTests: XCTestCase {
  func test_validate_should_return_error_if_invalid_email_is_provided() {
    let emailValidatorSpy = EmailValidatorSpy()
    let sut = EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
    emailValidatorSpy.simulateInvalidEmail()
    let errorMessage = sut.validate(data: ["email": "invalid_email"])
    XCTAssertEqual(errorMessage, "Email is invalid!")
  }
  
  func test_validate_should_return_error_with_correct_fieldLabel() {
    let emailValidatorSpy = EmailValidatorSpy()
    let sut = EmailValidation(fieldName: "email", fieldLabel: "Email2", emailValidator: emailValidatorSpy)
    emailValidatorSpy.simulateInvalidEmail()
    let errorMessage = sut.validate(data: ["email": "invalid_email"])
    XCTAssertEqual(errorMessage, "Email2 is invalid!")
  }
  
  func test_validate_should_return_nil_if_valid_email_is_provided() {
    let sut = EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy())
    let errorMessage = sut.validate(data: ["email": "valid_email"])
    XCTAssertNil(errorMessage)
  }
  
  func test_validate_should_return_nil_if_no_data_is_provided() {
    let sut = EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy())
    let errorMessage = sut.validate(data: nil)
    XCTAssertEqual(errorMessage, "Email is invalid!")
  }
}

extension EmailValidationTests {
  func makeSut(fieldName: String, fieldLabel: String, emailValidator: EmailValidatorSpy, file: StaticString = #filePath, line: UInt = #line) -> Validation {
    let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
    checkMemoryLeak(for: sut, file: file, line: line)
    return sut
  }
}
