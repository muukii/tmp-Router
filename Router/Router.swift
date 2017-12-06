//
//  Router.swift
//  Router
//
//  Created by muukii on 12/5/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation

public protocol PathType {

  associatedtype Source : Routing
  associatedtype Destination

  func apply(source: Source, completion: @escaping (RoutingResult<Destination>) -> Void)
}

public struct Path<S : Routing, D> : PathType {

  public typealias Destination = D
  public typealias Source = S

  private let _apply: (_ source: S, _ completion: @escaping (RoutingResult<D>) -> Void) -> Void

  public init(_ apply: @escaping (_ source: S, _ completion: @escaping (RoutingResult<D>) -> Void) -> Void) {
    self._apply = apply
  }

  public func apply(source: S, completion: @escaping (RoutingResult<D>) -> Void) {
    _apply(source, completion)
  }
}

public protocol Routing {

}

extension Routing {

  public var path: Paths<Self> {
    return .init(base: self)
  }
}

public struct Paths<Base> {

  public let base: Base

  init(base: Base) {
    self.base = base
  }
}

extension Routing {

  public func go<P: PathType>(to path: P, completion: @escaping (RoutingResult<P.Destination>) -> Void) where P.Source == Self {
    path.apply(source: self, completion: completion)
  }
}

public enum RoutingResult<D> {
  case success(D)
  case failure(Error)
}

public final class Router<T: Routing> where T: AnyObject {

  weak var root: T?

  public init(root: T) {
    self.root = root
  }

  public func go<P: PathType>(to path: P, completion: @escaping (RoutingResult<P.Destination>) -> Void) where P.Source == T {
    root?.go(to: path, completion: completion)
  }

  public func go<P: PathType>(to path: P, source: P.Source, completion: @escaping (RoutingResult<P.Destination>) -> Void) {
    source.go(to: path, completion: completion)
  }
}
