//
//  VocaDetailViewController.swift
//  MxoVocabulary
//
//  Created by 歐歐 on 2017/5/19.
//  Copyright © 2017年 ＭxoStudio. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
class VocaDetailViewController: UIViewController {
    
    @IBOutlet var vocaImageView: UIImageView!
    @IBOutlet var eName: UILabel!
    @IBOutlet var cName: UILabel!
    @IBOutlet var Phonetic: UILabel!
    var isMark = false
    var Voca : VocaModel!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func getContext()->NSManagedObjectContext{
        let appDelegate=UIApplication.shared.delegate as!AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func markVoca (forEName:String) -> Bool{
        
        let context = getContext()
        let request : NSFetchRequest<VocaModel> = VocaModel.fetchRequest()
        request.predicate = NSPredicate(format: "eName = %@", forEName)
        
        do {
            let cd_voca = try getContext().fetch(request)
            let cdv = cd_voca[0]
            
            cdv.setValue(!cdv.marked, forKey: "marked")
            try context.save()
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func speak(speakText: String, lang : String) {
        if !speechSynthesizer.isSpeaking {
            let speechUtterance = AVSpeechUtterance(string: speakText)
            //speechUtterance.rate = rate
            speechUtterance.pitchMultiplier = 1.0
            speechUtterance.volume = 1.0
            speechUtterance.postUtteranceDelay = 0.005
            speechUtterance.voice = AVSpeechSynthesisVoice(language: lang)
            speechSynthesizer.speak(speechUtterance)
        }
    }
    
    func markIt(){
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "icon_star")?.image(alpha: (isMark) ? 1.0 : 0.2), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.markBtn), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = Voca.eName
        vocaImageView.image = UIImage(data: Voca.img! as Data)
        //vocaImageView.layer.cornerRadius = 30
        //vocaImageView.layer.borderWidth = 2
        //vocaImageView.layer.borderColor = UIColor.orange.cgColor
        //vocaImageView.clipsToBounds = true
        eName.text = Voca.eName
        cName.text = Voca.cName
        Phonetic.text = "[" + Voca.phonetic! + "]"
        isMark = Voca.marked
        markIt()
    }

    func markBtn() {
        if self.markVoca(forEName: self.Voca.eName!){
            isMark = !isMark
            markIt()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func shareBtn(_ sender: UIButton) {
            let texts = "與您分享一個英文單字...\r\n【" + self.Voca.cName! + "】" + self.Voca.eName!
            if let images = UIImage(data: Voca.img! as Data) {
                let acController = UIActivityViewController(activityItems: [texts, images], applicationActivities: nil)
                acController.popoverPresentationController?.sourceView = self.view
                acController.popoverPresentationController?.sourceRect = sender.frame
                self.present(acController, animated: true, completion: nil)
            }

    }
    @IBAction func speakBtn(_ sender: UIButton) {
        self.speak(speakText: self.Voca.cName! + "," + self.Voca.eName! , lang: "zh-TW")
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  false
    }
    

}
