//  Created by Arthur Neves on 17/03/22.

import Foundation
import Domain
import UI

public final class SignUpComposer {
  public static func composeControllerWith(_ addAccount: AddAccount) -> SignUpViewController {
    return ControllerFactory.makeSignUpViewController(addAccount: addAccount)
  }
}
