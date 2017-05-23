//
//  ImageExtension.swift
//  Ornametria-iOS
//
//  Created by Aranza Tovar on 20/04/17.
//  Copyright © 2017 brounie. All rights reserved.
//

import UIKit

public class FilterableImage: UIImageView {
    //Fields used to apply brightness
    private var brightnessFilter: CIFilter!
    private var context: CIContext?
    
    //Original image (with 0 brightness) to which apply the filter of brightness
    public var originalImage: UIImage?
    
    //Current level of brightness of the image
    public var brightness: Float = 0
    
    override init(image:UIImage?){
        super.init(image: image)
        if self.image != nil{
            initBrightnessHandling()
        }
    }
    
    /**
     *Set a new original image (with 0 brightness) to the filter
     */
    public func setStanadardImage(_ image:UIImage){
        originalImage = image
        let aCIImage = CIImage(cgImage: image.cgImage!)
        brightnessFilter.setValue(aCIImage, forKey: "inputImage")
    }
    
    /**
     *Initialize the brightness filter
     */
    public func initBrightnessHandling(){
        context = CIContext(options: nil)
        brightnessFilter = CIFilter(name: "CIColorControls")
        setStanadardImage(self.image!)
    }
    
    /**
     *Produces a new image (from the original image) with the specified brightness
     */
    public func getImage(withBrightness brightness: Float)->UIImage{
        brightnessFilter.setValue(NSNumber(value: brightness), forKey: "inputBrightness")
        let outputImage = brightnessFilter.outputImage
        
        let imageRef = context?.createCGImage(outputImage!, from: outputImage!.extent)
        let newUIImage = UIImage(cgImage: imageRef!)
        return newUIImage
        
    }
    
    /**
     *Changes the brightness level of the original image
     */
    public func adjust(brightness: Float){
        self.brightness = brightness
        let newUIImage = getImage(withBrightness: brightness)
        self.image = newUIImage
        
        for sv in self.subviews{
            if let sv = sv as? FilterableImage{
                sv.adjust(brightness: brightness)
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if self.image != nil{
            initBrightnessHandling()
        }
    }
}
