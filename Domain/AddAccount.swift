//  Created by Arthur Neves on 20/02/22.

import Foundation

public protocol AddAccount {
  func add(addAccountModel: AddAccountModel,
           completion: @escaping (Result<AccountModel, Error>) -> Void) //callback
}

public struct AddAccountModel {
  public var name: String
  public var email: String
  public var password: String
  public var passwordConfirmation: String
}
