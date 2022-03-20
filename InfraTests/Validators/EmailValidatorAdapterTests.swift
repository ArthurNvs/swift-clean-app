//  Created by Arthur Neves on 16/03/22.

import XCTest
import Infra

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
      let sut = makeSut()
      XCTAssertFalse(sut.isValid(email: "aa"))
      XCTAssertFalse(sut.isValid(email: "aa@"))
      XCTAssertFalse(sut.isValid(email: "aa@aa."))
      XCTAssertFalse(sut.isValid(email: "@aa.com"))
      XCTAssertFalse(sut.isValid(email: "aa@mail"))
    }
  
  func test_valid_emails() {
    let sut = makeSut()
    XCTAssertTrue(sut.isValid(email: "arthur@gmail.com"))
    XCTAssertTrue(sut.isValid(email: "arnemo@pm.me"))
    XCTAssertTrue(sut.isValid(email: "ArthurMonteiro@CorporativeMail.com"))
  }
}

extension EmailValidatorAdapterTests {
  func makeSut() -> EmailValidatorAdapter {
    return EmailValidatorAdapter()
  }
}
