//  Created by Arthur Neves on 23/03/22.

import Foundation
import Domain

class AuthenticationSpy: Authentication {
  var authenticationModel: AuthenticationModel?
  var completion: ((Authentication.Result) -> Void)?
  
  func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
    self.authenticationModel = authenticationModel
    self.completion = completion
  }
  
  func completeWithError(_ error: DomainError) {
    completion?(.failure(error))
  }
}
