//
//  VocaTableViewCell.swift
//  MxoVocabulary
//
//  Created by 歐歐 on 2017/4/21.
//  Copyright © 2017年 ＭxoStudio. All rights reserved.
//

import UIKit

class VocaTableViewCell: UITableViewCell {
    @IBOutlet var eName: UILabel!
    @IBOutlet var cName: UILabel!
    @IBOutlet var Phonetic: UILabel!
    @IBOutlet var Img: UIImageView!
    @IBOutlet var marked: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
