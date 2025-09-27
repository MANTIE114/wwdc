//
//  SheetView.swift
//  wwdc
//
//  Created by iManTie on 9/26/25.
//

import SwiftUI

struct SheetView: View {
    // 标题状态变量
    @State var title: String
    @State var isShowSheet = false

    @State private var isShowDialog = false
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack(alignment: .bottomLeading) {
                    Image("landmarkImage")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .ignoresSafeArea() // 背景全屏铺满
//                        .padding(.top, -180)

                    VStack {
                        Spacer()
                        Text("像 TV 页面一样的效果")
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                    }
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
                }
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
}

#Preview {
    SheetView(title: "SheetView")
}
