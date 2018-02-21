//
//  ViewController.swift
//  DBTest
//
//  Created by Luã Enrique Zangrande on 21/02/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit
import SQLite3 //importing the sqlite package


class ViewController: UIViewController {
    var db: OpaquePointer?
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBAction func insertUser(_ sender: Any) { //verifying if the button "insertUser" was pressed
        let user = userName.text?.trimmingCharacters(in: .whitespacesAndNewlines) // getting the data from the username field
        let pass = passWord.text?.trimmingCharacters(in: .whitespacesAndNewlines) // getting the data from the password field
        if(user?.isEmpty)!{ //verifying if the user field is empty
            print("Please, fill the username field.") 
            return;
        }
        if(pass?.isEmpty)!{ //verifying if the password field is empty
            print("Please, fill the password field.")
            return;
        }
        
        let sqlQuery = "INSERT INTO Users(username, password) VALUES(?,?)" //creating the insertion query 
        
        var stmt: OpaquePointer? //creating the variable "statement"
        
        if sqlite3_prepare(db, sqlQuery, -1, &stmt, nil) != SQLITE_OK { //preparing the query
            print("Error while preparing the query")
        }
        
        if sqlite3_bind_text(stmt, 1, user, -1, nil) != SQLITE_OK{ //bind the first value (statement, position, value, -1, nil)
            print("Error while binding the user value")
        }
        if sqlite3_bind_text(stmt, 2, pass, -1, nil) != SQLITE_OK{//bind the second value
            print("Error while binding the password value")
        }
    
        if sqlite3_step(stmt) == SQLITE_DONE{ //executing the query.
            print("User saved successfully")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("MyDb.sqlite") //Creating the Sqlite file
    
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{ //verifying if the file was created
            print("Some error ocurred while creating the database.")
        }
    
        let createTableQuery = "CREATE TABLE IF NOT EXISTS Users(ID INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)" //setting up the sql table creation code
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK{ //verifying if the sqlcode could be executed
            print("Error while creating db table")
        }
        
        print("You did it!")
    }
}

