//
//  SimulatorProtocol.swift
//  Simulator
//
//  Created by Aranza Tovar on 22/05/17.
//  Copyright © 2017 Aranza Tovar. All rights reserved.
//

import Foundation
/**
 *Callbacks used to notify the view controller of any interesting event
 */
public protocol SimulatorCallback{
    func enableButton()
    func enableRedoColorButton()
    func setColorButtons(disabled: Bool)
}
