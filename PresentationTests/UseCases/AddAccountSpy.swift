//  Created by Arthur Neves on 08/03/22.

import Foundation
import Domain

class AddAccountSpy: AddAccount {
  var addAccountModel: AddAccountModel?
  var completion: ((AddAccount.Result) -> Void)?
  
  func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
    self.addAccountModel = addAccountModel
    self.completion = completion
  }
  
  func completeWithAccount(_ account: AccountModel) {
    completion?(.success(account))
  }
  
  func completeWithError(_ error: DomainError) {
    completion?(.failure(error))
  }
}
