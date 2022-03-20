//  Created by Arthur Neves on 05/03/22.

import Foundation

public protocol EmailValidator {
  func isValid(email: String) -> Bool
}
