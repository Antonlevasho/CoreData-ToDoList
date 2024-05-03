//
//  ViewController.swift
//  ToDoListDemoSecond
//
//  Created by Анастасия on 02.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - object
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView = UITableView()
    
    var models = [ToDoListDemo]()
    
    //var funct: Function?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "CoreData"
        
        setupNC()
        setupTableView()
        
        getAllItems()
    }
    
    
    //MARK: - setupNavigationController
    
    func setupNC() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }
    
    @objc func addAction() {
        
        let alertController = UIAlertController(title: "add New task", message: nil, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alertController.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            self?.createItem(name: text)
        }))
        
        present(alertController, animated: true)
    }
    
    
//MARK: - setupTableView()
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}

//MARK: - extension

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = models[indexPath.row]
        //MARK: -
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        //MARK: -
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            let alert = UIAlertController(title: "editItem", message: "edit your item", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "save", style: .default, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                
                self?.updateItem(item: item, newName: newName)
            }))
            
            self.present(alert, animated: true)
        }))
        
        //MARK: -
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = model.name
        
        return cell
    }
}
