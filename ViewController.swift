//
//  ViewController.swift
//  SimpleCrud
//
//  Created by Luã Enrique on 23/02/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var labelid: UILabel!
    var db: OpaquePointer?
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    var userslist = [Usuarios]()
    
    @IBOutlet weak var tableU: UITableView!
    
    
    func tableView(_ tableU: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userslist.count
    }
    
    func tableView(_ tableU: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let usuario:Usuarios
        usuario = userslist[indexPath.row]
        cell.textLabel?.text = usuario.username
        cell.tag = usuario.id!
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userslist.count)
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("newdb2.sqlite")
        
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK {
            print("An error ocurred while opening the database")
        }
        
        let sqlCreateTableQuery = "CREATE TABLE IF NOT EXISTS Usuarios (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, PASSWORD TEXT)"
        
        if sqlite3_exec(db, sqlCreateTableQuery, nil, nil, nil) == SQLITE_OK{
            print("Table created successfully")
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    public func tableView(_ tableU: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        var statement: OpaquePointer?
        
        //getting the current cell from the index path
        let currentCell = tableU.cellForRow(at: indexPath)! as UITableViewCell
        
        //getting the text of that cell
        let currentItem = currentCell.textLabel!.text
        
        print(currentCell.tag)
        labelid.text = String(currentCell.tag)
        performSegue(withIdentifier: "segue", sender: self)
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var secondscreen = segue.destination as! SViewController
        secondscreen.id = labelid.text!
    }
    
    public func tableView(_ tableU: UITableView, didSelectRowAt indexPath: IndexPath){
        return
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    @IBAction func InsertUser(_ sender: Any) {
        if (usernameText.text?.isEmpty)! || (passwordText.text?.isEmpty)! {
            print("Please, fill all the fields")
        }
        else{
            var statement: OpaquePointer?
            let sqlQueryInsertion = "INSERT INTO Usuarios(NAME, PASSWORD) VALUES(?,?)"
            
            if sqlite3_prepare_v2(db, sqlQueryInsertion, -1, &statement, nil) != SQLITE_OK{
                print("Failure while preparing the insertion query")
            }
            
            if sqlite3_bind_text(statement, 1, usernameText.text?.trimmingCharacters(in: .whitespacesAndNewlines), -1, SQLITE_TRANSIENT) != SQLITE_OK{
                print("Failure while binding the username value")
            }
            
            if sqlite3_bind_text(statement, 2, passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines), -1, SQLITE_TRANSIENT) != SQLITE_OK{
                print("Failure while binding the password value")
            }
            
            if sqlite3_step(statement) != SQLITE_DONE{
                print("Failure while inserting")
            }
            
            if sqlite3_reset(statement) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error resetting prepared statement: \(errmsg)")
            }
            
            if sqlite3_finalize(statement) != SQLITE_OK{
                print("Error while recovering memory")
            }
            
        }
        
        readValues()
        tableU.reloadData()
    }
    
    func readValues(){
        var stmt: OpaquePointer?
        
        let sqlListingQuery = "SELECT ID, NAME, PASSWORD FROM Usuarios"
        
        if sqlite3_prepare_v2(db, sqlListingQuery, -1, &stmt, nil) != SQLITE_OK{
            print("Error while preparing the sql Listing query")
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW{
            let id = sqlite3_column_int(stmt, 0)
            print("id = \(id); ", terminator: "")
            
           let name = String(cString:sqlite3_column_text(stmt, 1))
           print(name)
            let pass = String(cString: sqlite3_column_text(stmt, 2))
           print(pass)
            
            userslist.append(Usuarios(id: Int(Int64(id)), username:name, password: pass))
            print(userslist.count)
            
        }

        tableU.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


