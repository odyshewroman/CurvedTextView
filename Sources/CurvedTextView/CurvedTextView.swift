//
//  CurvedTextView.swift
//  CurvedTextTest
//
//  Created by Roman Odyshew on 02.12.2021.
//

import Foundation
import UIKit

public class CurvedTextView: UIView {
    private var radianCirclePosition: CGFloat = 0
    
    private var height: CGFloat = 0
    private var width: CGFloat = 0
    
    private var internalBounds: CGRect = .zero
    
    /// The kerning of the text.
    public var kern: CGFloat = 0 {
        didSet {
            if oldValue != kern {
                calcBounds()
            }
        }
    }
    
    /// Radius of text curve In points. Couldn't be zero.
    public var curveRadius: CGFloat = 1 {
        willSet {
            if newValue == 0 {
                self.curveRadius = 0.1
            }
        }
        didSet {
            if oldValue != curveRadius {
                calcBounds()
            }
        }
    }
    
    /// Position on circle, from 0 to 360 degrees. 0 mean right circle point, 90 - top, 180 left, 360 bottom.
    public var circlePosition: Int = 90 {
        willSet {
            if newValue > 360 {
                self.circlePosition = newValue % 360
                return
            }
            
            if newValue < 0 {
                self.circlePosition = 360 + newValue % 360
                return
            }
            
            self.radianCirclePosition = CGFloat(Double(newValue) * Double.pi / 180)
            if newValue != self.circlePosition {
                calcBounds()
            }
        }
    }
    
    /// The text that will displays.
    public var text: String = "" {
        didSet {
            if oldValue != text {
                calcBounds()
            }
        }
    }
    
    /// The color of the displayed text.
    public var textColor: UIColor = .clear
    
    /// The font of the text.
    public var font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize) {
        didSet {
            if oldValue != font {
                calcBounds()
            }
        }
    }
    
    /// The direction of the text.
    public var textDirection: Direction = .clockwise
    
    override public var bounds: CGRect {
        get { return internalBounds }
        set { internalBounds = newValue }
    }
    
    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    private func calcBounds() {
        if text.isEmpty {
            internalBounds = .zero
            self.frame = internalBounds
            return
        }
        
        let size = newSize()
        internalBounds = CGRect(x: 0, y: 0, width: font.pointSize + size.maxPoint.x - size.minPoint.x, height: font.pointSize + size.maxPoint.y - size.minPoint.y)
        self.frame = internalBounds
    }
    
    override public func draw(_ rect: CGRect)  {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if let backgroundColor = self.backgroundColor {
            context.setFillColor(backgroundColor.cgColor)
            context.fill(rect)
        }
        
        let newTextSize = newSize()
        
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: rect.midX , y: newTextSize.minPoint.y)
        centreArcPerpendicular(context: context)
        
        height = font.pointSize + newTextSize.maxPoint.y - newTextSize.minPoint.y
        width = font.pointSize + newTextSize.maxPoint.x - newTextSize.minPoint.x
        
        if rect.height != height || rect.width != width {
            internalBounds = CGRect(x: 0, y: 0, width: width, height: height)
            self.frame = internalBounds
            invalidateIntrinsicContentSize()
        }
    }
}

extension CurvedTextView {
    private func centreArcPerpendicular(context: CGContext) {
        
        // *******************************************************
        // This draws the String str around an arc of radius r,
        // with the text centred at polar angle theta
        // *******************************************************
        
        let characters: [String] = text.map { String($0) } // An array of single character strings, each character in str
        let attributes = [NSAttributedString.Key.font: font, .kern: kern] as [NSAttributedString.Key : Any]
        
        // This will be the arcs subtended by each character
        var charArc: [(character: String, arc: CGFloat)] = []
        var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
        
        // Calculate the arc subtended by each letter and their total
        characters.forEach {
            let arc = chordToArc($0.size(withAttributes: attributes).width)
            charArc.append(($0, arc: arc))
            totalArc += arc
        }
        
        // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
        // or anti-clockwise (right way up at 6 o'clock)?
        let direction: CGFloat = textDirection.rawValue
        let slantCorrection: CGFloat = -.pi / 2
        
        // The centre of the first character will then be at
        // thetaI = theta - totalArc / 2 + arcs[0] / 2
        // But we add the last term inside the loop
        var thetaI = radianCirclePosition - direction * totalArc / 2
        
        // let offset = getOffset(charArc: charArc, thetaI: thetaI, direction: direction, font)
        charArc.forEach {
            // Call centerText with each character in turn.
            // Remember to add +/-90º to the slantAngle otherwise
            // the characters will "stack" round the arc rather than "text flow"
            thetaI += direction * $0.arc / 2
            centre($0.character, context: context, angle: thetaI, slantAngle: thetaI + slantCorrection)
            // The centre of the next character will then be at
            // thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
            // but again we leave the last term to the start of the next loop...
            thetaI += direction * $0.arc / 2
        }
    }
    
