//
//  LearnViewController.swift
//  MxoVocabulary
//
//  Created by 歐歐 on 2017/6/22.
//  Copyright © 2017年 ＭxoStudio. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {
    var nextKeyBegin = ""
    var nextKeyEnd = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.title = "單字學習"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    @IBAction func GoEnglishList(_ sender: UIButton) {
        if sender.tag == 50 {
            nextKeyBegin = "@"
            nextKeyEnd = "@"
        }else{
            nextKeyBegin = String(describing: UnicodeScalar(sender.tag+96)!)
            var nextChar = sender.tag + 3
            if nextChar > 26{ nextChar = 26}
            nextKeyEnd = String(describing: UnicodeScalar(nextChar+96)!)
        }
        self.performSegue(withIdentifier: "showVocaList", sender:sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVocaList" {
            let nextController = segue.destination as! VocaTableViewController
            nextController.englishKeyBegin = nextKeyBegin
            nextController.englishKeyEnd = nextKeyEnd
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  false
    }
}
