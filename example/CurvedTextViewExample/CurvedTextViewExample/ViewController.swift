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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(curvedTextViewTop)
        view.addSubview(curvedTextViewBottom)

        
        curvedTextViewTop.text = "Hello World!"
        curvedTextViewTop.curveRadius = 160
        curvedTextViewTop.backgroundColor = .yellow
        curvedTextViewTop.textColor = .red
        curvedTextViewTop.circlePosition = 90
        curvedTextViewTop.kern = 2
        curvedTextViewTop.font = UIFont.systemFont(ofSize: 45)
        
        curvedTextViewTop.translatesAutoresizingMaskIntoConstraints = false
        
        curvedTextViewBottom.text = "Hello World!"
        curvedTextViewBottom.curveRadius = 160
        curvedTextViewBottom.backgroundColor = .yellow
        curvedTextViewBottom.textColor = .red
        curvedTextViewBottom.circlePosition = 270
        curvedTextViewBottom.kern = 2
        curvedTextViewBottom.font = UIFont.systemFont(ofSize: 45)
        curvedTextViewBottom.textDirection = .counterclockwise
        curvedTextViewBottom.rotateCharactersAngle = 180
        
        
        curvedTextViewBottom.translatesAutoresizingMaskIntoConstraints = false
        

        let constraints = [NSLayoutConstraint.init(item: curvedTextViewTop,
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
                                                   constant: -100),
                           
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
                                                                      constant: 100)]

        view.addConstraints(constraints)
    }
}
