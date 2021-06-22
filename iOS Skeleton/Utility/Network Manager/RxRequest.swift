//
//  RxRequest.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 22/06/21.
//

import UIKit
import RxSwift
import RxCocoa



public extension ObservableType where Element == String {
  func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> Observable<T> where T: Decodable {
    return self
      .map { string in string.data(using: .utf8) ?? Data() }
      .map(type, using: decoder)
  }
}
public extension ObservableType where Element == Data {
  func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> Observable<T> where T: Decodable {
    return self.map { data -> T in
      let decoder = decoder ?? JSONDecoder()
      return try decoder.decode(type, from: data)
    }
  }
}
