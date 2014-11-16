//
//  ViewController.swift
//  Playground
//
//  Created by Michael Schinis on 11/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LineChartDelegate {
    var label = UILabel()
    var lineChart: LineChart?
    var data: Array<CGFloat> = [3, 4, 9, 11, 13, 15]
    var data2: Array<CGFloat> = [1, 3, 5, 13, 17, 20]
    
    
    @IBOutlet weak var lineChartView: UIView!
    @IBOutlet weak var lineChartViewTwo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Set the background colour of the status bar
//        var statusBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 20))
//        statusBar.backgroundColor = UIColor(red:1.000, green:0.510, blue:0.373, alpha: 1)
//        self.view.addSubview(statusBar)
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red:1.000, green:0.510, blue:0.373, alpha: 1)
        
        //self.view.backgroundColor = UIColor(red:1.000, green:0.510, blue:0.373, alpha: 1)
        // Do any additional setup after loading the view, typically from a nib.
        
//        var views: Dictionary<String, AnyObject> = [:]
//        
//        label.text = "..."
//        label.setTranslatesAutoresizingMaskIntoConstraints(false)
//        label.textAlignment = NSTextAlignment.Center
//        self.view.addSubview(label)
//        views["label"] = label
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-|", options: nil, metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[label]", options: nil, metrics: nil, views: views))
//
//
//        
//        lineChart = LineChart()
//        lineChart!.areaUnderLinesVisible = true
//        lineChart!.addLine(data)
//        lineChart!.addLine(data2)
//        lineChart!.setTranslatesAutoresizingMaskIntoConstraints(false)
//        lineChart!.delegate = self
//        self.view.addSubview(lineChart!)
//        views["chart"] = lineChart
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[chart]-|", options: nil, metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label]-[chart(==200)]", options: nil, metrics: nil, views: views))

    }
    override func viewWillLayoutSubviews() {
        
        var views: Dictionary<String, AnyObject> = [:]

        var locLineChart: LineChart?
        
        locLineChart = LineChart()
        locLineChart!.areaUnderLinesVisible = true
        locLineChart!.addLine(data)
        locLineChart!.addLine(data2)
        locLineChart!.setTranslatesAutoresizingMaskIntoConstraints(false)
        locLineChart!.delegate = self
        self.lineChartViewTwo.addSubview(locLineChart!)
        views["chart"] = locLineChart
        lineChartViewTwo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[chart]-|", options: nil, metrics: nil, views: views))
        lineChartViewTwo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[chart(==200)]", options: nil, metrics: nil, views: views))

    }
    
    func didSelectDataPoint(x: CGFloat, yValues: Array<CGFloat>) {
        label.text = "x: \(x)     y: \(yValues)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

