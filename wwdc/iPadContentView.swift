//
//  iPadContentView.swift
//  wwdc
//
//  Created by iManTie on 9/26/25.
//

import SwiftUI

struct iPadContentView: View {
    @State var per = false
    var body: some View {
        NavigationSplitView {
            Button("查看 右侧边栏 详情") {
                per.toggle()
            }
        } detail: {
            LandmarkDetailView(landmark: .init(backgroundImageName: "landmarkImage"))
        }
        .inspector(isPresented: $per) {
            Text("右侧边栏!")
        }
    }
}

struct LandmarkDetailView: View {
    let landmark: Landmark

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Image(landmark.backgroundImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .backgroundExtensionEffect()
            }
        }
    }
}

#Preview {
    iPadContentView()
}
