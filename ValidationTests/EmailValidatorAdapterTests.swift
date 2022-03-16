//  Created by Arthur Neves on 16/03/22.

import XCTest
import Presentation

public final class EmailValidatorAdapter: EmailValidator {
  private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  
  public func isValid(email: String) -> Bool {
    let range = NSRange(location: 0, length: email.utf16.count)
    let regex = try! NSRegularExpression(pattern: pattern)
    return regex.firstMatch(in: email, options: [], range: range) != nil
  }
}

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
