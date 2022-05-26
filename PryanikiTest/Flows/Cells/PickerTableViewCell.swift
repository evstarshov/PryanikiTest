//
//  PickerTableViewCell.swift
//  PryanikiTest
//
//  Created by Евгений Старшов on 26.05.2022.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    @IBOutlet weak var pickerView: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
