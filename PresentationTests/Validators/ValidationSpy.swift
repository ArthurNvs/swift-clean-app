//  Created by Arthur Neves on 19/03/22.

import Foundation
import Presentation

class ValidationSpy: Validation {
  var data: [String: Any]?
  var errorMessage: String?
  
  func validate(data: [String : Any]?) -> String? {
    self.data = data
    return errorMessage
  }
  
  func simulateError() {
    self.errorMessage = "Error"
  }
}
