//  Created by Arthur Neves on 19/03/22.

import Foundation
import Domain

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
  public func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
    instance.add(addAccountModel: addAccountModel) { [weak self] result in
      // ensure the useCase is executed in Main Thread
      self?.dispatch { completion(result) }
    }
  }
}
