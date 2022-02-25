//  Created by Arthur Neves on 22/02/22.

import Foundation

public extension Data {
  func toModel<T: Decodable>() -> T? {
    return try? JSONDecoder().decode(T.self, from: self)
  }
  
  func toJson() -> [String: Any]? {
    return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
  }
}