    private func newSize() -> (minPoint: CGPoint, maxPoint: CGPoint) {
        let attributes = [NSAttributedString.Key.font: font, .kern: kern] as [NSAttributedString.Key : Any]
        
        var charArc: [(characterSize: CGSize, arc: CGFloat)] = []
        var totalArc: CGFloat = 0
        
        charArc = text.map {
            let character = String($0)
            
            let characterSize: CGSize = character.size(withAttributes: attributes)
            let arc = chordToArc(characterSize.width)
            
            totalArc += arc
            return (characterSize: characterSize, arc: arc)
        }
        
        var thetaI = radianCirclePosition + totalArc / 2
        
        var minY: CGFloat = CGFloat.greatestFiniteMagnitude
        var minX: CGFloat = CGFloat.greatestFiniteMagnitude
        
        var maxY: CGFloat = -CGFloat.greatestFiniteMagnitude
        var maxX: CGFloat = -CGFloat.greatestFiniteMagnitude
        
        charArc.forEach {
            thetaI -= $0.arc / 2
            
            let offset = $0.characterSize
            let x = curveRadius * cos(thetaI) - (offset.width) / 2
            if x < minX {
                minX = x
            }
            
            if x > maxX {
                maxX = x
            }
            
            let y = -(curveRadius * sin(thetaI)) - (offset.height) / 2
            if y < minY {
                minY = y
            }
            
            if y > maxY {
                maxY = y
            }
            
            thetaI -= $0.arc / 2
        }
        
        return (minPoint: CGPoint(x: minX, y: minY), maxPoint: CGPoint(x: maxX, y: maxY))
    }
    
    private func chordToArc(_ chord: CGFloat) -> CGFloat {
        var val = chord / (2 * curveRadius)
        
        if val > 1.0 {
            val = 1.0
        }
        
        if val < -1.0 {
            val = -1.0
        }
        
        return 2 * asin(val)
    }
    
    private func centre(_ text: String, context: CGContext, angle theta: CGFloat, slantAngle: CGFloat) {
        // *******************************************************
        // This draws the String str centred at the position
        // specified by the polar coordinates (r, theta)
        // i.e. the x= r * cos(theta) y= r * sin(theta)
        // and rotated by the angle slantAngle
        // *******************************************************
        
        // Set the text attributes
        let attributes = [.foregroundColor: textColor,
                          .font: font,
                          .kern: kern] as [NSAttributedString.Key : Any]
        
        // Save the context
        context.saveGState()
        // Undo the inversion of the Y-axis (or the text goes backwards!)
        context.scaleBy(x: 1, y: -1)
        // Move the origin to the centre of the text (negating the y-axis manually)
        context.translateBy(x: curveRadius * cos(theta), y: -(curveRadius * sin(theta)))
        // Rotate the coordinate system
        context.rotate(by: -slantAngle)
        // Calculate the width of the text
        let offset = text.size(withAttributes: attributes)
        // Move the origin by half the size of the text
        context.translateBy (x: -(offset.width) / 2, y: -(offset.height) / 2) // Move the origin to the centre of the text (negating the y-axis manually)
        
        // Draw the text
        text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        // Restore the context
        context.restoreGState()
    }
}

extension CurvedTextView {
    public enum Direction: CGFloat {
        case clockwise = -1
        case counterclockwise = 1
    }
}
