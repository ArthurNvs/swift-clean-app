//  Created by Arthur Neves on 20/02/22.

import Foundation

public protocol Model: Encodable {}

public extension Model {
  func toData() -> Data? {
    return try? JSONEncoder().encode(self)
  }
}
