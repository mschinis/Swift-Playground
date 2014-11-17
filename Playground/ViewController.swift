//
//  ViewController.swift
//  Playground
//
//  Created by Michael Schinis on 11/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LineChartDelegate, BTDropInViewControllerDelegate {
    var menuVC:MenuTableViewController!
    /*
    *   General stuff
    *
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.menuVC = self.childViewControllers.
        self.navigationController!.navigationBar.barTintColor = UIColor(red:1.000, green:0.510, blue:0.373, alpha: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
    *
    *   LineChart Implementation
    *   To use didSelectDataPoint() make sure the class conforms to LineChartDelegate
    *
    */
    var label = UILabel()
    var lineChart: LineChart?
    var data: Array<CGFloat> = [3, 4, 9, 11, 13, 15]
    var data2: Array<CGFloat> = [1, 3, 5, 13, 17, 20]
    @IBOutlet weak var lineChartViewTwo: UIView!
    
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
        label.text = "x: \(x)   y: \(yValues)"
    }
    
    /**
    *
    *   Braintree Implementation
    *   Make the current class conforms to BTDropInViewControllerDelegate
    *   For a full understanding of how braintree works, refer to; https://developers.braintreepayments.com/img/static/diagram-client-perspective.png
    *   For full documentation, follow; https://developers.braintreepayments.com/ios+php/start/hello-client
    *
    */
    var braintree:Braintree!
    
    // Ask for a payment nonce from the server. This should be done once the application loads up.
    func braintreeButtonPressed() {
        let manager = AFHTTPRequestOperationManager()
        manager.GET("http://noq.at/braintree/", parameters: [],
            success: {
                (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                self.showDropIn(responseObject["client_token"] as String)
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
            })
    }
    // Displays the drop in controller with the payment nonce retrieved from server
    func showDropIn(clientToken: String){
        self.braintree = Braintree(clientToken: clientToken)
        
        var dropInViewController = self.braintree.dropInViewControllerWithDelegate(self)
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "userCancelledPayment:")
        let navigationController = UINavigationController(rootViewController: dropInViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)

    }
    // Once the payment was succeeded, send the payment method nonce to the server
    func dropInViewController(viewController: BTDropInViewController!, didSucceedWithPaymentMethod paymentMethod: BTPaymentMethod!) {
        self.postNonceToServer(paymentMethod.nonce)
    }
    // If the user canceled, remove the navigation controller from the queue.
    func dropInViewControllerDidCancel(viewController: BTDropInViewController!) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    func userCancelledPayment(sender: UIBarButtonItem){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    // Creates the payment by sending the nonce to the server endpoint.
    func postNonceToServer(paymentMethodNonce: String){
        let manager = AFHTTPRequestOperationManager()
        println(paymentMethodNonce)
        
        manager.POST("http://noq.at/braintree/pay.php",
            parameters: ["payment_method_nonce":paymentMethodNonce],
            success: {
                (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                if(responseObject["success"] as Bool == true){
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                }
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(operation)
                println(error)
        })
    }
    
    
}