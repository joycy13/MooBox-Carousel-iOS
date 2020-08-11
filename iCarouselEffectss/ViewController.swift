//
//  ViewController.swift
//  iCarouselEffectss
//
//  Created by Joyce on 18/06/2020.
//  Copyright © 2020 Joyce. All rights reserved.
//

import UIKit
import AVFoundation

// 🚨 ALLER DANS DEVICE -> SHAKE POUR EFFECTUER LA ROTATION DE LA BOITE 🚨

class ViewController: UIViewController {

    @IBOutlet weak var iCarouselView: iCarousel!
    var player: AVAudioPlayer = AVAudioPlayer()
    
    var listImg = [  UIImage(named: "vache"),
                    UIImage(named: "chien") ,
                    UIImage(named: "chat") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iCarouselView.type = .rotary
        iCarouselView.contentMode = .scaleAspectFill
        iCarouselView.isPagingEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }

}

extension ViewController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return listImg.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var imageView: UIImageView!
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 300))
            imageView.contentMode = .scaleAspectFit
        } else {
            imageView = view as? UIImageView
        }
        
        imageView.image = listImg[index]
        return imageView
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            print(iCarouselView.currentItemIndex)
            let index = iCarouselView.currentItemIndex
            changeWithIndex(index: index)
            player.play()
            rotationBox()
        }
    }
    
     func changeWithIndex(index: Int){
        switch index {
            
        case 0:
            animalSound(audio: "cow")
        break
        case 1:
            animalSound(audio: "dog")
        break
        case 2:
            animalSound(audio: "cat")
        break
        
        default:
          animalSound(audio: "cow")
        break
        }
    }
    
    func animalSound(audio: String) {
        
        let animal = Bundle.main.path(forResource: audio, ofType: "mp3")
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: animal!))
        } catch {
            print("ERROR !")
        }
    }
    
    func rotationBox() {
        var rotation: CGAffineTransform?
        rotation = CGAffineTransform(rotationAngle: -3)

        UIView.animate(withDuration: 1, animations: {
            self.iCarouselView.transform = rotation!
        }) { (success) in
            self.rotateBack()
        }

    }
    
    func rotateBack() {
        var rotation: CGAffineTransform?
        rotation = CGAffineTransform(rotationAngle: 0)
        
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: {
            self.iCarouselView.transform = rotation!
        }, completion: nil)
    }
    
}
