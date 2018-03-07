//
//  Observer.swift
//  Tleilax
//
//  Created by Patryk Szczypień on 07.03.2018.
//  Copyright © 2018 Patryk Szczypień. All rights reserved.
//

protocol Observer {
    var id : Int { get } // property to get an id
    func update<T>(with newValue: T)
}
