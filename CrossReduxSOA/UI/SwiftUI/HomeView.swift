//
//  ContentView.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct HomeView: View, SharedHomeContent {
    @State private var searchingCriteria = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(searchTextFieldPlaceholder, text: $searchingCriteria)
            Text(textForSearchingCriteria(searchingCriteria))
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)
            Spacer()
        }.padding(.horizontal)
        .padding(.top)
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
