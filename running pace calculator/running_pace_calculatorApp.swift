//
//  running_pace_calculatorApp.swift
//  running pace calculator
//
//  Created by Colin FitzGerald on 12/17/22.
//

import SwiftUI
import UIKit
import Foundation

@main
struct running_pace_calculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State var input1: String = ""
    @State var input2: String = ""
    @State var input3: String = ""
    @State var result: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Running Time:")
                TextField("Enter a value", text: $input1)
                    .padding(8)
                    .background(Color.gray)
            }
            HStack {
                Text("Running Pace:")
                TextField("Enter a value", text: $input2)
                    .padding(8)
                    .background(Color.gray)
            }
            HStack {
                Text("Running Distance:")
                TextField("Enter a value", text: $input3)
                    .padding(8)
                    .background(Color.gray)
            }
            Button(action: {
                struct ToDoRequestModel: Codable {
                    var running_time: String
                    var running_pace: String
                    var running_distance: String
                }
                
                struct ToDoResponseModel: Codable {
                    var converted_result: String
                    var operation: String
                }
                
                let url = URL(string: "https://evening-spire-30745.herokuapp.com/convert")
                guard let requestUrl = url else { fatalError() }
                
                var request = URLRequest(url: requestUrl)
                request.httpMethod = "POST"
                
                // Set HTTP Request Header
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let newTodoItem = ToDoRequestModel(running_time: self.input1, running_pace: self.input2, running_distance: self.input3)
                do{
                    let jsonData = try JSONEncoder().encode(newTodoItem)
                    request.httpBody = jsonData
                } catch let jsonErr{
                    print(jsonErr)
                }
                
                
                
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}
                    
                    do{
                        let todoItemModel = try JSONDecoder().decode(ToDoResponseModel.self, from: data)
                        print("Response data:\n \(todoItemModel)")
                        print("todoItemModel Title: \(todoItemModel.converted_result)")
                        self.result = todoItemModel.converted_result
                    }catch let jsonErr{
                        print(jsonErr)
                    }
                    
                    
                }
                task.resume()
                
            }) {
                Text("Calculate")
            }
            Text(result)
        }
        .padding(16)
    }
}
