//
//  ContentView.swift
//  wwdc
//
//  Created by iManTie on 9/26/25.
//

import SwiftUI

// 主视图，包含底部标签页和播放视图
struct ContentView: View {
    // 控制是否展示检查器的状态变量
    @State var presentInspector = false
    // 搜索文本的绑定变量
    @State private var searchText: String = ""

    // 控制是否显示弹出视图的状态变量
    @State var isShowSheet = false
    var body: some View {
        NavigationStack {
            ZStack {
                // 底部标签视图，包含两个标签页
                TabView {
                    // 第一个标签页，主页
                    Tab(role: .none) {
                        homeView()
                    } label: {
                        Label("Home", systemImage: "house") // 标签页图标和文字
                    }

                    Tab(role: .none) {
                    } label: {
                        Label("Settings", systemImage: "figure.open.water.swim.circle")
                    }

                    Tab(role: .none) {
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }

                    // 第二个标签页，搜索
                    Tab(role: .search) {
                        NavigationStack {
                            SearchView(searchText: $searchText)
                        }
                    }
                }
                .tabBarMinimizeBehavior(.onScrollDown) // 滚动时最小化标签栏
                .tabViewBottomAccessory {
                    playView() // 底部播放视图
                }
                .toolbar {
                    ToolbarItem {
                        Image(systemName: "square.and.arrow.up") // 工具栏中的分享图标
                    }
                }
                .tint(.red)
            }
            .navigationTitle("Home") // 设置导航栏标题为“Home”
        }
    }
}

// 主页视图，展示一个列表，点击进入详情
struct homeView: View {
    // 列表数据项

    var body: some View {
        List {
            NavigationLink {
                CustomToolbarView(title: "Toolbar")
            } label: {
                HStack{
                    Image(systemName: "figure.walk.suitcase.rolling.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red, .black)
                    
                }
                Text("Toolbar")
            }
            
            
            NavigationLink {
                SheetView(title: "SheetView")
            } label: {
                HStack{
                    Image(systemName: "popcorn.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red, .black)
                    
                }
                Text("SheetView")
            }
            
            NavigationLink {
                ChartView()
            } label: {
                HStack{
                    Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red, .black)
                    
                }
                Text("ChartView")
            }
            
            NavigationLink {
                AnimationView()
            } label: {
                HStack{
                    Image(systemName: "ticket.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red, .black)
                    
                }
                Text("Transation")
            }

        }
        .navigationTitle("Home") // 设置导航栏标题为“Home”
        .toolbar {
            // 如果你还需要在搜索页面放其他 toolbar 项目
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Filter") {
                    // filter action
                }
            }
        }
    }

}

// 详情视图，显示传入的标题
struct CustomToolbarView: View {
    // 标题状态变量
    @State var title: String

    var body: some View {
        Text("Detail View")
            .navigationTitle(title) // 设置导航栏标题为传入的标题
    }
}

// 搜索视图，显示搜索结果
struct SearchView: View {
    // 绑定的搜索文本
    @Binding var searchText: String

    var body: some View {
        List {
            Text("Result for \(searchText)") // 显示搜索结果文本
        }
        .navigationTitle("Search") // 设置导航栏标题为“Search”
        .toolbar {
            // 如果你还需要在搜索页面放其他 toolbar 项目
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Filter") {
                    // filter action
                }
            }
        }
    }
}

// 预览结构体，方便Xcode预览
#Preview {
    ContentView()
}
