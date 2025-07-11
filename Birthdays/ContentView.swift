//
//  ContentView.swift
//  Birthdays
//
//  Created by Maariya Qureshi on 7/11/25.
//

import SwiftUI

struct ContentView: View {
    //creating array of friends:
    @State private var friends: [Friend] = [Friend(name: "Menal Qureshi", birthday: .now), Friend(name: "Deetya Cheerka", birthday: Date(timeIntervalSince1970: 0))]
    //new friend:
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {

        NavigationStack
        {
        
        //creating list of friends: id parameter is essential for SwiftUI to uniquely identify each item in collecton -> using name property
            List(friends, id: \.name){ friend in
                
                //creating an Hstack with nested text for each friend in list:
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
            }
            
            .navigationTitle("Birthdays")
            //modifier to pin new friend UI entry to bottom of screen:
            .safeAreaInset(edge: .bottom){
                VStack(alignment: .center, spacing: 20)
                {
                    Text("New Birthday")
                        .font(.headline)
                    //adding in date picker: control for choosing date values:
                    //(rmb $ is used to bind it to the state variable so it updates)
                    //in:... -> shows that date must be from past to today, NOT the future
                    //displayedComponents only shows date, if we wanted time: .hourAndMinute
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date)
                    {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    //adding in save button to create a new friend object and add it (newFriend) to friends Array:
                    Button("Save")
                    {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        friends.append(newFriend)
                        //resetting placeholder values for a new friend:
                        newName = ""
                        newBirthday = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar) //creates a seperatre background for Vstack area

            }
        }
        
    }
}

#Preview {
    ContentView()
}
