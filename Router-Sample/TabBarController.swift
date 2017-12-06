//
//  TabBarController.swift
//  Router-Sample
//
//  Created by muukii on 12/5/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import UIKit

import Router

class TabBarController : UITabBarController, Routing {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewControllers = [
      A_ChildViewController(),
      B_ChildViewController(),
      C_ChildViewController(),
    ]
  }
}

extension Paths where Base : TabBarController {

  func aTab() -> Path<TabBarController, TabBarController.A_ChildViewController> {
    return .init { source, completion in

      source.selectedIndex = 0
      completion(.success(source.selectedViewController as! TabBarController.A_ChildViewController))
    }
  }

  func bTab() -> Path<TabBarController, TabBarController.B_ChildViewController> {
    return .init { source, completion in

      source.selectedIndex = 1
      completion(.success(source.selectedViewController as! TabBarController.B_ChildViewController))
    }
  }

  func cTab() -> Path<TabBarController, TabBarController.C_ChildViewController> {
    return .init { source, completion in

      source.selectedIndex = 2
      completion(.success(source.selectedViewController as! TabBarController.C_ChildViewController))
    }
  }
}

extension TabBarController {

  class A_ChildViewController : ColorController {
    init() {
      super.init(color: .init(white: 0.9, alpha: 1))
      title = "A"
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      let button = UIButton(type: .system)
      button.setTitle("A", for: .normal)
      button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)

      let stack = UIStackView()
      stack.addArrangedSubview(button)

      view.addSubview(stack)

      stack.translatesAutoresizingMaskIntoConstraints = false
      stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

    @objc
    private func tapButton() {

      let tab = (tabBarController as! TabBarController)

      tab.go(to: tab.path.bTab()) { r in
        guard case .success(let c) = r else { return }
        c.go(to: c.path.modal()) { r in
          guard case .success(let c) = r else { return }
          c.go(to: c.path.modal()) { r in

          }
        }
      }

    }
  }

  class B_ChildViewController : ColorController, Routing {

    init() {
      super.init(color: .init(white: 0.8, alpha: 1))
      title = "B"
    }
  }

  class C_ChildViewController : ColorController {
    init() {
      super.init(color: .init(white: 0.7, alpha: 1))
      title = "C"
    }
  }
}

extension Paths where Base : TabBarController.B_ChildViewController {

  func modal() -> Path<TabBarController.B_ChildViewController, A_ModalViewController> {
    return .init { s, c in

      let controller = A_ModalViewController.init()
      s.present(controller, animated: true, completion: {
        c(.success(controller))
      })
    }
  }
}

class A_ModalViewController : ColorController, Routing {

  init() {
    super.init(color: UIColor(hue:0.47, saturation:0.53, brightness:0.54, alpha:1.00))
  }
}

extension Paths where Base : A_ModalViewController {

  func modal() -> Path<A_ModalViewController, B_ModalViewController> {
    return .init { s, c in

      let controller = B_ModalViewController.init()
      s.present(controller, animated: true, completion: {
        c(.success(controller))
      })
    }
  }

}

class B_ModalViewController : ColorController {

  init() {
    super.init(color: UIColor(hue:0.52, saturation:0.53, brightness:0.54, alpha:1.00))
  }
}



