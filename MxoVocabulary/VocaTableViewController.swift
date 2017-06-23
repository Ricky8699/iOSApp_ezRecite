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

class VocaTableViewController: UITableViewController , NSFetchedResultsControllerDelegate , UISearchResultsUpdating {
    @IBOutlet var navTitle: UINavigationItem!
    var searchController : UISearchController!
    var englishKeyBegin : String = ""
    var englishKeyEnd : String = ""
    var mycontext : NSManagedObjectContext!
    let speechSynthesizer = AVSpeechSynthesizer()
    var VocaList : [VocaModel] = []
    var VocaListSearch : [VocaModel] = []
    
    func getContext()->NSManagedObjectContext{
        let appDelegate=UIApplication.shared.delegate as!AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func filterContent(for searchText: String){
        VocaListSearch = VocaList.filter({(Voca) -> Bool in
            if let sname = Voca.eName {
                let isMatch = sname.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    func getVoca(){
        let request : NSFetchRequest<VocaModel> = VocaModel.fetchRequest()
        if englishKeyBegin == "@" && englishKeyEnd == "@" {
            request.predicate = NSPredicate(format: "marked = true")
        }else{
            request.predicate = NSPredicate(format: "eName MATCHES %@", "^[" + englishKeyBegin + "-" + englishKeyEnd + "].+$")
        }

        let context = getContext()
        do {
        VocaList = try context.fetch(request)
            //print("Total: " + String( try context.count(for: request)))
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
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
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
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "搜尋單字..."
        searchController.searchBar.tintColor = UIColor.white
        if englishKeyBegin == "@" && englishKeyEnd == "@" {
            navTitle.title = "我的收藏庫"
        }else{
            navTitle.title = "字母「" + englishKeyBegin.uppercased() + "－" + englishKeyEnd.uppercased() + "」的單字"
        }
        getVoca()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return VocaListSearch.count
        }else{
            return VocaList.count
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if englishKeyBegin == "@" && englishKeyEnd == "@" {
            getVoca()
        }
        tableView.reloadData()
        //self.navigationController?.isNavigationBarHidden =  false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "VocaCell"
        let tvcells = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! VocaTableViewCell
        let vocasrc = (searchController.isActive) ? VocaListSearch[indexPath.row] : VocaList[indexPath.row]
        tvcells.accessoryType = .disclosureIndicator
        tvcells.cName.text = vocasrc.cName
        tvcells.eName.text = vocasrc.eName
        tvcells.Phonetic.text = "[" + vocasrc.phonetic! + "]"
        tvcells.Img.image = UIImage(data: vocasrc.img! as Data)
        
        tvcells.marked.isHidden = !vocasrc.marked
        tvcells.Img.layer.cornerRadius = 65
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
        
        /*let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "刪除", handler: { (action, indexPath) -> Void in
            
            self.VocaList.remove(at: indexPath.row)
            //tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })*/
        let markAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "收藏", handler: { (action, indexPath) -> Void in
            if self.markVoca(forEName: self.VocaList[indexPath.row].eName!){
                self.getVoca()
                tableView.reloadData()
            }
        })
        
        
        let speakAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "發音", handler: { (action, indexPath) -> Void in
            self.speak(speakText: self.VocaList[indexPath.row].cName! + "," + self.VocaList[indexPath.row].eName!  , lang: "zh-TW")
        })

        speakAction.backgroundColor = UIColor(red: 91.0/255.0, green: 192.0/255.0, blue: 222.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = UIColor(red: 92.0/255.0, green: 184.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        markAction.backgroundColor = UIColor(red: 217.0/255.0, green: 83.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        
        return [markAction, shareAction, speakAction]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        }else{
            return true
        }
    }
 
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVocaDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let nextController = segue.destination as! VocaDetailViewController
                nextController.Voca = (searchController.isActive) ? VocaListSearch[indexPath.row] : VocaList[indexPath.row]
            }
        }
    }
    

}
