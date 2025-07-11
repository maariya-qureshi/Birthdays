//
//  Friend.swift
//  Birthdays
//
//  Created by Maariya Qureshi on 7/11/25.
//

import Foundation

class Friend
{
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date)
    {
        self.name = name
        self.birthday = birthday //self = way to access name var vs the parameter
    }
    
}
