//  Created by Arthur Neves on 19/03/22.

import Foundation

public protocol Validation {
  func validate(data: [String: Any]?) -> String?
}
