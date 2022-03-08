//  Created by Arthur Neves on 08/03/22.

import Foundation
import Domain

public final class SignUpMapper {
  static func toAddAccountModel(viewModel: SignUpViewModel) -> AddAccountModel {
    return AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
  }
}
