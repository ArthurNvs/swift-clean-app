//  Created by Arthur Neves on 19/03/22.

import Foundation
import Presentation

public final class EmailValidation: Validation, Equatable {
  private let fieldName: String
  private let fieldLabel: String
  private let emailValidator: EmailValidator
  
  public init(fieldName: String, fieldLabel: String, emailValidator: EmailValidator) {
    self.fieldLabel = fieldLabel
    self.fieldName = fieldName
    self.emailValidator = emailValidator
  }
  
  public func validate(data: [String : Any]?) -> String? {
    guard let fieldValue = data?[fieldName] as? String, emailValidator.isValid(email: fieldValue) else { return "\(fieldLabel) is invalid!" }
    return nil
  }
  
  public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
    lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
  }
}
