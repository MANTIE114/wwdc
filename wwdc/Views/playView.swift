//
//  playView.swift
//  wwdc
//
//  Created by mantieus on 2025/9/27.
//

import SwiftUI

// 底部播放视图，根据位置显示不同颜色的矩形
struct playView: View {
    // 获取底部附件的位置环境变量
    @Environment(\.tabViewBottomAccessoryPlacement)
    var placement

    @State var isPlaying = false

    var body: some View {
        if placement == .inline {
            HStack {
                HStack {
                    Spacer()
                    Image("landmarkImage")
                        .resizable()
                        .cornerRadius(4)
                        .frame(width: 34, height: 34)

                    Spacer()

                    Text("For every love.")

                    Spacer()

                    Image(systemName: "playpause.fill")

                    Spacer()
                }
            }
        } else {
            HStack(spacing: 4) {
                HStack {
                    Spacer()
                        .frame(width: 22)

                    Image("landmarkImage")
                        .resizable()
                        .cornerRadius(4)
                        .frame(width: 34, height: 34)

                    Text("For every love.")

                    Spacer()
                    Spacer()

                    Image(systemName: isPlaying ? "stop.circle.fill" : "play.fill")
                        .font(.title3)
                        .contentTransition(.symbolEffect(.replace))
                        .onTapGesture {
                            isPlaying.toggle()
                        }
                    
                    Spacer()
                        .frame(width: 12)
                    Image(systemName: "forward.fill")
                        .font(.title3)
                        .symbolEffect(.breathe)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    playView()
}
