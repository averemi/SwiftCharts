//
//  LineChart.swift
//  Examples
//
//  Created by ischuetz on 19/07/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

open class LineChart: Chart {
    
    public typealias ChartLine = (chartPoints: [(Double, Double)], color: UIColor)
    
    // Initializer for single line
    public convenience init(frame: CGRect, chartConfig: ChartConfigXY, xTitle: String, yTitle: String, line: ChartLine, xModel: ChartAxisModel, yModel: ChartAxisModel) {
        self.init(frame: frame, chartConfig: chartConfig, xTitle: xTitle, yTitle: yTitle, lines: [line], xModel: xModel, yModel: yModel)
    }
    
    // Initializer for multiple lines
    public init(frame: CGRect, chartConfig: ChartConfigXY, xTitle: String, yTitle: String, lines: [ChartLine], xModel: ChartAxisModel, yModel: ChartAxisModel) {
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartConfig.chartSettings, chartFrame: frame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineLayers: [ChartLayer] = lines.map {line in
            let chartPoints = line.chartPoints.map {chartPointScalar in
                ChartPoint(x: ChartAxisValueDouble(chartPointScalar.0), y: ChartAxisValueDouble(chartPointScalar.1))
            }
            
            let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: line.color, animDuration: 0.5, animDelay: 0)
            return ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        }
        
        let view = ChartBaseView(frame: frame)
        let layers: [ChartLayer] = [xAxisLayer, yAxisLayer] + lineLayers
        
        super.init(
            view: view,
            innerFrame: innerFrame,
            settings: chartConfig.chartSettings,
            layers: layers
        )
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
