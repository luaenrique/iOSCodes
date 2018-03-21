/
//  Usuarios.swift
//  SimpleCrud
//
//  Created by Luã Enrique on 23/02/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import Foundation
import SQLite3

class Usuarios{
    var id: Int?
    var username: String?
    var password: String?
    var opq: OpaquePointer?
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    init(id: Int, username: String, password: String){
        self.id = id
        self.username = username
        self.password = password
    }
    
    init(id: Int){
        self.id = id
    }
    
    public func openSql(){
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("newdb2.sqlite")
        
        
        if sqlite3_open(fileUrl.path, &opq) != SQLITE_OK {
            print("An error ocurred while opening the database")
        }
    }
    
    public func getUsername() -> String{
        openSql()
        let sqlListingQuery = "SELECT NAME FROM Usuarios WHERE ID = ?"
        var db: OpaquePointer?
        if sqlite3_prepare_v2(opq, sqlListingQuery, -1, &db, nil) != SQLITE_OK{
            print("Error while preparing the sql Listing query")
        }
        
        if sqlite3_bind_int(db, 1, Int32(self.id!)) != SQLITE_OK{
            print("Error binding value")
        }
        
       
        
        while sqlite3_step(db) == SQLITE_ROW{
            let name = String(cString:sqlite3_column_text(db, 0))
            return name
        }
        return ""
        
    }
    
    public func getPassword() -> String{
        openSql()
        var stmt: OpaquePointer?
        let stringListingQuery = "SELECT PASSWORD FROM Usuarios WHERE ID = ?"
        if sqlite3_prepare_v2(opq, stringListingQuery, -1, &stmt, nil) != SQLITE_OK{
            print("Error while preparing the query")
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(self.id!)) != SQLITE_OK{
            print("Error while binding the id")
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW{
            let password = String(cString:sqlite3_column_text(stmt, 0))
            print(password)
            return password
        }
        
        return ""
    }
    
    public func updateUser(){

        var stmt: OpaquePointer?
        
        let stringUpdateQuery = "UPDATE Usuarios SET NAME = ?, PASSWORD = ? WHERE ID = ?"
        if sqlite3_prepare_v2(opq, stringUpdateQuery, -1, &stmt, nil) != SQLITE_OK{
            print("Error while preparing the update query")
        }
        
        if sqlite3_bind_text(stmt, 1, "asd", -1, self.SQLITE_TRANSIENT) != SQLITE_OK{
            print("Error while binding value")
        }
        
        if sqlite3_bind_text(stmt, 2, "3333", -1, self.SQLITE_TRANSIENT) != SQLITE_OK{
            print("Error while binding pass value")
        }
        
        if sqlite3_bind_int(stmt, 3, 1) != SQLITE_OK{
            print("Error while binding id value")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            print("Failure while inserting")
        }
        
        if sqlite3_reset(stmt) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(opq)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_finalize(stmt) != SQLITE_OK{
            print("Error while recovering memory")
        }
    }
}
