//
//  CustomTabView.swift
//  
//
//  Created by Veronika Hrybanova on 15.10.2022.
//

import SwiftUI
import SwiftUI
import Combine

class TabBarVisibilityManager: ObservableObject {
    @Published public var isTabBarVisible: Bool = true
    
    public func hideTabBar() {
        withAnimation {
            isTabBarVisible = false
        }
    }
    
    public func showTabBar() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isTabBarVisible = true
        }
    }
}

struct CustomTabViewContainer<Content: View>: View {
    @Binding private var selection: TabBarItem
    private let content: Content
    @State private var tabs: [TabBarItem] = []
    @EnvironmentObject var tabBarVisibilityManager: TabBarVisibilityManager
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content.edgesIgnoringSafeArea(.bottom)
            
            if tabBarVisibilityManager.isTabBarVisible {
                CircleTabView(tabs: tabs, selectedView: $selection)
            }
        }
        .onPreferenceChange(tabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct CircleTabView: View {
    private let tabs: [TabBarItem]
    @Binding private var selectedView: TabBarItem
    
    public init(tabs: [TabBarItem], selectedView: Binding<TabBarItem>) {
        self.tabs = tabs
        self._selectedView = selectedView
    }
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color("LightGrayBg"))
                    .stroke(Color("FontGray"), lineWidth: 4)
                
                HStack {
                    if selectedView == .settings {
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color("MainGreen"))
                        .stroke(Color("FontGray"), lineWidth: 4)
                        .frame(width: 115, height: 68)
                    if selectedView == .home {
                        Spacer()
                    }
                }
                .animation(Animation.linear(duration: 0.2), value: selectedView)
                
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { tab in
                        tabView(tab: tab)
                            .frame(width: 115, height: 68)
                    }
                }
            }
            .frame(width: 230, height: 68)
            .padding()
            .padding(.leading, 15)
            Spacer()
        }
    }
}

extension CircleTabView {
    private func tabView(tab: TabBarItem) -> some View {
        ZStack {
            Button {
                switchTab(tab: tab)
            } label: {
                if selectedView == tab {
                    Image(tab.selectedImage)
                } else {
                    Image(tab.image)
                }
            }
        }
    }
    
    private func switchTab(tab: TabBarItem) {
        selectedView = tab
    }
}

enum TabBarItem: Hashable {
    case home, settings
    
    var image: String {
        switch self {
            case .home: return "HomeDark"
            case .settings: return "SettingsDark"
        }
    }
    
    var selectedImage: String {
        switch self {
            case .home: return "HomeWhite"
            case .settings: return "SettingsWhite"
        }
    }
}

struct tabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: tabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}


