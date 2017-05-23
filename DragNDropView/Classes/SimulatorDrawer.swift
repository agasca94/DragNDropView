//
//  SimulatorDrawer.swift
//  Simulator
//
//  Created by Aranza Tovar on 22/05/17.
//  Copyright © 2017 Aranza Tovar. All rights reserved.
//

import UIKit
public extension SimulatorView{
    /**
     * Handle pan gestures for drawing
     */
    internal func drawWithFinger(recognizer:UIPanGestureRecognizer){
        if isDrawindEnabled{
            if recognizer.state == .began{
                listener?.setColorButtons(disabled: false)
                let _ = drawingStack.push(item: super.originalImage!)
                listener?.enableRedoColorButton()
                swiped = false
                lastPoint = recognizer.location(in: recognizer.view)
            }else if recognizer.state == .changed{
                swiped = true
                let currentPoint = recognizer.location(in: recognizer.view)
                drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }else if recognizer.state == .ended{
                listener?.setColorButtons(disabled: true)
                if !swiped {
                    drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
                }
                setStanadardImage(super.originalImage!)
                image = getImage(withBrightness: brightness)
            }
        }
    }
    
    /**
     * Draw a line between the two provided points
     */
    private func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        super.originalImage!.draw(in: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context!.setLineCap(.round)
        context!.setLineWidth(CGFloat(brushWidth))
        context!.setStrokeColor(drawingColor!)
        context!.setBlendMode(.normal)
        
        context!.strokePath()
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        super.originalImage = self.image
        self.alpha = 1.0
        UIGraphicsEndImageContext()
    }
}
