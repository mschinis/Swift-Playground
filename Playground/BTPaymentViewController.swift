//
//  BTPaymentViewController.swift
//  Playground
//
//  Created by Michael Schinis on 16/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class BTPaymentViewController: UIViewController, BTDropInViewControllerDelegate {

    var braintree:Braintree!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dropInViewController(viewController: BTDropInViewController!, didSucceedWithPaymentMethod paymentMethod: BTPaymentMethod!) {
        println(paymentMethod.nonce)
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController!) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
