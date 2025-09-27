//
//  AnimationView.swift
//  wwdc
//
//  Created by mantieus on 2025/9/27.
//

import Charts
import SwiftUI

struct AnimationView: View {
    @State var isAnimate = true

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if isAnimate {
                        Image("landmarkImage")
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 320)
                            .cornerRadius(160)
                            .transition(myAnimation())

                        LyricText()
                            .transition(.scale)
                            .transition(.blurReplace)
                    }
                    
                    Text("Hello Lyrics Effect 🐣")
                        .font(.largeTitle.bold())
                        .textRenderer(APpearanceEffectRenderer())
                }
            }
            .navigationTitle("Animaent")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        withAnimation(.linear(duration: 0.3)) {
                            isAnimate.toggle()
                        }
                    } label: {
                        Image(systemName: "play.circle.fill")
                        Text("Play")
                    }
                }
            }
        }
    }
}

// 自定义过渡动画：缩放 + 透明度 + 模糊 + 旋转 + 亮度
struct myAnimation: Transition {
    // SwiftUI 会在视图插入/移除时调用这个方法
    // content: 需要过渡的视图
    // phase:   当前过渡阶段（.willAppear / .didDisappear / .identity）
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            // 缩放：出现时是正常大小，移除时缩小到 0.5
            .scaleEffect(phase.isIdentity ? 1 : 0.5)

            // 透明度：出现时完全不透明，移除时透明
            .opacity(phase.isIdentity ? 1 : 0)

            // 模糊：出现时清晰，移除时加 10pt 模糊
            .blur(radius: phase.isIdentity ? 0 : 10)

            // 旋转：刚要出现时旋转 180°，消失后旋转 -180°
            .rotationEffect(.degrees(
                phase == .willAppear ? 180 :
                    phase == .didDisappear ? -180 : .zero
            ))

            // 亮度：刚要出现时非常亮（1.0），其他阶段正常
            .brightness(phase == .willAppear ? 1.0 : 0)
    }
}

struct TextTransition: Transition{
    func body(content: Content, phase: TransitionPhase) -> some View {
        let duration = 0.9
        let elapsedTime = phase.isIdentity ? duration : 0
        
        
    }
}

struct LyricText: View {
    let lyric = "Welcome to NewYork!"
    @State private var progress: CGFloat = 0.0

    var body: some View {
        ZStack {
            // 背景文字（灰色）
            Text(lyric)
                .font(.largeTitle.bold())
                .foregroundColor(.gray)

            // 前景文字（高亮，使用渐变）
            Text(lyric)
                .font(.largeTitle.bold())
                .foregroundStyle(
                    LinearGradient(colors: [.pink, .red],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .mask(
                    GeometryReader { geo in
                        Rectangle()
                            .frame(width: geo.size.width * progress)
                            .animation(.linear(duration: 2), value: progress)
                    }
                )
        }
        .onAppear {
            progress = 1.0 // 动画执行歌词高亮
        }
    }
}

struct APpearanceEffectRenderer: TextRenderer{
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout{
            ctx.draw(line)
        }
    }
}

#Preview {
    AnimationView()
}
