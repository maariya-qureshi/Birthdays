//
//  ContentView.swift
//  Birthdays
//
//  Created by Maariya Qureshi on 7/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //creating array of friends:
    //change @State to @Query -> allows us to fetch data being stored from Friend class
    @Query private var friends: [Friend]
    //allows for data to talk across all code files ->
    @Environment(\.modelContext) private var context
    
    //new friend:
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {

        NavigationStack
        {
        
        //creating list of friends: id parameter is essential for SwiftUI to uniquely identify each item in collecton -> using name property
        //list makes list, friends: is the private var being used, identified by the name, and each friend is shown through the statements inside the curly brackets
            //any world could be used in place of friend!!
            
            //remove id: \.name, bc SwiftData provides each instance of a model type with its own identity seperate from its Data, @Model provides identifier, so names can be repeated!!
            List(friends){ friend in
                
                //creating an Hstack with nested text for each friend in list:
                HStack
                {
                    Text(friend.name)
                    Spacer()
                    //format for date datatype
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
                //ending list bracket:
            }
            
            .navigationTitle("Birthdays")
            //modifier to pin new friend UI entry to bottom of screen:
            .safeAreaInset(edge: .bottom)
            {
                VStack(alignment: .center, spacing: 20)
                {
                    Text("New Birthday")
                        .font(.headline)
                    //adding in date picker: control for choosing date values:
                    //(rmb $ (2-way-binding) is used to bind it to the state variable so it updates)
                    //in:... -> shows that date must be from past to today, NOT the future
                    //displayedComponents only shows date, if we wanted time: .hourAndMinute
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date)
                    {
                        //usually text goes here as a label, but we are using a textfield to label the date picker so the user can also enter their name
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    //adding in save button to create a new friend object and add it (newFriend) to friends Array:
                    Button("Save")
                    {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        //wont work after adding in @Query: friends.append(newFriend) bc we got rid of the array we are trying to append (friends)
                        //instead: this inserts new Friend model into Model context:
                        context.insert(newFriend)
                        //resetting placeholder values for a new friend:
                        newName = ""
                        newBirthday = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar) //creates a seperatre background for Vstack area
                //closing bracket for safeAreaInset:
            }
            
            //closing nav stack
        }
        //closing body
    }
    //closing the struct
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
