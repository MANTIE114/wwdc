//
//  ContentView.swift
//  test26
//
//  Created by ManTie on 2025/9/21.
//
import Charts
import SwiftUI

struct Record: Identifiable {
    let id = UUID()
    let date: Date
    let name: String // 横坐标
    let value: Double // 纵坐标
    let category: String // 哪条线（分组）
}

struct ChartView: View {
    @State private var selectionData: Date?
    @State private var selectionSectorName: Double?

    let data: [Record] = [
        // 第一条线的数据
        .init(date: Calendar.current.date(byAdding: .day, value: 0, to: .now)!, name: "A", value: 2, category: "系列1"),
        .init(date: Calendar.current.date(byAdding: .day, value: 1, to: .now)!, name: "B", value: 6, category: "系列1"),
        .init(date: Calendar.current.date(byAdding: .day, value: 2, to: .now)!, name: "C", value: 3, category: "系列1"),
        .init(date: Calendar.current.date(byAdding: .day, value: 3, to: .now)!, name: "D", value: 8, category: "系列1"),
        .init(date: Calendar.current.date(byAdding: .day, value: 4, to: .now)!, name: "E", value: 4, category: "系列1"),
        .init(date: Calendar.current.date(byAdding: .day, value: 5, to: .now)!, name: "F", value: 5, category: "系列1"),
        .init(date: Calendar.current.date(byAdding: .day, value: 6, to: .now)!, name: "G", value: 2, category: "系列1"),
        .init(date: Calendar.current.date(byAdding: .day, value: 7, to: .now)!, name: "H", value: 6, category: "系列1"),

        .init(date: Calendar.current.date(byAdding: .day, value: 8, to: .now)!, name: "FF", value: 5, category: "系列2"),
        .init(date: Calendar.current.date(byAdding: .day, value: 9, to: .now)!, name: "GG", value: 5.4, category: "系列2"),
        .init(date: Calendar.current.date(byAdding: .day, value: 10, to: .now)!, name: "HH", value: 5.9, category: "系列2"),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                // 条形图：展示每个 name 的数量，按比例堆叠
                Chart(data) { record in
                    BarMark(
                        x: .value("数量", record.value),
                        stacking: .normalized
                    )
                    .foregroundStyle(by: .value("name", record.name))
                    
                }
                .frame(height:55)
//                .chartXAxis(.hidden)

                // 饼图：展示每个 name 的占比
                Chart(data) { record in
                    SectorMark(
                        angle: .value("count", record.value),
                        innerRadius: .ratio(0.618),
                        angularInset: 2,
                    )
                    .cornerRadius(4)
                    .foregroundStyle(by: .value("name", record.name))
                    .opacity(record.value == selectionSectorName ? 1.0 : 0.3)
                }
                .frame(height: 300)
                // 在饼图中心显示总数和标题
                .chartBackground { chartProxy in
                    VStack{
                        Text("Count")
                            .font(.callout)
                        
                        Text("22")
                            .font(.largeTitle.bold())
                    }
                }
                .chartAngleSelection(value: $selectionSectorName)
               

                
                // 折线图：展示随名字变化的数量，区分系列
                Chart(data) { record in
                    LineMark(
                        x: .value("名字", record.date, unit: .day),
                        y: .value("数量", record.value)
                    )
                    .foregroundStyle(by: .value("系列", record.category)) // 区分线条颜色
                    .interpolationMethod(.catmullRom) // 平滑过渡

                    // 可选：给每条线上加点
                    PointMark(
                        x: .value("名字", record.date, unit: .day),
                        y: .value("数量", record.value)
                    )
                    .foregroundStyle(by: .value("系列", record.category))
                    
                    if let selectionData {
                        RuleMark(
                            x: .value("Select", selectionData)
                        )
                        .foregroundStyle(.red.opacity(0.6))
                        .offset(yStart: -10)
                        .zIndex(-1)
                        .annotation(position: .top, spacing: 0, overflowResolution: .init(
                            x: .fit(to: .chart),
                            y: .disabled
                        )) {
                            Text(selectionData.formatted())
                        }
                                 
                    }
                }
                .chartXSelection(value: $selectionData)
                .chartGesture { chartProxy in
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if let xValue: Date = chartProxy.value(atX: value.location.x) {
                                selectionData = xValue
                            }
                        }
                        .onEnded { _ in
                            // 结束时可以保留最后选中的值，或者清空
                             selectionData = nil
                        }
                }
                .padding()

                // 面积图：展示系列的累计趋势
                Chart(data) { record in
                    AreaMark(
                        x: .value("名字", record.date, unit: .day),
                        y: .value("数量", record.value)
                    )
                    .foregroundStyle(.red)
                    .interpolationMethod(.catmullRom) // 平滑过渡
                    .foregroundStyle(by: .value("系列", record.category))
                }

                // 柱状图：展示每个名字对应的数量
                Chart(data) { record in
                    BarMark(
                        x: .value("名字", record.date, unit: .day),
                        y: .value("数量", record.value)
                    )
                    .interpolationMethod(.catmullRom) // 平滑过渡
                    .foregroundStyle(by: .value("系列", record.category))
                }

                // 参考线：阈值线 y=6
                Chart(data) { _ in
                    RuleMark(
                        y: .value("数量", 6)
                    )
                    .foregroundStyle(.red)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .annotation(position: .top, alignment: .leading) {
                        Text("阈值 6")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                // 心率风格图：标记最高点和最低点
                Chart(data) { _ in
                    // 标记最高点
                    if let maxRecord = data.max(by: { $0.value < $1.value }) {
                        PointMark(
                            x: .value("名字", maxRecord.date, unit: .day),
                            y: .value("数量", maxRecord.value)
                        )
                        .symbol(.plus)
                        .foregroundStyle(.red)
                        .annotation(position: .top) {
                            Text("最高 \(maxRecord.value, specifier: "%.1f")")
                                .font(.caption2)
                                .foregroundColor(.red)
                        }
                    }

                    // 标记最低点
                    if let minRecord = data.min(by: { $0.value < $1.value }) {
                        PointMark(
                            x: .value("名字", minRecord.date, unit: .day),
                            y: .value("数量", minRecord.value)
                        )
                        .symbol(.circle)
                        .foregroundStyle(.blue)
                        .annotation(position: .bottom) {
                            Text("最低 \(minRecord.value, specifier: "%.1f")")
                                .font(.caption2)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .frame(height: 200)
                .padding()
            }
            .navigationTitle("Charts")
        }
    }
}

#Preview {
    ChartView()
}
