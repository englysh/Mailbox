//
//  InboxViewController.swift
//  Mailbox
//
//  Created by Engly Chang on 9/17/14.
//  Copyright (c) 2014 Engly Chang. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContent: UIView!
    @IBOutlet weak var interMsg: UIImageView!
    
    @IBOutlet weak var feedImg: UIImageView!
    
    var orgMsgCenter: CGPoint!

    @IBAction func onPanMsg(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var bp1 = Float (60.0)
        var bp2 = 260.0
        var duration = 0.2
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            println("pan began")
            
            self.orgMsgCenter = interMsg.center
            
            

            
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Changed){
            println("pan changed")
            interMsg.center.x = orgMsgCenter.x + translation.x
            
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Ended){
            println("pan ended")
            
            if(interMsg.center.x > 60){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.interMsg.center.x = self.interMsg.center.x + 320
                    
                    }, completion: { (finished: Bool) -> Void in
                    self.feedImg.center.y = self.feedImg.center.y + self.feedImg.center.y + self.interMsg.frame.height
                })

                
                
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = scrollContent.frame.size
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
