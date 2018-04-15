//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Steven Tay on 08/02/2018.
//  Copyright © 2018 Xiu Design. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    
    
    let realm = try! Realm()

    var categories: Results<Category>?
    var cellColorHex: String = UIColor.randomFlat.hexValue()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategory()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        

    
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        cell.backgroundColor = HexColor((categories?[indexPath.row].cellColor)!) ?? HexColor(cellColorHex)
        
        return cell
    }
    
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    
    func save(category: Category) {

        do {

            try realm.write {
                realm.add(category)
            }

        } catch {
            print("Error saving catergory \(error)")
        }

        tableView.reloadData()
    }

    func loadCategory() {

       categories = realm.objects(Category.self)
        
      tableView.reloadData()
   }
    
//MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath)
    {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                 try self.realm.write
                    {
                        self.realm.delete(categoryForDeletion)
                    }
                } catch
                    {
                        print("Error deleting category, \(error)")
                    }

                }
    }




    //MARK: - Add New Categories
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.cellColor = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new category"
            textField = alertTextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
 }



