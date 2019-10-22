//
//  ContentView.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import SwiftUI
import CrossReduxSOA_Reducers
import CrossReduxSOA_ReduxStores

@available(iOS 13.0, *)
struct HomeView: View, SharedHomeContent {
    @EnvironmentObject var store: GithubCombineStore<GithubReducer>
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(searchTextFieldPlaceholder, text: $store.searchingCriteria)
            Text(textForSearchingCriteria(store.searchingCriteria))
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)
            
            if store.currentState.count > 0 {
                List(store.currentState, id: \.id) { item in
                    Text(item.name).onAppear(perform: {
                        let index = self.store.state.firstIndex(where: { $0.id == item.id })!
                        let count = self.store.state.count
                        
                        if index == count - 5 {
                            self.store.currentPage += 1
                        }
                    })
                }
            } else {
                Spacer()
            }
        }.padding(.horizontal)
        .padding(.top)
        .alert(isPresented: $store.isErrorAlertPresented, content: {
            Alert(title: Text(errorAlertTitle),
                message: Text(store.error?.message ?? unknownError))
        })
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
