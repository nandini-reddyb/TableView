//
//  ListViewController.swift
//  TableView
//
//  Created by Nandini B on 29/02/24.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var uiTableView: UITableView!
    @IBOutlet weak var uiLabel: UILabel!

    var userData = [UserDetails]() //defined this to store the decoded data and populate in a tableview
    var createUserData: CreateUserDetails?
    var updateUserData: UpdateUserDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ListTableViewCell", bundle: .main)
        uiTableView.register(nib, forCellReuseIdentifier: "cellId")
 
    //    self.createUser()
        self.updateUser()
        
//        getDataList{ data in
//            self.userData = data
//        }
    }
    
    
    //POST
    func createUser() {
        let apiString = "https://reqres.in/api/users"
        
        guard let url = URL(string: apiString) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        let request = ["name": "morpheus", "job": "leader"]
        
        do {
            let requestData = try JSONSerialization.data(withJSONObject: request)
            urlRequest.httpBody = requestData
        } catch {
            print("error", error)
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { apiResponseData, urlResponse, apiError in
            print(apiResponseData, urlResponse, apiError)
            if let apiError = apiError {
                print("apiError:  ", apiError)
            } else {
                guard let response = urlResponse as? HTTPURLResponse else {
                    return
                }
                
                if response.statusCode == 201 {
                    guard let responseData = apiResponseData else {
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(CreateUserDetails.self, from: responseData)
                        print("decodeData  ", decodeData)
                        self.createUserData = decodeData
                        print("user data  ", self.createUserData)
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            
        }.resume()
    }
    
    
    //UPDATE
    func updateUser() {
        let apiString = "https://reqres.in/api/users/2"
        
        guard let url = URL(string: apiString) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        let request = ["name": "Nandini", "job": "Dev"]
        
        do {
            let requestData = try JSONSerialization.data(withJSONObject: request)
            urlRequest.httpBody = requestData
        } catch {
            print("error", error)
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { apiResponseData, urlResponse, apiError in
            print(apiResponseData, urlResponse, apiError)
            if let apiError = apiError {
                print("apiError:  ", apiError)
            } else {
                guard let response = urlResponse as? HTTPURLResponse else {
                    return
                }
                
                if response.statusCode == 200 {
                    guard let responseData = apiResponseData else {
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(UpdateUserDetails.self, from: responseData)
                        print("decodeData  ", decodeData)
                        self.updateUserData = decodeData
                        print("Update user data  ", self.updateUserData)
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            
        }.resume()
    }
   
    
    //GET
    func getDataList(completeion: @escaping ([UserDetails]) -> ()) {
        let apiString = "https://reqres.in/api/users?page=2"
        
        guard let url = URL(string: apiString) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        //url session by default will be in suspended state, so do resume
        //apiResponseData -> this data will be in bytes, need to conver to user readable format, that we do by decoding . using json decoder.
        
        URLSession.shared.dataTask(with: urlRequest) { apiResponseData, urlResponse, apiError in
            print(apiResponseData, urlResponse, apiError)
            if let apiError = apiError {
                print("apiError:  ", apiError)
            } else {
                guard let response = urlResponse as? HTTPURLResponse else {
                    return
                }
                
                if response.statusCode == 200 {
                    guard let responseData = apiResponseData else {
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(UserList.self, from: responseData)
                        print("decodeData  ", decodeData)
                        self.userData = decodeData.data ?? []
                        completeion(decodeData.data!)
                        
                    } catch {
                        print("Error decoding JSON: \(error)")                
                    }
                }
            }
            
        }.resume()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = ListTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as!  ListTableViewCell
        cell.label.text = userData[indexPath.row].first_name
        cell.value.text = userData[indexPath.row].last_name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row : ", indexPath.row , " section: " , indexPath.section)
    }
}
