//
//  VocaTableViewController.swift
//  MxoVocabulary
//
//  Created by 歐歐 on 2017/4/21.
//  Copyright © 2017年 ＭxoStudio. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class VocaTableViewController: UITableViewController {

    
    
    var mycontext : NSManagedObjectContext!
    
    func getContext()->NSManagedObjectContext{
        let appDelegate=UIApplication.shared.delegate as!AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var VocaList : [VocaModel] = []
    
    func addVoca(eName: String , cName: String , phonetic: String , img: String){
        let context = getContext()
        var Voca : VocaModel!
        Voca = VocaModel(context: getContext())
        Voca.eName = eName
        Voca.cName = cName
        Voca.phonetic = phonetic
        if let vocaImg = UIImage(named: img){
            if let imgData = UIImageJPEGRepresentation(vocaImg, 1.0){
                Voca.img = NSData(data: imgData)
            }
        }
        do {
            try context.save()
            print(Voca.eName! + " add OK!")
        } catch {
            print(error)
        }
    }
    
    func getVoca(){
        let request : NSFetchRequest<VocaModel> = VocaModel.fetchRequest()
        let context = getContext()
        do {
            VocaList = try context.fetch(request)
            /*for Voca in VocaList{
                print(Voca.eName! + " is loading...")
            }*/
            print("Total: " + String(VocaList.count))
        }catch{
            print(error)
        }
    }
    func delVoca(){
        let request : NSFetchRequest<VocaModel> = VocaModel.fetchRequest()
        let context = getContext()
        do {
            VocaList = try context.fetch(request)
            for Voca in VocaList{
                context.delete(Voca)
            }
            try context.save()
        }catch{
            print(error)
        }
    }
    var InitVoca : [Voca] = [
        Voca(eName: "jam", cName: "果醬", phonetic: "dʒæm", img: "jam.jpg") ,
        Voca(eName: "joke", cName: "笑話", phonetic: "dʒok", img: "joke.jpg") ,
        Voca(eName: "jacket", cName: "夾克", phonetic: "ˋdʒækIt", img: "jacket.jpg") ,
        Voca(eName: "judge", cName: "法官", phonetic: "dʒʌdʒ", img: "judge.jpg") ,
        Voca(eName: "jail", cName: "噴射機", phonetic: "dʒel", img: "jail.jpg") ,
        Voca(eName: "jet", cName: "珠寶", phonetic: "dʒZt",img: "jet.jpg") ,
        Voca(eName: "jewelry", cName: "日誌", phonetic: "ˋdʒuәlrI", img: "jewelry.jpg") ,
        Voca(eName: "journal", cName: "監獄", phonetic: "ˋdʒFnL", img: "journal.jpg") ,
        Voca(eName: "journey", cName: "旅行", phonetic: "ˋdʒFnI", img: "journey.jpg") ,
        Voca(eName: "jungle", cName: "叢林", phonetic: "ˋdʒʌŋgL", img: "jungle.jpg") ,
        Voca(eName: "junk", cName: "垃圾", phonetic: "dʒʌŋk", img: "junk.jpg") ,
        Voca(eName: "justice", cName: "公平", phonetic: "ˋdʒʌstIs", img: "justice.jpg") ,
        Voca(eName: "job", cName: "工作", phonetic: "dʒɑb", img: "job.jpg") ,
        Voca(eName: "jump", cName: "跳", phonetic: "dʒʌmp", img: "jump.jpg") ,
        Voca(eName: "jelly", cName: "果凍", phonetic: "ˋdʒɛlɪ", img: "jelly.jpg") ,
        Voca(eName: "juice", cName: "果汁", phonetic: "dʒus", img: "juice.jpg") ,
        Voca(eName: "jeans", cName: "牛仔褲", phonetic: "dʒinz", img: "jeans.jpg") ,
        Voca(eName: "jog", cName: "慢跑", phonetic: "dʒɑg", img: "jog.jpg") ,
        Voca(eName: "joy", cName: "歡樂", phonetic: "dʒɔɪ", img: "joy.jpg") ,
        Voca(eName: "jug", cName: "水壺", phonetic: "dʒʌg", img: "jug.jpg") ,
        Voca(eName: "jury", cName: "陪審團", phonetic: "ˈdʒʊrɪ", img: "jury.jpg") ,
        Voca(eName: "jazz", cName: "爵士樂", phonetic: "dʒæz", img: "jazz.jpg") ,
        Voca(eName: "jacana", cName: "水雉", phonetic: "͵ʒɑsəˋnɑ", img: "jacana.jpg") ,
        Voca(eName: "jackboot", cName: "長筒靴", phonetic: "ˋdʒæk͵but", img: "jackboot.jpg") ,
        Voca(eName: "jackal", cName: "豺狼", phonetic: "ˋdʒækɔl", img: "jackal.jpg") ,
        Voca(eName: "jackfruit", cName: "菠蘿蜜", phonetic: "ˋdʒæk͵frut", img: "jackfruit.jpg") ,
        Voca(eName: "jackshaft", cName: "起重機", phonetic: "ˋdʒæk͵ʃæft", img: "jackshaft.jpg") ,
        Voca(eName: "jacal", cName: "小茅屋", phonetic: "hɑˋkɑl", img: "jacal.jpg") ,
        Voca(eName: "jackknife", cName: "摺疊刀", phonetic: "ˋdʒæk͵naɪf", img: "jackknife.jpg") ,
        Voca(eName: "jamb", cName: "門邊框柱", phonetic: "dʒæm", img: "jamb.jpg")
    ]
 
    /*
    var VocaArr : [[String : String]] = [
        
        [
            "cName" : "果醬",
            "eName" : "jam",
            "Phonetic" : "dʒæm"
        ],
        [
            "cName" : "笑話",
            "eName" : "joke",
            "Phonetic" : "dʒok"
        ],
        [
            "cName" : "夾克",
            "eName" : "jacket",
            "Phonetic" : "ˋdʒækIt"
        ],
        [
            "cName" : "法官",
            "eName" : "judge",
            "Phonetic" : "dʒʌdʒ"
        ],
        [
            "cName" : "監獄",
            "eName" : "jail",
            "Phonetic" : "dʒel"
        ],
        [
            "cName" : "噴射機",
            "eName" : "jet",
            "Phonetic" : "dʒZt"
        ],
        [
            "cName" : "珠寶",
            "eName" : "jewelry",
            "Phonetic" : "ˋdʒuәlrI"
        ],
        [
            "cName" : "日誌",
            "eName" : "journal",
            "Phonetic" : "ˋdʒFnL"
        ],
        [
            "cName" : "旅行",
            "eName" : "journey",
            "Phonetic" : "ˋdʒFnI"
        ],
        [
            "cName" : "叢林",
            "eName" : "jungle",
            "Phonetic" : "ˋdʒʌŋgL"
        ],
        [
            "cName" : "垃圾",
            "eName" : "junk",
            "Phonetic" : "dʒʌŋk"
        ],
        [
            "cName" : "公平",
            "eName" : "justice",
            "Phonetic" : "ˋdʒʌstIs"
        ],
        [
            "cName" : "工作",
            "eName" : "job",
            "Phonetic" : "dʒɑb"
        ],
        [
            "cName" : "跳",
            "eName" : "jump",
            "Phonetic" : "dʒʌmp"
        ],
        [
            "cName" : "果凍",
            "eName" : "jelly",
            "Phonetic" : "ˋdʒɛlɪ"
        ],
        [
            "cName" : "果汁",
            "eName" : "juice",
            "Phonetic" : "dʒus"
        ],
        [
            "cName" : "牛仔褲",
            "eName" : "jeans",
            "Phonetic" : "dʒinz"
        ],
        [
            "cName" : "慢跑",
            "eName" : "jog",
            "Phonetic" : "dʒɑg"
        ],
        [
            "cName" : "歡樂",
            "eName" : "joy",
            "Phonetic" : "dʒɔɪ"
        ],
        [
            "cName" : "水壺",
            "eName" : "jug",
            "Phonetic" : "dʒʌg"
        ],
        [
            "cName" : "陪審團",
            "eName" : "jury",
            "Phonetic" : "ˈdʒʊrɪ"
        ],
        [
            "cName" : "爵士樂",
            "eName" : "jazz",
            "Phonetic" : "dʒæz"
        ],
        [
            "cName" : "水雉",
            "eName" : "jacana",
            "Phonetic" : "͵ʒɑsəˋnɑ"
        ],
        [
            "cName" : "長筒靴",
            "eName" : "jackboot",
            "Phonetic" : "ˋdʒæk͵but"
        ],
        [
            "cName" : "豺狼",
            "eName" : "jackal",
            "Phonetic" : "ˋdʒækɔl"
        ],
        [
            "cName" : "菠蘿蜜",
            "eName" : "jackfruit",
            "Phonetic" : "ˋdʒæk͵frut"
        ],
        [
            "cName" : "起重機",
            "eName" : "jackshaft",
            "Phonetic" : "ˋdʒæk͵ʃæft"
        ],
        [
            "cName" : "小茅屋",
            "eName" : "jacal",
            "Phonetic" : "hɑˋkɑl"
        ],
        [
            "cName" : "摺疊刀",
            "eName" : "jackknife",
            "Phonetic" : "ˋdʒæk͵naɪf"
        ],
        [
            "cName" : "門邊框柱",
            "eName" : "jamb",
            "Phonetic" : "dʒæm"
        ]
    ]
    */
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
        getVoca()
        if VocaList.count != 0 {
            delVoca()
        }
        for item  in InitVoca {
            addVoca(eName: item.eName, cName: item.cName, phonetic: item.phonetic, img: item.img)
        }
        getVoca()
        
        //speak(speakText: "Welcome to my Application",lang: "en-IE");

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return VocaList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "VocaCell"
        let tvcells = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! VocaTableViewCell
        tvcells.accessoryType = .disclosureIndicator
        tvcells.cName.text = VocaList[indexPath.row].cName
        tvcells.eName.text = VocaList[indexPath.row].eName
        tvcells.Phonetic.text = "[" + VocaList[indexPath.row].phonetic! + "]"
        tvcells.Img.image = UIImage(data: VocaList[indexPath.row].img! as Data)
        //tvcells.Img.image = UIImage(named: VocaList[indexPath.row].eName! + ".jpg")
        tvcells.Img.layer.cornerRadius = 15
        tvcells.Img.clipsToBounds = true
        return tvcells
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let speakActionHandler = { (action:UIAlertAction!) -> Void in
            self.speak(speakText: self.VocaArr[indexPath.row]["eName"]!, lang: "en-IE")
        }
        let optionMenu = UIAlertController(title: nil , message : "有什麼是我可以幫你的？", preferredStyle: .actionSheet)
        let speakAction = UIAlertAction(title: "唸給我聽！", style: .default, handler: speakActionHandler)
        let cancelAction = UIAlertAction(title: "取 消" , style: .cancel , handler: nil)
        optionMenu.addAction(speakAction)
        optionMenu.addAction(cancelAction)
        // support iPad
        optionMenu.popoverPresentationController?.sourceView = self.view
        optionMenu.popoverPresentationController?.sourceRect = (tableView.cellForRow(at: indexPath)?.frame)!
        self.present(optionMenu, animated: true,completion: nil)
    }
    */
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "分享", handler: { (action, indexPath) -> Void in
            let defaultText = "與您分享一個英文單字...\r\n【" + self.VocaList[indexPath.row].cName!  + "】" + self.VocaList[indexPath.row].eName!
            if let imageToShare = UIImage(data: self.VocaList[indexPath.row].img! as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                activityController.popoverPresentationController?.sourceView = self.view
                activityController.popoverPresentationController?.sourceRect = (tableView.cellForRow(at: indexPath)?.frame)!
                self.present(activityController,animated: true, completion: nil)
            }
        })
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "刪除", handler: { (action, indexPath) -> Void in
            
            self.VocaList.remove(at: indexPath.row)
            //tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        let speakAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "發音", handler: { (action, indexPath) -> Void in
            self.speak(speakText: self.VocaList[indexPath.row].cName! + "," + self.VocaList[indexPath.row].eName!  , lang: "zh-TW")
        })

        speakAction.backgroundColor = UIColor(red: 91.0/255.0, green: 192.0/255.0, blue: 222.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = UIColor(red: 92.0/255.0, green: 184.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 217.0/255.0, green: 83.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction, speakAction]
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            VocaArr.remove(at: indexPath.row)
            //tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
       }    
    }
 */
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVocaDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let nextController = segue.destination as! VocaDetailViewController
                nextController.Voca = VocaList[indexPath.row]
            }
        }
    }
    

}
