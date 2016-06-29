//
//  ViewController.swift
//  SIButton
//
//  Created by Shahzaib Iqbal on 29/06/2016.
//  Copyright © 2016 shahzaib. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var siButton: SIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func segmentValueChanged(sender: AnyObject) {
        let segment = sender as! UISegmentedControl
        if segment.selectedSegmentIndex == 0 {
            siButton.setToCircle()
        }
        else
        {
            siButton.setToSaqure()
        }
    }
    @IBAction func siTouchUpInside(sender: AnyObject) {
        print("Button Pressed")
    }

}

