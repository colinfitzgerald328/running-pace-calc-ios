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
            HStack {
                Text("Running Pace Calculator").font(.headline).padding(8)
            }
        VStack(alignment: .center) {
            HStack {
                Text("Running Time:")
                TextField("Enter a value", text: $input1).frame(width: 150, height: 20)
                    .padding(8)
                    .background(Color.gray)
            }
            HStack {
                Text("Running Pace:")
                TextField("Enter a value", text: $input2).frame(width: 150, height: 20)
                    .padding(8)
                    .background(Color.gray)
            }
            HStack {
                Text("Running Distance:")
                TextField("Enter a value", text: $input3).frame(width: 150, height: 20)
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
        VStack(alignment: .leading) {
            HStack {
                Text("Who Uses a Pace Calculator?").font(.headline).padding(8)
            }
            HStack {
                Text("Both new and experienced runners can benefit from pace calculators. Knowing your pace can help you train and run better, whether you're running your first race, striving to set a personal best, or going for a training run.").padding(8)
            }
            HStack {
                Text("Why are pace calculators useful?").font(.headline).padding(8)
            }
            HStack {
                Text("Pace calculators can help you figure out how quickly you should run if you have a specific finish time in mind for a particular distance or race. Find out what speed you need to run a 20-minute 5K or a sub-1:30 half marathon, for example.Pace calculators can also be used to figure out what your pace was during a training run in the neighborhood or on the track.Find out how quickly you ran for that 30-minute 4-mile training run, for example.Finally, they can assist you in determining the distance you ran. For example, you may figure out how far you ran by entering your pace and the length of your training run or race.")
                    .padding(8)
            }
        }
    }

}
