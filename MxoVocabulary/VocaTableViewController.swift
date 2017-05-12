//
//  VocaTableViewController.swift
//  MxoVocabulary
//
//  Created by 歐歐 on 2017/4/21.
//  Copyright © 2017年 ＭxoStudio. All rights reserved.
//

import UIKit
import AVFoundation

class VocaTableViewController: UITableViewController {

    
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
        
        speak(speakText: "Welcome to my Application",lang: "en-IE");

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
        return VocaArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "VocaCell"
        let tvcells = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! VocaTableViewCell
        tvcells.accessoryType = .disclosureIndicator
        tvcells.cName.text = VocaArr[indexPath.row]["cName"]!
        tvcells.eName.text = VocaArr[indexPath.row]["eName"]!
        tvcells.Phonetic.text = "[" + VocaArr[indexPath.row]["Phonetic"]! + "]"
        tvcells.Img.image = UIImage(named: VocaArr[indexPath.row]["eName"]! + ".jpg")
        tvcells.Img.layer.cornerRadius = 15
        tvcells.Img.clipsToBounds = true
        return tvcells
    }
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

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "分享", handler: { (action, indexPath) -> Void in
            let defaultText = "與您分享一個英文單字...\r\n【" + self.VocaArr[indexPath.row]["cName"]!  + "】" + self.VocaArr[indexPath.row]["eName"]!
            if let imageToShare = UIImage(named: self.VocaArr[indexPath.row]["eName"]! + ".jpg") {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                activityController.popoverPresentationController?.sourceView = self.view
                activityController.popoverPresentationController?.sourceRect = (tableView.cellForRow(at: indexPath)?.frame)!
                self.present(activityController,animated: true, completion: nil)
            }
        })
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "刪除", handler: { (action, indexPath) -> Void in
            
            self.VocaArr.remove(at: indexPath.row)
            //tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        let speakAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "發音", handler: { (action, indexPath) -> Void in
            self.speak(speakText: self.VocaArr[indexPath.row]["cName"]! + "," + self.VocaArr[indexPath.row]["eName"]!  , lang: "zh-TW")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
