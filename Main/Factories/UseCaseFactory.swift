//  Created by Arthur Neves on 17/03/22.

import Foundation
import Domain
import Data
import Infra

final class UseCaseFactory {
  private static let httpClient = AlamofireAdapter()
  private static let apiBaseUrl = EnvironmentHelper.variable(.apiBaseUrl)
  
  private static func makeUrl(path: String) -> URL {
    return URL(string: "\(apiBaseUrl)/\(path)")!
  }
  
  static func makeRemoteAddAccount() -> AddAccount {
    let remoteAddAccount = RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpClient)
    // Calling the use case within the decorator
    return MainQueueDispatchDecorator(remoteAddAccount)
  }
}

// Implementing a decorator
public final class MainQueueDispatchDecorator<T> {
  private let instance: T
  
  public init(_ instance: T) {
    self.instance = instance
  }
  
  func dispatch(completion: @escaping () -> Void) {
    // ensure decorator execute in Main Thread only if its not in Main Thread
    guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
    completion()
  }
}

extension MainQueueDispatchDecorator: AddAccount where T: AddAccount {
  public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
    instance.add(addAccountModel: addAccountModel) { [weak self] result in
      // ensure the useCase is executed in Main Thread
      self?.dispatch { completion(result) }
    }
  }
}
