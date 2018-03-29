//
//  AbsementGraphView.swift
//  MannFit
//
//  Created by Daniel Till on 1/11/18.
//  Copyright © 2018 MannFit Labs. All rights reserved.
//

import UIKit
import Charts

class AbsementGraphView: UIView {
    
    private let lineChartView = LineChartView()
    private var lineDataEntry : [ChartDataEntry] = []
    var workoutDuration: [Int] = []
    var absementGraphPoints: [Float] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cubicLineChartSetup()
    }
    
    func setGraphData() {
        lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0, easingOption: .easeInOutCubic)
        setCubicLineChart(dataPoints: workoutDuration, values: absementGraphPoints)
    }
    
    func cubicLineChartSetup() {
        self.backgroundColor = UIColor.clear
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setCubicLineChart(dataPoints: [Int], values: [Float]) {
        
        lineChartView.noDataTextColor = UIColor.white
        lineChartView.noDataText = "No data for this chart"
        lineChartView.backgroundColor = .clear
    
        for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
            lineDataEntry.append(dataPoint)
            
        }
        
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label:"BPM")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(false)
        
        chartDataSet.setCircleColor(.blue)
        chartDataSet.lineWidth = 2.0
        chartDataSet.fill = Fill.fillWithCGColor(UIColor.blue.cgColor)
        chartDataSet.drawFilledEnabled = true
        
        chartDataSet.circleRadius = 4.0
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawCirclesEnabled = false
        
        lineChartView.isUserInteractionEnabled = false
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.axisLineColor = .white
        lineChartView.xAxis.axisLineWidth = 2.0
    
        lineChartView.leftAxis.axisLineWidth = 2.0
        lineChartView.leftAxis.axisLineColor = .white
        lineChartView.leftAxis.setLabelCount(3, force: true)
        lineChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 16.0)
        lineChartView.leftAxis.labelTextColor = .white
        lineChartView.leftAxis.axisMinimum = 0.0
        
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        
        lineChartView.data = chartData
    }
}
