//
//  SimulatorCallbacks.swift
//  Simulator
//
//  Created by Aranza Tovar on 22/05/17.
//  Copyright © 2017 Aranza Tovar. All rights reserved.
//

import UIKit
/**
 *Callbacks implemented by the simulator for it to react to sticker events
 */
extension SimulatorView: StickerCallback{
    /**
     *Push the previous position of the sticker inside the Movement Stack
     */
    func didStartTranslation(sticker: StickerView, position: CGPoint) {
        let _ = movementsStack.push(item: Movement(sticker: sticker, withPosition: position))
        listener?.enableButton()
    }
    
    /**
     *Push the previous transform of the sticker inside the Movement Stack
     */
    func didStartTranformation(sticker: StickerView, transform: CGAffineTransform){
        let _ = movementsStack.push(item: Movement(sticker: sticker, withTransform: transform))
        listener?.enableButton()
    }
    
    /**
     *Select the specified sticker and deselect any other one
     */
    func didSelectSticker(selectedSticker: StickerView) {
        self.selectedSticker = selectedSticker
        for sticker in self.subviews{
            if let sticker = sticker as? StickerView{
                
                if sticker == selectedSticker{
                    sticker.isSelected = true
                    sticker.selectSticker()
                }else{
                    sticker.isSelected = false
                    sticker.deselectSticker()
                }
            }
        }
    }
}
