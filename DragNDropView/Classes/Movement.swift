//
//  Movement.swift
//  Ornametria-iOS
//
//  Created by Aranza Tovar on 11/04/17.
//  Copyright © 2017 brounie. All rights reserved.
//

import UIKit

public enum MovementType{
    case translation
    case transform
    case add
    case delete
}

public class Movement{
    //Sticker associated with the movement
    var sticker: StickerView?
    //Transformation (rotation and scale) and Position of the Sticker
    var transform: CGAffineTransform?
    var position: CGPoint?
    
    //Movement type
    var movementType: MovementType
    
    //Transform movement (rotation or scale)
    init(sticker: StickerView, withTransform transform: CGAffineTransform){
        self.sticker = sticker
        movementType = .transform
        self.transform = transform
    }
    
    //Translation movement
    init(sticker: StickerView, withPosition position: CGPoint){
        self.sticker = sticker
        movementType = .translation
        self.position = position
    }
    
    //New sticker movement
    init(sticker: StickerView){
        self.sticker = sticker
        movementType = .add
    }
    
    //Delete sticker movement
    init(sticker: StickerView, withPosition position: CGPoint, withTransform transform: CGAffineTransform){
        self.sticker = sticker
        movementType = .delete
        self.position = position
        self.transform = transform
    }
}
