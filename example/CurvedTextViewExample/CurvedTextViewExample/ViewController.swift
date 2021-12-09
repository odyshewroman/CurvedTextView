//
//  ViewController.swift
//  CurvedTextViewExample
//
//  Created by Roman Odyshew on 07.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let curvedTextViewTop = CurvedTextView()
    private let curvedTextViewBottom = CurvedTextView()
    private let curvedTextViewLeft = CurvedTextView()
    private let curvedTextViewRight = CurvedTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(curvedTextViewTop)
        view.addSubview(curvedTextViewBottom)
        view.addSubview(curvedTextViewLeft)
        view.addSubview(curvedTextViewRight)
        
        curvedTextViewTop.text = "Hello World Top!"
        curvedTextViewTop.backgroundColor = .yellow
        curvedTextViewTop.curveRadius = 160
        curvedTextViewTop.textColor = .red
        curvedTextViewTop.circlePosition = 90
        curvedTextViewTop.kern = 2
        curvedTextViewTop.font = UIFont.systemFont(ofSize: 25)
        curvedTextViewTop.translatesAutoresizingMaskIntoConstraints = false
        
        curvedTextViewLeft.text = "Hello World Left!"
        curvedTextViewLeft.backgroundColor = .yellow
        curvedTextViewLeft.curveRadius = 160
        curvedTextViewLeft.textColor = .red
        curvedTextViewLeft.circlePosition = 180
        curvedTextViewLeft.kern = 2
        curvedTextViewLeft.font = UIFont.systemFont(ofSize: 25)
        curvedTextViewLeft.translatesAutoresizingMaskIntoConstraints = false
        
        curvedTextViewRight.text = "Hello World Right!"
        curvedTextViewRight.backgroundColor = .yellow
        curvedTextViewRight.curveRadius = 160
        curvedTextViewRight.textColor = .red
        curvedTextViewRight.circlePosition = 0
        curvedTextViewRight.kern = 2
        curvedTextViewRight.font = UIFont.systemFont(ofSize: 25)
        curvedTextViewRight.translatesAutoresizingMaskIntoConstraints = false
        
        curvedTextViewBottom.text = "Hello World Bottom!"
        curvedTextViewBottom.backgroundColor = .yellow
        curvedTextViewBottom.curveRadius = -160
        curvedTextViewBottom.textColor = .red
        curvedTextViewBottom.circlePosition = 90
        curvedTextViewBottom.kern = 2
        curvedTextViewBottom.font = UIFont.systemFont(ofSize: 25)
        curvedTextViewBottom.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .yellow
        
        let constraints = [
            NSLayoutConstraint.init(item: curvedTextViewTop,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0),
            
            NSLayoutConstraint.init(item: curvedTextViewTop,
                                    attribute: .centerY,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerY,
                                    multiplier: 1,
                                    constant: -150),
            
            NSLayoutConstraint.init(item: curvedTextViewLeft,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: -150),
            
            NSLayoutConstraint.init(item: curvedTextViewLeft,
                                    attribute: .centerY,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerY,
                                    multiplier: 1,
                                    constant: 0),
            
            NSLayoutConstraint.init(item: curvedTextViewRight,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 140),
            
            NSLayoutConstraint.init(item: curvedTextViewRight,
                                    attribute: .centerY,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerY,
                                    multiplier: 1,
                                    constant: 0),
            
            NSLayoutConstraint.init(item: curvedTextViewBottom,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0),
            
            NSLayoutConstraint.init(item: curvedTextViewBottom,
                                    attribute: .centerY,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerY,
                                    multiplier: 1,
                                    constant: 150)
        ]
        
        view.addConstraints(constraints)
    }
}
