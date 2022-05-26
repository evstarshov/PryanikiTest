//
//  ViewController.swift
//  PryanikiTest
//
//  Created by Евгений Старшов on 26.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textBlock: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    let networkService = NetworkService()
    var items: [Datum] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        getData()
    }
    
    private func getData() {
        networkService.makeRequest { [weak self] response in
            guard let self = self else { return }
            self.items = response
            print(self.items)
            print(self.items.count)
            self.setData()
        }
        
    }
    
    private func setData() {
        textBlock.text = items.first?.data.text
        if let imageURL = URL(string: items[1].data.url ?? "https://s.mxmcdn.net/images-storage/albums4/2/7/1/2/7/7/34772172_800_800.jpg") {
            self.imageView.loadImage(url: imageURL)
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.last?.data.variants?.count ?? 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items.last?.data.variants?[row].text
    }
    
}
