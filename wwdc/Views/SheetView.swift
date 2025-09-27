//
//  SheetView.swift
//  wwdc
//
//  Created by iManTie on 9/26/25.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct SheetView: View {
    // 标题状态变量
    @State var title: String
    @State var isShowSheet = false
    @State private var offset: CGFloat = 0

    @State private var isShowDialog = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Image("landmarkImage")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(height: offset > 0 ? 300 - (offset>80 ? 80 : offset) : 300)
                    .scaleEffect(offset < 0 ? 1 + offset / -200 : 1)
//                    .padding(.top, -100)

                ZStack(alignment: .top) {
                    ScrollView {
                        VStack {
                            ZStack {
                                Text("像 TV 页面一样的效果")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .bold()
                            }.frame(height: 200)
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.6),
                                    Color.clear,
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        VStack {
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            Text("aaa")
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                        }
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: -geo.frame(in: .named("scroll")).origin.y
                                )
                            }
                        )
                    }
                    .coordinateSpace(name: "scroll")
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        offset = value
                        print("实时滚动偏移量: \(offset)")
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image(systemName: "play.house.fill")
                                .fixedSize()
                                .onTapGesture {
                                    isShowSheet.toggle()
                                }
                                .sheet(isPresented: $isShowSheet) {
                                    LandmarkDetailView(landmark: .init(backgroundImageName: "landmarkImage"))
                                        .presentationDetents([.height(200), .medium, .large])
                                }
                        }
                        .sharedBackgroundVisibility(.hidden) // 隐藏toolbar背景

                        ToolbarItem {
                            Image(systemName: "square.and.arrow.up")
                                .fixedSize()
                                .onTapGesture {
                                    isShowSheet.toggle()
                                }
                                .sheet(isPresented: $isShowSheet) {
                                    LandmarkDetailView(landmark: .init(backgroundImageName: "landmarkImage"))
                                        .presentationDetents([.height(200), .medium, .large])
                                }
                        }

                        ToolbarItem {
                            Image(systemName: "book.pages.fill")
                                .onTapGesture {
                                    isShowDialog.toggle()
                                }
                                .confirmationDialog("Delete?", isPresented: $isShowDialog, titleVisibility: .visible) {
                                    Button("Delete") {
                                    }
                                    Button("Cnacel") {
                                    }

                                } message: {
                                    Text("这里是说明文字，可以告诉用户这些操作的作用")
                                }
                        }

                        ToolbarItem(placement: .bottomBar) {
                            Button(action: {
                            }) {
                                HStack {
                                    Image(systemName: "play.square.stack.fill")
                                    Text("Show Alert")
                                }
                            }
                        }
                        ToolbarSpacer(.flexible, placement: .bottomBar)
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button("Noti", systemImage: "bell") {
                            }
                            .badge(10)

                            Button("Noti", systemImage: "bell", action: {
                            })
                        }
                    }
                }
            }
            .background(Color.black)
        }
    }
}

#Preview {
    SheetView(title: "SheetView")
}
