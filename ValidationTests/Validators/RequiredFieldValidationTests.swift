//  Created by Arthur Neves on 19/03/22.

import Foundation
import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {
  func test_validate_should_return_error_if_field_is_not_provided() {
    let sut = makeSut(fieldName: "email", fieldLabel: "Email")
    let errorMessage = sut.validate(data: ["name": "Arthur"])
    XCTAssertEqual(errorMessage, "Email is required!")
  }
  
  func test_validate_should_return_error_with_correct_fieldLabel() {
    let sut = makeSut(fieldName: "age", fieldLabel: "Age")
    let errorMessage = sut.validate(data: ["name": "Arthur"])
    XCTAssertEqual(errorMessage, "Age is required!")
  }
  
  func test_validate_should_return_nil_if_field_is_provided() {
    let sut = makeSut(fieldName: "email", fieldLabel: "Email")
    let errorMessage = sut.validate(data: ["email": "Arthur@Mail.com"])
    XCTAssertNil(errorMessage)
  }
  
  func test_validate_should_return_nil_if_no_data_is_provided() {
    let sut = RequiredFieldValidation(fieldName: "email", fieldLabel: "Email")
    let errorMessage = sut.validate(data: nil)
    XCTAssertEqual(errorMessage, "Email is required!")
  }
}

extension RequiredFieldValidationTests {
  func makeSut(fieldName: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
    let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
    checkMemoryLeak(for: sut, file: file, line: line)
    return sut
  }
}
