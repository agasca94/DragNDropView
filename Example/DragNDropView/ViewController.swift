//
//  ViewController.swift
//  DragNDropView
//
//  Created by ArturoGasca on 05/23/2017.
//  Copyright (c) 2017 ArturoGasca. All rights reserved.
//

import UIKit
import DragNDropView

class ViewController: UIViewController, SimulatorCallback {

    @IBOutlet weak var simulator: SimulatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let sticker1 = StickerView(image: #imageLiteral(resourceName: "boat1"))
        let sticker2 = StickerView(image: #imageLiteral(resourceName: "boat2"))
        let background = #imageLiteral(resourceName: "back")
        
        //You must always initialize the simulator with a listener and a image background (though both parameters are optional)
        simulator.initialize(withListener: self, withBackground: background)
        
        //You can set another image background
        //simulator.setBackground(background2)
        
        //Add some stickers to the view
        simulator.addSticker(sticker: sticker1, inFrame: CGRect(x: 10, y: 10, width: 90, height: 90))
        simulator.addSticker(sticker: sticker2, inFrame: CGRect(x: 200, y: 160, width: 90, height: 90))
        
        //Undo the last movement done by the user
        simulator.undoMovement()
     
        //Delete the current sticker selected by the user (to select a sticker the user must tap it)
        simulator.deleteSticker()
        
        //Adjust level of brightness of the simulator and its child stickers
        simulator.adjust(brightness: 0.2)
        simulator.adjust(brightness: -0.2)
        
        //Enable or disable drawing capability with the given color and brush width
        simulator.enableDrawing(withColor: UIColor.red, withWidth: 3)
        simulator.disableDrawing()
        
        //Undo the last drawing done by the user
        simulator.undoDrawing()
        
        //Delete all the drawings done by the user
        simulator.deleteDrawings()
        
        //Check if the simulator has more drawings or movement to be undone
        simulator.hasMoreDrawings()
        simulator.hasMoreMovements()
    }
    
    
    
    
    //Callbacks of events of interest
    func enableButton(){
        //Here you should enable a "redo" button in the UI
    }
    func enableRedoColorButton(){
        //Here you should enable a "redo drawing" button in the UI
    }
    func setColorButtons(disabled: Bool){
        //Not so important
    }
}
