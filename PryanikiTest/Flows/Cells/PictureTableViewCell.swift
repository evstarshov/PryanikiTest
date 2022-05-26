//
//  PictureTableViewCell.swift
//  PryanikiTest
//
//  Created by Евгений Старшов on 26.05.2022.
//

import UIKit

class PictureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configurePic(from model: CellModel) {
        if let imageURL = URL(string: model.data.url ?? "https://s.mxmcdn.net/images-storage/albums4/2/7/1/2/7/7/34772172_800_800.jpg") {
            self.pictureView.loadImage(url: imageURL)
        }
    }
    
}
