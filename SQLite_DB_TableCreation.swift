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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("MyDb.sqlite") //Creating the Sqlite file
    
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{ //verifying if the file was created
            print("Some error ocurred while creating the database.")
        }
    
        let createTableQuery = "CREATE TABLE IF NOT EXISTS Users(ID INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)" //setting up the sql table creation code
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK{   //verifying if the sqlcode could be executed
            print("Error while creating db table")
        }
        
        print("You did it!")
    }
}

