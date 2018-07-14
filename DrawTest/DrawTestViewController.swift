//
//  ViewController.swift
//  DrawTest
//
//  Created by Bernhard F. Kraft on 08.07.18.
//  Copyright © 2018 Bernhard F. Kraft. All rights reserved.
//

import UIKit

class DrawTestViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView!{
        didSet {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: drawView, action: #selector(drawView.handleSwipe(recognizer:)))
            drawView.addGestureRecognizer(swipeGestureRecognizer)
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: drawView, action: #selector(drawView.handlePinch(recognizer:)))
            drawView.addGestureRecognizer(pinchGestureRecognizer)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}


