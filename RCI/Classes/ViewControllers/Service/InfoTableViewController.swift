//
//  InfoTableViewController.swift
//  RCI
//
//  Created by Impulse on 09.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit

protocol InfoTableProtocol {
    func didPickInfo(info:String, atIndex:IndexPath)
}

class InfoTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var infoArray:[String] = []
    var controllerTitle = ""
    var delegate:InfoTableProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: controllerTitle)
        tableView.reloadData()
    }
    
    func setupController(info: [String], infoDelegate:InfoTableProtocol?, title:String) {
        controllerTitle = title
        infoArray = info
        delegate = infoDelegate
    }

}

extension InfoTableViewController :  UITableViewDataSource, UITableViewDelegate {
    
//MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        cell.textLabel?.text = infoArray[indexPath.row]
        return cell
    }

//MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didPickInfo(info:infoArray[indexPath.row], atIndex: indexPath)
    }
}
