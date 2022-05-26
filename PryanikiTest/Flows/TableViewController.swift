//
//  TableViewController.swift
//  PryanikiTest
//
//  Created by Евгений Старшов on 26.05.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    let networkService = NetworkService()
    var model: [CellModel] = []
    var items: [Datum] = []
    var views: [String] = []
    
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

        default:
            print("Do nothing in row")
            return UITableViewCell()
        }
    }
    
    
    
    private func getData() {
        networkService.makeRequest { [weak self] response in
            guard let self = self else { return }
            guard let response = response else { return }
            self.model = response.data
            self.items = response.data
            self.views = response.view
            print(self.items)
            print(self.items.count)
            self.makeSection()
        }
    }
    
    private func makeSection() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "PictureTableViewCell", bundle: nil), forCellReuseIdentifier: "picCell")
        tableView.rowHeight = 120
        tableView.reloadData()
    }
}
