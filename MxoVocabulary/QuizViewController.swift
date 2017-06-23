//
//  QuizViewController.swift
//  MxoVocabulary
//
//  Created by 歐歐 on 2017/6/22.
//  Copyright © 2017年 ＭxoStudio. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class QuizViewController: UIViewController {
    var VocaList : [VocaModel] = []
    
    
    @IBOutlet var vocaImageView: UIImageView!
    @IBOutlet var cName: UILabel!
    
    
    @IBOutlet var ansBtn1: UIButton!
    @IBOutlet var ansBtn2: UIButton!
    @IBOutlet var ansBtn3: UIButton!
    
    
    
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
    
    func createRandom(start: Int, end: Int) ->() ->Int! {
        var nums = [Int]();
        for i in start...end{
            nums.append(i)
        }
        
        func randomMan() -> Int! {
            if !nums.isEmpty {
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.remove(at: index)
            }else {
                return nil
            }
        }
        
        return randomMan
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func ClickAnsBtn(_ sender: UIButton) {
        var title  = ""
        if sender.currentTitle == Voca.eName {
            title = "恭喜你答對了！"
        }else{
            title = "答錯了，請再接再厲！"
        }
        let optionMenu = UIAlertController(title: title , message : "這題的答案是「" + Voca.eName! + "」", preferredStyle: .alert)
        optionMenu.addAction(UIAlertAction(title: "確定" , style: .default ,  handler: {
            (action: UIAlertAction!) in
            self.newVoca()
        }))
        // support iPad
        optionMenu.popoverPresentationController?.sourceView = self.view
        optionMenu.popoverPresentationController?.sourceRect = sender.frame
        self.present(optionMenu, animated: true,completion: nil)

    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  false
        getVoca()
        newVoca()
    }
    
    func getVoca(){
        let request : NSFetchRequest<VocaModel> = VocaModel.fetchRequest()
        let context = getContext()
        do {
            VocaList = try context.fetch(request)
        }catch{
            print(error)
        }
    }
    @IBAction func newBtn(_ sender: UIButton) {
        newVoca()
    }

    func newVoca(){
        let random_index = Int(arc4random() % UInt32(VocaList.count))
        self.Voca = VocaList[random_index]
        self.cName.text = Voca.cName
        self.vocaImageView.image = UIImage(data: Voca.img! as Data)
        self.title = "學習測驗"
        self.isMark = Voca.marked
        let randomNum  = createRandom(start: 0,end: (VocaList.count-1))
        let randomView  = createRandom(start: 0,end: 2)
        
        var optionItem = [Voca.eName,VocaList[randomNum()].eName,VocaList[randomNum()].eName]
        self.ansBtn1.setTitle(optionItem[randomView()], for: .normal)
        self.ansBtn2.setTitle(optionItem[randomView()], for: .normal)
        self.ansBtn3.setTitle(optionItem[randomView()], for: .normal)
        
        markIt()
    }

}
