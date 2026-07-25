//
//  LanguageModel.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-19.
//

import SwiftUI
import SwiftData

/// A SwiftData model representing a single item, uniquely identified by ``id``
/// and optionally grouped by one or more ``Tag`` values.
@Model
class LanguageModel {

    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    var createDate: Date
    var modificationDate: Date

    var isDone: Bool

    /// The tags this item belongs to. `Tag.todos` is the inverse side.
    var Languages: [Language]

    init(title: String, createDate: Date, isDone: Bool, tags: [Language] = []) {
        self.title = title
        self.createDate = createDate
        self.modificationDate = createDate
        self.isDone = isDone
        self.Languages = tags
    }
}

@Model
class Language {
    var name: String
    @Relationship(inverse: \LanguageModel.Languages) var languages: [LanguageModel]

    init(name: String, languages: [LanguageModel] = []) {
        self.name = name
        self.languages = languages
    }
}

