//  Created by Arthur Neves on 17/03/22.

import Foundation
import Domain
import UI

public final class SignUpComposer {
  static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
    return ControllerFactory.makeSignUp(addAccount: addAccount)
  }
}
