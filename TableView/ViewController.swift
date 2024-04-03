//
//  ViewController.swift
//  TableView
//
//  Created by Nandini B on 16/02/24.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    
    let dataToDisplay = [ ["Apple", "Banana", "Kiwi"] ,  ["Tomato", "Carrot", "Onion"]]
    let costToDisplay = [["10","22","23"], ["24","232", "442"]]
    let headerTitle = ["Fruits", "Vegetables"]
    let footer = ["End of section 1",  "End of section 2"]
    
    let friutsvVegetableImages = [["apple", "banana", "kiwi"], ["tomato", "carrot", "tomato"]]
    
    let mySubtitle = "subtitle"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cellId")
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataToDisplay[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CustomTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as!  CustomTableViewCell
        cell.nameLabel?.text =  dataToDisplay[indexPath.section][indexPath.row]
        cell.uiImage.image = UIImage(named: friutsvVegetableImages[indexPath.section][indexPath.row])
        cell.costLabel.text = costToDisplay[indexPath.section][indexPath.row]
 
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return headerTitle[section]
        } else {
            return  headerTitle[section]
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "End of Section"
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row : ", indexPath.row , " section: " , indexPath.section)
        
    }
}
