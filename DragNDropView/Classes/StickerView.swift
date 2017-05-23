//
//  StickerView.swift
//  Ornametria-iOS
//
//  Created by Aranza Tovar on 10/04/17.
//  Copyright © 2017 brounie. All rights reserved.
//

import UIKit


public class StickerView: FilterableImage, UIGestureRecognizerDelegate {
    
    var stickerCallback: StickerCallback?
    var isSelected: Bool = false
    
    var move: UIPanGestureRecognizer!
    var pinch: UIPinchGestureRecognizer!
    var rotate: UIRotationGestureRecognizer!
    var select: UITapGestureRecognizer!
    
    public override init(image: UIImage?)
    {
        super.init(image: image)
        
        contentMode = .scaleAspectFit
        
        move = UIPanGestureRecognizer(target: self, action:#selector(self.moveTo))
        move.delegate = self
        addGestureRecognizer(move)
        
        pinch = UIPinchGestureRecognizer(target: self, action:#selector(self.resize(recognizer:)))
        pinch.delegate = self
        addGestureRecognizer(pinch)
        
        rotate = UIRotationGestureRecognizer(target: self, action:#selector(self.rotate(recognizer:)))
        rotate.delegate = self
        addGestureRecognizer(rotate)
        
        select = UITapGestureRecognizer(target: self, action: #selector(self.selectMe))
        select.delegate = self
        addGestureRecognizer(select)
        
        select.require(toFail: pinch)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectSticker(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func deselectSticker(){
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func selectMe(recognizer: UITapGestureRecognizer){
        isSelected = !isSelected
        if isSelected{
            stickerCallback?.didSelectSticker(selectedSticker: self)
        }else{
            self.deselectSticker()
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func moveTo(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.superview)
        if let view = recognizer.view {
            let initialPosition = view.center
            if recognizer.state == .began{
                stickerCallback?.didStartTranslation(sticker: self, position: initialPosition)
            }
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.superview)
    }
    
    func resize(recognizer:UIPinchGestureRecognizer){
        if let view = recognizer.view {
            let initialTransform = view.transform
            if recognizer.state == .began{
                stickerCallback?.didStartTranformation(sticker: self, transform: initialTransform)
            }
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    func rotate(recognizer : UIRotationGestureRecognizer){
        if let view = recognizer.view {
            let initialTransform = view.transform
            if recognizer.state == .began{
                stickerCallback?.didStartTranformation(sticker: self, transform: initialTransform)
            }
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    func restore(withTransform transform: CGAffineTransform, withPosition position: CGPoint){
        self.transform = transform
        self.center = position
    }
}

protocol StickerCallback{
    func didSelectSticker(selectedSticker: StickerView)
    
    func didStartTranformation(sticker: StickerView, transform: CGAffineTransform)
    func didStartTranslation(sticker: StickerView, position: CGPoint)
}
