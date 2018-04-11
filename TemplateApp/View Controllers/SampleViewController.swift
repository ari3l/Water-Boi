//
//  ViewController.swift
//  TemplateApp
//
//  Created by Ariel Steinlauf on 4/8/18.
//  Copyright © 2018 Ariels Apps LLC. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Sample View Controller"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
