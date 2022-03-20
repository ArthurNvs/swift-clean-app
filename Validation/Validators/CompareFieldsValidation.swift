//  Created by Arthur Neves on 19/03/22.

import Foundation
import Presentation

public final class CompareFieldsValidation: Validation, Equatable {
  private let fieldName: String
  private let fieldNameToCompare: String
  private let fieldLabel: String
  
  public init(fieldName: String, fieldNameToCompare: String, fieldLabel: String) {
    self.fieldName = fieldName
    self.fieldNameToCompare = fieldNameToCompare
    self.fieldLabel = fieldLabel
  }
  
  public func validate(data: [String : Any]?) -> String? {
    guard let fieldName = data?[fieldName] as? String, let fieldNameToCompare = data?[fieldNameToCompare] as? String, fieldName == fieldNameToCompare else { return "\(fieldLabel) is invalid!" }
    return nil
  }
  
  public static func == (lhs: CompareFieldsValidation, rhs: CompareFieldsValidation) -> Bool {
    return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName && lhs.fieldNameToCompare == rhs.fieldNameToCompare
  }
}
