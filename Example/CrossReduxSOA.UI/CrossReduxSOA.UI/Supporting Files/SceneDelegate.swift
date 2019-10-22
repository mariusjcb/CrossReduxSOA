//
//  SceneDelegate.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import UIKit
import Redux
import SwiftUI
import RxSwift
import ApiModule
import CrossReduxSOA_ApiModule
import CrossReduxSOA_Reducers
import CrossReduxSOA_Services
import CrossReduxSOA_ReduxStores

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    lazy var archiveListeners = [GenericReduxArchiverLogger("archive_logger1")]
    lazy var listeners: [ReduceStoreOutputDelegate] = [
        GenericReduxStoreLogger("logger"),
        GithubStoreArchiver(outputDelegates: archiveListeners)
    ]
    
    lazy var adapter = ApiRequestAdapter(host: "https://api.github.com/")
    lazy var api = GithubApi(requestAdapter: adapter)
    lazy var reducer = GithubReducer(githubService: GithubService(api: api))
    lazy var store = GithubStoreProvider([], reducer: reducer, outputDelegates: listeners)

    let disposeBag: DisposeBag = DisposeBag()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = HomeView()
        
        store.dispatch(action: .search("tetris"))
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        //store.combine.dispatch(action: .addGithub("ai intrat"))
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        //store.combine.dispatch(action: .addGithub("ai iesit"))
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

