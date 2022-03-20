//  Created by Arthur Neves on 19/03/22.

import Foundation
import XCTest
import Presentation
import Validation

class CompareFieldsValidationTests: XCTestCase {
  func test_should_return_error_if_field_comparation_fails() {
    let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")
    let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "321"])
    XCTAssertEqual(errorMessage, "Password is invalid!")
  }
  
  func test_should_return_error_with_correct_fieldLabel() {
    let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password Confirmation")
    let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "321"])
    XCTAssertEqual(errorMessage, "Password Confirmation is invalid!")
  }
  
  func test_should_return_nil_if_comparation_succeeds() {
    let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")
    let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "123"])
    XCTAssertNil(errorMessage)
  }
  
  func test_should_return_nil_if_no_data_is_provided() {
    let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password Confirmation")
    let errorMessage = sut.validate(data: nil)
    XCTAssertEqual(errorMessage, "Password Confirmation is invalid!")
  }
}

extension CompareFieldsValidationTests {
  func makeSut(fieldName: String, fieldNameToCompare: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
    let sut = CompareFieldsValidation(fieldName: fieldName, fieldNameToCompare: fieldNameToCompare, fieldLabel: fieldLabel)
    checkMemoryLeak(for: sut, file: file, line: line)
    return sut
  }
}

