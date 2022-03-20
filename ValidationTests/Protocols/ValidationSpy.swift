//  Created by Arthur Neves on 20/03/22.

import Foundation
import Presentation

class ValidationSpy: Validation {
  var errorMessage: String?
  var data: [String: Any]?
  
  func validate(data: [String : Any]?) -> String? {
    self.data = data
    return errorMessage
  }
  
  func simulateError(_ errorMessage: String) {
    self.errorMessage = errorMessage
  }
}
