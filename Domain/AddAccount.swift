//  Created by Arthur Neves on 20/02/22.

import Foundation

protocol AddAccount {
  func add(addAccountModel: AddAccountModel,
           completion: @escaping (Result<AccountModel, Error>) -> Void) //callback
}

struct AddAccountModel {
  var name: String
  var email: String
  var password: String
  var passwordConfirmation: String
}
