//
//  SwiftRobotControlCenter.swift
//  MyRobot
//
//  Created by Ivan Vasilevich on 10/4/14.
//  Copyright (c) 2014 Ivan Besarab. All rights reserved.
//

import UIKit
//  All robot commands can be founded in GameViewController.h
class SwiftRobotControlCenter: RobotControlCenter {
    
    //  Level name setup
    override func viewDidLoad() {
        
                levelName = "L4H" // "Zebra" та "Pyramid"! ОБЕРІТЬ РІВЕНЬ ДЛЯ ПОБУДОВИ ОБРАНОЇ ФІГУРИ НИЩЕ У run()
//                levelName = "L55H" // "Zebra" та "Pyramid"!
//                levelName = "L555H" // тільки для "Zebra"
//                levelName = "L666H" // тільки для "Zebra"
        
        super.viewDidLoad()
    }
    
    override func run() {
        
        
        
        let figure:String = "Pyramid" // ОБЕРІТЬ ФІГУНУ ДЛЯ ПОБУДОВИ
//        let figure:String = "Zebra"
        
        
        
        if figure == "Pyramid" {
            if (levelName == "L4H" || levelName == "L55H") {
                
                turnRight()
                
                for boundary in 0..<9 {
                    var enumerator = 0
                    
                    repeat {
                        
                        enumerator+=1
                        
                        if enumerator<(10-boundary) {
                            if (boundary+1) % 2 == 0 { put() }
                            move()
                            if (boundary) % 2 == 0 { put() }
                        }
                        
                        
                    } while enumerator<(10-boundary)
                    
                    if (boundary+1) % 2 == 0 {
                        turnRight()
                        move()
                        turnRight()
                        move()
                    } else {
                        if boundary == 8 { break }
                        turnLeft()
                        move()
                        turnLeft()
                    }
                    
                }
            }
        }
        
        
        else if figure == "Zebra" {
            if (levelName == "L4H" || levelName == "L55H" || levelName == "L555H" || levelName == "L666H") {
                
                if leftIsBlocked && rightIsClear { turnRight() }
                
                repeat {
                    printingARowOfChocolates()
                } while noCandyPresent
            }
        }
        
    }
    
    
    // мої функції та скороченя об'єму коду
    
    // 5
    func  printingARowOfChocolates() {
        
        repeat {
            putCandyIfNot()
            letsGoIfClear()
            
            if frontIsClear {
                letsGoIfClear()
                putCandyIfNot()
            }
        } while frontIsClear
        turn360()
    }
    
    // 4
    func turn360() {
        if facingDown {
            turnLeft()
            if frontIsClear {
                if noCandyPresent {
                    letsGoIfClear()
                    turnLeft()
                    move()
                } else {
                    letsGoIfClear()
                    turnLeft()
                }
                
            }
        } else if facingUp {
            turnRight()
            letsGoIfClear()
            turnRight()
        }
    }
    
    // 3
    func turnLeft() {
        turnRight()
        turnRight()
        turnRight()
    }
    // 2
    func letsGoIfClear() { if frontIsClear { move() } }
    
    // 1
    func putCandyIfNot() { if noCandyPresent { put() } }
}
