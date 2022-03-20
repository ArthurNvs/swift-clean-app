//  Created by Arthur Neves on 20/02/22.

import Foundation

public struct AccountModel: Model {
  public var accessToken: String
  
  public init(accessToken: String) {
    self.accessToken = accessToken
  }
}
