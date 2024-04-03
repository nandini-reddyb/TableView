//
//  SampleTableViewController.swift
//  TableView
//
//  Created by Nandini B on 20/02/24.
//

import UIKit

class SampleTableViewController: UITableViewController {

    var dataArray = [["cell 1", "cell 2", "cell 3", "cell 4", "cell 5", "cell 6", "cell 7", "cell 8"], ["cell 1", "cell 2", "cell 3", "cell 4", "cell 5", "cell 6", "cell 7", "cell 8"] ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


extension SampleTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cellId") ?? UITableViewCell()
        cell.textLabel?.text =  dataArray[indexPath.section][indexPath.row]
        cell.detailTextLabel?.text = "Subtiitle test"

        print("section row", indexPath.section, indexPath.row)
        cell.contentView.backgroundColor = .link
        
        if(indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                cell.contentView.backgroundColor = .yellow
            case 1:
                cell.contentView.backgroundColor = .lightGray
            case 2:
                cell.contentView.backgroundColor = .green
            case 3:
                cell.contentView.backgroundColor = .gray
            default:
                cell.contentView.backgroundColor = .systemPurple
            }
        }
        
        if(indexPath.section == 1) {
            cell.contentView.backgroundColor = .magenta
        }
        
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "header 1"
        } else {
            return  "header 2"
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "End of Section"
    }
}

extension SampleTableViewController  {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row : ", indexPath.row , " section: " , indexPath.section)
        
    }
    
        override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
            //delete action
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, competion in
                print("Delete button tap")
                self.dataArray[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                competion(true)
            }
            
            let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeConfig
        }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, competion in
            print("Delete button tap")
            self.dataArray[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            competion(true)
        }
        
        //edit action
        let editAction = UIContextualAction(style: .normal, title: "edit") { _, _, competion in
            print("Edit button tap")
            
            let alertController = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
            alertController.addTextField() { textField in
                textField.placeholder = "Enter new name"
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                        if let newName = alertController.textFields?.first?.text {
                            self.dataArray[indexPath.section][indexPath.row] = newName
                            tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }))
                    self.present(alertController, animated: true)

            competion(true)
        }
        
        deleteAction.backgroundColor = .red
        editAction.backgroundColor = .systemBlue
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipeConfig
    }
}
