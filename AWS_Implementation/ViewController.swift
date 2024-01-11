//
//  ViewController.swift
//  AWS_Implementation
//
//  Created by Dev on 12/20/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AwsLogServices.shared.log(level: .info, message: "View Controller is initlized", data: ["Some_key": 1])
    }

}
