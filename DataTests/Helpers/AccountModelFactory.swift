//  Created by Arthur Neves on 23/02/22.

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
  AccountModel(id: "any_id", name: "any_name", email: "any_email", password: "any_pswd")
}

func makeAddAccountModel() -> AddAccountModel {
  AddAccountModel(name: "any_name", email: "any_email@mail.com", password: "any_pswd", passwordConfirmation: "any_pswd")
}
