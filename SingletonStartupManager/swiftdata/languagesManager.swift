//
//  languagesManager.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/07.
//

import Combine
import SwiftUI
import SwiftData

class languagesManager: ObservableObject {
    @Published var todoList: [LanguagesModel] = []
    @Published var languages: [Language] = []
    @Published var error: Error? = nil
    
    var modelContext: ModelContext? = nil
    var modelContainer: ModelContainer? = nil
    
    enum OtherErrors: Error {
        case nilContext
    }
    
    @MainActor
    init(inMemory: Bool) {

        do {
            // container init
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            let container = try ModelContainer(for: LanguagesModel.self, configurations: configuration)
            modelContainer = container
            // get model context
            modelContext = container.mainContext
            modelContext?.autosaveEnabled = true
            
            // query data
            queryTodoList()
            queryTags()

        } catch(let error) {
            print(error)
            print(error.localizedDescription)
            self.error = error
        }
    
    }


    
    private func queryTodoList() {
        guard modelContext != nil else {
            self.error = OtherErrors.nilContext
            return
        }
        
        var todoDescriptor = FetchDescriptor<LanguagesModel>(
//            predicate: #Predicate {$0.isDone == false}, // example for retrieve un-done only
            predicate: nil,
            sortBy: [
                .init(\.createDate)
            ]
        )
        todoDescriptor.fetchLimit = 10
//        do {
//            todoList = try modelContext.fetch(todoDescriptor)
//            for todo in todoList {
//                print(todo.tags)
//            }
//        } catch(let error) {
//            self.error = error
//        }
    }
    
    
    
    private func queryTags() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        let languageDescriptor = FetchDescriptor<Language>()
        do {
            languages = try modelContext.fetch(languageDescriptor)
        } catch(let error) {
            self.error = error
        }
    }
    
    
    func addTodo() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        let date = Date()
        let newTodo = LanguagesModel(title: "\(date)", content: "Todo Created on \(Date())",
                                     icon: NSImage(), createDate: date, isDone: false, languages: [])
        modelContext.insert(newTodo)
        save()
        queryTodoList()
    }
    
//    func addTag() {
//        guard let modelContext = modelContext else {
//            self.error = OtherErrors.nilContext
//            return
//        }
//        let color = TagColor.allCases.randomElement() ?? .blue
//        let newTag = Tag(name: "Tag \(tags.count + 1)", color: color, todos: [])
//        modelContext.insert(newTag)
//        save()
//        queryTags()
//    }
    
    
    func updateTodo(_ todo: LanguagesModel) {
        todo.isDone = true
        save()
        queryTodoList()
    }
    
    func deleteTodo(_ todo: LanguagesModel) {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        modelContext.delete(todo)
        save()
        queryTodoList()
    }
    
//    func deleteTag(_ tag: Tag) {
//        guard let modelContext = modelContext else {
//            self.error = OtherErrors.nilContext
//            return
//        }
//        modelContext.delete(tag)
//        save()
//        queryTags()
//        queryTodoList()
//    }
//   
    
    // saving any pending changes
    private func save() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        do {
            try modelContext.save()
        } catch (let error) {
            print(error)
            self.error = error
        }
    }
}
