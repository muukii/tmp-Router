//
//  ViewController.swift
//  Router-Sample
//
//  Created by muukii on 12/5/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import UIKit

import Router

class ColorController: UIViewController {

  init(color: UIColor) {
    super.init(nibName: nil, bundle: nil)

    view.backgroundColor = color
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
