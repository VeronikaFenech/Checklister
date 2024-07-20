//
//  ChecklisterApp.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 31.05.2024.
//

import SwiftUI
import SwiftData

@main
struct ChecklisterApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    @StateObject var userStateViewModel = UserStateViewModel()
    var body: some Scene {
        
        WindowGroup {
            NavigationView{
                ApplicationSwitcher()
            }.environmentObject(userStateViewModel)
            //
            //LoginView()
            //RegistrationView()
           // EmailConfirmation()
           
        }
        //.modelContainer(sharedModelContainer)
    }
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if (vm.isLoggedIn) {
            MainTab()
        } else {
            WelcomeScreen()
        }
        
    }
}

enum UserStateError: Error{
    case signInError, signOutError
}

@MainActor
class UserStateViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var isBusy = false
    
    func signIn(email: String, password: String) async -> Result<Bool, UserStateError>  {
        isBusy = true
        do{
            isLoggedIn = true
            isBusy = false
            return .success(true)
        }
//        catch{
//            isBusy = false
//            return .failure(.signInError)
//        }
        //UserDefaults signedIn
    }
    
    func signOut() async -> Result<Bool, UserStateError>  {
        isBusy = true
        do{
            isLoggedIn = false
            isBusy = false
            return .success(true)
        }
//        catch{
//            isBusy = false
//            return .failure(.signOutError)
//        }
        //UserDefaults SignedOut
    }
}
