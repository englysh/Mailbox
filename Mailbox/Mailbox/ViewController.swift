//
//  ViewController.swift
//  Mailbox
//
//  Created by Engly Chang on 9/16/14.
//  Copyright (c) 2014 Engly Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inboxView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImg: UIImageView!
    
    @IBOutlet weak var interMsg: UIImageView!
    @IBOutlet weak var colorView: UIView!
    var originalMsgCenter: CGPoint!
    
    
    @IBOutlet weak var laterIcon: UIImageView!
    var originalLaterIconCenter: CGPoint!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    var originalArchiveIconCenter: CGPoint!
    
    @IBOutlet weak var listIcon: UIImageView!
    var originalListIconCenter: CGPoint!
    
    @IBOutlet weak var deleteIcon: UIImageView!
    var originalDeleteIconCenter: CGPoint!
    
    @IBOutlet weak var rescheduleImg: UIImageView!
    @IBOutlet weak var listImg: UIImageView!
    
    
    //needs to be put at root lvl in order to be called in the panning from edge function
    var menuPanGesture: UIPanGestureRecognizer!
    var originalInboxCenter: CGPoint!
    
    @IBAction func onPanMsg(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var breakPoint = interMsg.frame.width/4.5
        var breakPoint2 = interMsg.frame.width/1.25
        var changeSpeed = 0.2
        var snapSpeed = 0.1
        //var space = 10.0
        
        //****PANNING BEGIN****//
        if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            //println("pan began")
            //println(location.x)
            
            self.originalMsgCenter = interMsg.center
            self.originalArchiveIconCenter = archiveIcon.center
            self.originalLaterIconCenter = laterIcon.center
            self.originalListIconCenter = listIcon.center
            self.originalDeleteIconCenter = deleteIcon.center
            
            //gray: 214, 214, 214
            colorView.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
            
            //****PANNING CHANGED****//
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Changed){
            //println("pan changed")
            println(translation.x)
            //moving the email msg around
            interMsg.center.x = self.originalMsgCenter.x+translation.x
            
            
            //++++(+)movement behavior (swiping right), before PASSING breakPoint+++//
            // 0 < translation.x < breakpoint
            
            //----(-)movement behavior (swiping left), before PASSING breakPoint----//
            // translation will always be negative when swiping left
            // -bp < x < 0
            if (translation.x < breakPoint && -breakPoint < translation.x){
                
                //1. archive icon changes its alpha depending how close it is to the breakpoint
                archiveIcon.alpha = translation.x/breakPoint
                //println("archive icon alpha: \(archiveIcon.alpha)")
                
                //2. clolor block will always be gray in this region
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    //1. color will transition back to gray: 214, 214, 214
                    self.colorView.backgroundColor = UIColor (red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
                })
                
                //Negative movement behavior
                //1. color will always be gray: 214, 214, 214
                self.colorView.backgroundColor = UIColor (red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
                
                //2. later icon will change according to alpha
                self.laterIcon.alpha = -translation.x / breakPoint
                //println("latericon alpha: \(self.laterIcon.alpha)")
                
            }
                
                //++++(+)movement behavior (swiping right), PASSING breakPoint but not at breakPoint2++++//
                // breakPoint < translation.x < breakPoint2
            else if (breakPoint < translation.x && translation.x <  breakPoint2){
                
                //1. archive icon will always follow
                archiveIcon.center.x = self.originalArchiveIconCenter.x + translation.x - breakPoint
                
                //2. archive icon will always be visible
                archiveIcon.alpha = 1
                
                //3. the color block will always be green 48, 211, 182
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    self.colorView.backgroundColor = UIColor(red: 48/255, green: 211/255, blue: 182/255, alpha: 1.0)
                    }, completion: nil)
                
                //4. delete icon will always be invisible
                self.deleteIcon.alpha = 0
                
                //5. delete icon will follow
                deleteIcon.center.x = self.originalDeleteIconCenter.x + translation.x - breakPoint
            }
                //----(-)movement behavior (swiping left), passing -breakPoint but not at -breakpoint2
                // -bp2 < x < -bp
            else if (-breakPoint2 < translation.x && translation.x < -breakPoint){
                
                //1. will always be yellow 255 221 77
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    self.colorView.backgroundColor = UIColor(red: 255/255, green: 221/255, blue: 77/255, alpha: 1.0)
                    }, completion: nil)
                
                //2. later icon always visible
                laterIcon.alpha = 1
                
                //3. later icon will always follow
                laterIcon.center.x = self.originalLaterIconCenter.x + translation.x + breakPoint
                
                //4. list icon will be invisible
                listIcon.alpha = 0
                
                //5. list icon will follow
                listIcon.center.x = self.originalListIconCenter.x + translation.x + breakPoint
                
                
            }
                //+++(+)movement behavior (swiping right), passing breakpoint2
                //+++ x > bp2
                
            else if (translation.x > breakPoint2) {
                //Positive movement
                //1. color block will always be RED 248 14 93
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    self.colorView.backgroundColor = UIColor(red: 248/255, green: 14/255, blue: 93/255, alpha: 1.0)
                    }, completion: nil)
                
                //2. archive icon invisible
                //3. archive icon follows
                archiveIcon.alpha = 0
                archiveIcon.center.x = self.originalArchiveIconCenter.x + translation.x - breakPoint
                
                //4. delete icon visible
                //5. delete icon follows
                deleteIcon.alpha = 1
                deleteIcon.center.x = self.originalDeleteIconCenter.x + translation.x - breakPoint
                
            }
                //----(-)movement behavior (swiping left), passing -breakPoint2
                // -320 < x < -bp2
                
            else if(translation.x < -breakPoint2){
                //Negative movement
                //1. will always be brown 189 164 135
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    self.colorView.backgroundColor = UIColor(red: 189/255, green: 164/255, blue: 135/255, alpha: 1.0)
                    }, completion: nil)
                
                //2. later icon always visible
                laterIcon.alpha = 0
                
                //3. later icon will always follow
                laterIcon.center.x = self.originalLaterIconCenter.x + translation.x + breakPoint
                
                //4. list icon will be invisible
                listIcon.alpha = 1
                
                //5. list icon will follow
                listIcon.center.x = self.originalListIconCenter.x + translation.x + breakPoint
                
                
            }
            
            //****PANNING ENDED****//
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Ended){
            println("pan ended")
            
            //+++ if swiping right and have not reached the breakPoint+++
            //-bp1 < translation.x < breakPoint
            //snap back to origin point
            if (translation.x < breakPoint && -breakPoint < translation.x
                ){
                    UIView.animateWithDuration(snapSpeed, animations: { () -> Void in
                        self.interMsg.center.x = self.originalMsgCenter.x
                    })
                    
                    //as long as x > bp, the message should swipe away to archive or delete
            } else if (translation.x > breakPoint ){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    //1. releasing it will make it animate off the screen
                    self.interMsg.center.x = self.interMsg.center.x + 320
                    self.archiveIcon.center.x = self.archiveIcon.center.x + 320
                    self.deleteIcon.center.x = self.deleteIcon.center.x + 320
                    
                    
                    }, completion: { (finished:Bool) -> Void in
                        
                        //then upon completion, the feed img moves up
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.feedImg.center.y = self.feedImg.center.y - self.interMsg.frame.height
                        })
                })
                
                //swipe left to show "reschedule msg", bp 2 < translation.x < -breakPoint
            } else if (-breakPoint2 < translation.x  && translation.x < -breakPoint ){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.interMsg.center.x = -self.interMsg.frame.width
                    self.laterIcon.center.x = -self.interMsg.frame.width
                    self.listIcon.center.x = -self.interMsg.frame.width
                    
                    }, completion: { (finished:Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.rescheduleImg.alpha = 1
                        })
                })
                //swipe left further to show "list", translation.x < -breakPoint2
            }  else if(translation.x < -breakPoint2){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.interMsg.center.x = -self.interMsg.frame.width
                    self.laterIcon.center.x = -self.interMsg.frame.width
                    self.listIcon.center.x = -self.interMsg.frame.width
                    
                    }, completion: { (finished:Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.listImg.alpha = 1
                        })
                })
            }
        }
    }
    
    //message and icons return to its original position after DISMISSING the reschedule view
    @IBAction func onRescheduleBtn(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rescheduleImg.alpha = 0
            
            }) { (finished:Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    //self.feedImg.center.y = self.feedImg.center.y - self.interMsg.frame.height
                    self.interMsg.center.x = self.interMsg.frame.width/2
                    self.laterIcon.center.x = 277
                    self.listIcon.center.x = 277
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                })
        }
    }
    
    //activate swiping away animation after RESCHEDULED the reschedule view
    @IBAction func onSomedayBtn(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rescheduleImg.alpha = 0
            
            }) { (finished:Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedImg.center.y = self.feedImg.center.y - self.interMsg.frame.height
                })
        }
    }
    
    //activate swiping away animation after dimissing the LIST view
    @IBAction func onlistToBuyBtn(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.listImg.alpha = 0
            
            }) { (finished:Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedImg.center.y = self.feedImg.center.y - self.interMsg.frame.height
                })
        }
        
        
        
        
    }
    
    func onEdgePan(panGestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            
            self.originalInboxCenter = inboxView.center
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
            scrollView.userInteractionEnabled = false
            inboxView.center.x = self.originalInboxCenter.x + translation.x
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            //inboxview does not reveal if not moving pass 1/3 or screen
            if (translation.x < inboxView.frame.width/3){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxView.center.x = self.inboxView.frame.width/2
                    self.scrollView.userInteractionEnabled = true

                })
            } else if (translation.x > inboxView.frame.width/3){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxView.center.x = 445
                    self.menuPanGesture.enabled = true
                    
                })
                
            }
        }
    }
    
    func onMenuPan (panGestureRecognizer: UIPanGestureRecognizer){
        var translation = panGestureRecognizer.translationInView(view)
        
        if (panGestureRecognizer.state == UIGestureRecognizerState.Began){
            println("pan began")
            self.originalInboxCenter = inboxView.center
            
        } else if (panGestureRecognizer.state == UIGestureRecognizerState.Changed){
            
            self.inboxView.center.x = self.originalInboxCenter.x + translation.x
            
            
        } else if (panGestureRecognizer.state == UIGestureRecognizerState.Ended){
            
            if (-translation.x < inboxView.frame.width/3){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxView.center.x = 445
                    
                    //"dungent" still revealed so pangesture on inbox still active
                    self.menuPanGesture.enabled = true
                    //make sure inbox view still doesn't scroll
                    self.scrollView.userInteractionEnabled = false


                })

            } else if (-translation.x > inboxView.frame.width/3){
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxView.center.x = self.inboxView.frame.width/2
                    //now dongent is open so disable inbox panning to left and let it move on edgepan
                    self.menuPanGesture.enabled = false
                    self.scrollView.userInteractionEnabled = true

                })

            }
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize = inboxView.frame.size
        //scrollView.contentInset = UIEdgeInsets (top: 0, left: 0, bottom: 65+37+42+86, right: 0)
        

        archiveIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        deleteIcon.alpha = 0
        rescheduleImg.alpha = 0
        listImg.alpha = 0
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        inboxView.addGestureRecognizer(edgeGesture)
        
        menuPanGesture = UIPanGestureRecognizer(target: self, action: "onMenuPan:")
        inboxView.addGestureRecognizer(menuPanGesture)
        menuPanGesture.enabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
}

