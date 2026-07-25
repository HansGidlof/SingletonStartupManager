//
//  TodoModel.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/06.
//

import Foundation   
import SwiftUI
import SwiftData

@Model
class LanguagesModel {
    
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    var content: String
    
 
    var createDate: Date
    var isDone: Bool
    
    var languages: [LanguagesModel]
    
    init(title: String, content: String, icon: NSImage, createDate: Date, isDone: Bool, languages: [LanguagesModel]) {
        self.title = title
        self.content = content
        self.createDate = createDate
        self.isDone = isDone
        self.languages = languages
    }
}


@Model
class Language {
    var name: String
    @Relationship(inverse: \LanguagesModel.languages) var languages: [LanguagesModel]

    
    init(name: String,  languages: [LanguagesModel]) {
        self.name = name
        self.languages = languages
    }
}


