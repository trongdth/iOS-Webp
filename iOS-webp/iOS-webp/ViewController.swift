//
//  ViewController.swift
//  iOS-webp
//
//  Created by Trong Dinh on 2/15/18.
//  Copyright © 2018 Mroom Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imv: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imv.image = UIImage(webPAtPath: Bundle.main.path(forResource: "5D35AF5217A59F7CABC570F09F53D67B09D3F49EEB7B85242A", ofType: "webp")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

