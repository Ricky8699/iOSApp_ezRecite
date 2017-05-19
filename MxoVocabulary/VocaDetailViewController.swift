//
//  VocaDetailViewController.swift
//  MxoVocabulary
//
//  Created by 歐歐 on 2017/5/19.
//  Copyright © 2017年 ＭxoStudio. All rights reserved.
//

import UIKit
import AVFoundation

class VocaDetailViewController: UIViewController {
    @IBOutlet var vocaImageView:UIImageView!
    @IBOutlet var eName: UILabel!
    @IBOutlet var cName: UILabel!
    @IBOutlet var Phonetic: UILabel!
    var vocaImage = ""
    var eNameX = ""
    var cNameX = ""
    var PhoneticX = ""
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vocaImageView.image = UIImage(named: vocaImage)
        vocaImageView.layer.cornerRadius = 30
        vocaImageView.layer.borderWidth = 2
        vocaImageView.layer.borderColor = UIColor.orange.cgColor
        vocaImageView.clipsToBounds = true
        eName.text = eNameX
        cName.text = cNameX
        Phonetic.text = PhoneticX
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareBtn(_ sender: UIButton) {

            let texts = "與您分享一個英文單字...\r\n【" + self.cNameX  + "】" + self.eNameX
            if let images = UIImage(named: self.eNameX + ".jpg") {
                let acController = UIActivityViewController(activityItems: [texts, images], applicationActivities: nil)
                acController.popoverPresentationController?.sourceView = self.view
                acController.popoverPresentationController?.sourceRect = sender.frame
                self.present(acController, animated: true, completion: nil)
            }

    }
    @IBAction func speakBtn(_ sender: UIButton) {
        self.speak(speakText: self.cNameX + "," + self.eNameX , lang: "zh-TW")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
