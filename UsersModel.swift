//
//  UsersModel.swift
//  DBTest
//
//  Created by Luã Enrique Zangrande on 21/02/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import Foundation

class Users{
    var id: Int?
    var username: String?
    var password: String?
    init(id: Int, username: String?, password: String?) {
        self.id = id
        self.username = username
        self.password = password
    }
}
