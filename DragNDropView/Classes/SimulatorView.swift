//
//  Simulator.swift
//  Ornametria-iOS
//
//  Created by Arturo Gasca on 11/04/17.
//  Copyright © 2017 brounie. All rights reserved.
//
import UIKit
public class SimulatorView: FilterableImage, UIGestureRecognizerDelegate {
    //Brush width
    public var brushWidth: Float = 9
    
    //Stacks used to redo previous movements or drawings
    internal var movementsStack: Stack<Movement> = Stack()
    internal var drawingStack: Stack<UIImage> = Stack()
    
    //Callback used to notify the View Controller when an event of interest ocurrs
    internal var listener: SimulatorCallback?
    
    //Sticker selected by the user if any
    internal var selectedSticker: StickerView?
    
    //Drawing attributes
    internal var isDrawindEnabled: Bool = false
    internal var panRecognizer: UIPanGestureRecognizer!
    internal var drawingColor: CGColor?
    internal var lastPoint = CGPoint.zero
    internal var swiped = false
    
    /**
     *Initializes the simulator
     */
    public func initialize(withListener listener: SimulatorCallback? = nil, withBackground background: UIImage? = nil){
        super.isUserInteractionEnabled = true
        self.listener = listener
        
        panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(SimulatorView.drawWithFinger))
        panRecognizer.delegate = self
        super.addGestureRecognizer(panRecognizer)
        
        if let background = background{
            setBackground(background)
        }
    }
    
    /**
     * Set new background
     */
    public func setBackground(_ image: UIImage){
        super.image = image
        super.initBrightnessHandling()
    }
    
    /**
     *Add a new sticker in the simulator within the specified frame
     */
    public func addSticker(sticker: StickerView, inFrame newFrame: CGRect, addToStack shouldAddToStack: Bool = false){
        sticker.frame = newFrame
        restoreSticker(sticker: sticker)
        if shouldAddToStack{
            let _ = movementsStack.push(item: Movement(sticker: sticker))
            listener?.enableButton()
        }
    }
    
    /**
     * Enable drawing functionality with the given color and line width
     */
    public  func enableDrawing(withColor color: UIColor, withWidth width: Float = 9){
        isDrawindEnabled = true
        brushWidth = width
        drawingColor = color.cgColor
        //Hide all the stickers during drawing
        for view in self.subviews{
            if let view = view as? StickerView{
                view.isHidden = true
            }
        }
    }
    
    /**
     *Delete all the previous drawings done by the user
     */
    public func deleteDrawings(){
        var image: UIImage?
        repeat{
            image = drawingStack.pop()
        }while !drawingStack.isEmpty()
        if let image = image{
            setStanadardImage(image)
            self.image = getImage(withBrightness: brightness)
        }
    }
    
    /**
     *Delete the sticker currently selected by the user if any
     */
    public func deleteSticker(){
        if let selectedSticker = selectedSticker{
            selectedSticker.removeFromSuperview()
            let _ = movementsStack.push(item: Movement(sticker: selectedSticker, withPosition: selectedSticker.center, withTransform: selectedSticker.transform))
            listener?.enableButton()
            self.selectedSticker = nil
        }
    }
    
    /**
     * Disable drawing functionality
     */
    public func disableDrawing(){
        isDrawindEnabled = false
        //Show all the stickers hidden during drawing
        for view in self.subviews{
            if let view = view as? StickerView{
                view.isHidden = false
            }
        }
    }
    
    /**
     *Undo the last drawing done by the user
     */
    public func undoDrawing(){
        if !drawingStack.isEmpty(){
            let image = drawingStack.pop()!
            setStanadardImage(image)
            self.image = getImage(withBrightness: brightness)
        }
    }
    
    /**
     *Undo the last movement done by the user
     */
    public func undoMovement(){
        if !movementsStack.isEmpty(){
            let movement = movementsStack.pop()!
            let movementType = movement.movementType
            if movementType == .translation{
                let sticker = movement.sticker
                sticker?.center = movement.position!
            }else if movementType == .transform{
                let sticker = movement.sticker
                sticker?.transform = movement.transform!
            }else if movementType == .add{
                let sticker = movement.sticker
                sticker?.removeFromSuperview()
            } else if movementType == .delete{
                let sticker = movement.sticker
                sticker?.center = movement.position!
                sticker?.transform = movement.transform!
                self.restoreSticker(sticker: sticker!)
            }
        }
    }
    
    /**
     * Check if there are more movements or drawings to be undone
     */
    public func hasMoreMovements()->Bool{
        return !movementsStack.isEmpty()
    }
    
    public func hasMoreDrawings()->Bool{
        return !drawingStack.isEmpty()
    }
    
    /**
     *Restore a previously deleted sticker in the simulator within its original frame
     */
    internal func restoreSticker(sticker: StickerView){
        sticker.isUserInteractionEnabled = true
        sticker.stickerCallback = self
        panRecognizer.require(toFail: sticker.move)
        self.addSubview(sticker)
        if brightness != 0{
            sticker.adjust(brightness: brightness)
        }
    }
}
