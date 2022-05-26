//
//  TextTableViewCell.swift
//  PryanikiTest
//
//  Created by Евгений Старшов on 26.05.2022.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textBoxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(from model: CellModel) {
        textBoxLabel.text = model.data.text ?? "TETX"
    }
    
}
