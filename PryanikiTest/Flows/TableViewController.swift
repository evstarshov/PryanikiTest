//
//  TableViewController.swift
//  PryanikiTest
//
//  Created by Евгений Старшов on 26.05.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: Private properties
    
    private let networkService = NetworkService()
    private var model: [CellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextTableViewCell
            let item = model[indexPath.row]
            let cellModel = CellFactory.cellModel(from: item)
            cell.configure(from: cellModel)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "picCell", for: indexPath) as! PictureTableViewCell
            let item = model[indexPath.row]
            let cellModel = CellFactory.cellModel(from: item)
            cell.configurePic(from: cellModel)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "pickerCell", for: indexPath) as! PickerTableViewCell
            cell.pickerView.dataSource = self
            cell.pickerView.delegate = self
            return cell

        default:
            print("Do nothing in row")
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        showAlert(message: item.name)
    }
    
   // MARK: Private methods
    
    private func getData() {
        networkService.makeRequest { [weak self] response in
            guard let self = self else { return }
            guard let response = response else { return }
            self.model = response.data
            self.makeSection()
        }
    }
    
    private func makeSection() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "PictureTableViewCell", bundle: nil), forCellReuseIdentifier: "picCell")
        tableView.register(UINib(nibName: "PickerTableViewCell", bundle: nil), forCellReuseIdentifier: "pickerCell")
        tableView.rowHeight = 120
        tableView.reloadData()
    }
    
    private func showAlert(message: String?) {
        let alertVC = UIAlertController(title: "Warning", message: "Initiated by object: \(message ?? "id error")", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
}

// MARK: PickerView Extension

extension TableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        model.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.last?.data.variants![row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let id = model.last?.data.variants?[row].id
        let objectName = model.last?.name
        let alertVC = UIAlertController(title: "Initiated by object \(objectName ?? "name error")", message: "Initiated by ID: \(id ?? 1)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
}
