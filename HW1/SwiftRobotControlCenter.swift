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
        
        levelName = "L0C" // пройти по маршруту з методички.
        
        // Введіть рівень перед запуском программи : ( L0C, L1C, L2C, L3C, L11C ) && ( L2H, L3H, L4H, L22H, L55H, L555H )
//        levelName = "L1C" // подвоїти кількість цукерок одним розв'язком для двох задач
//        levelName = "L2C" // лабиринт з паралельних ліній
//        levelName = "L3C" // лабиринт з паралельних ліній
//        levelName = "L11C" // подвоїти кількість цукерок одним розв'язком для двох задач
//        levelName = "L2H" // паралельні лінії з цукерок
//        levelName = "L3H" // цукерки по кутам та відцентрувати робота по висоті та ширині
//        levelName = "L4H" // хрестик
//        levelName = "L22H" // паралельні лінії з цукерок
//        levelName = "L55H" // шахматка
//        levelName = "L555H" // шахматка
        
        super.viewDidLoad()
    }
    
    override func run() {
        
        if (levelName == "L0C") { // пройти по маршруту з методички
            numberMove(number: 3)
            pick()
            turnRight()
            move()
            turnLeft()
            numberMove(number: 2)
            put()
            numberMove(number: 2)
        }
        
        else if (levelName == "L1C" || levelName == "L11C") { // подвоїти кількість цукерок одним розв'язком для двох задач
            var enumerator = 0
            move()
            
            repeat {
                pick()
                enumerator+=1
            } while candyPresent
            
            numberPut(number: 2*enumerator)
            turnBack()
            move()
            turnBack()
        }
        
        else if (levelName == "L2C" || levelName == "L3C") { // лабиринт з паралельних ліній
            var width = 0
            var bool = true
            repeat {
                if leftIsClear { // ліво-немає-перешколи
                    turnLeft()
                    numberMove(number: 1) // крок праворуч від нас, обходить перешкоду
                    width+=1
                    turnLeft()
                    repeat {
                        bool = false
                        move() // крок вверх
                    } while frontIsClear
                    
                } else { // ліво-перешкола
                    if frontIsClear { // перед-немає-перешколи
                        move()
                        if bool == true { width+=1 }
                    } else { // перед-перешкола
                        if rightIsBlocked { // праворуч-перешкода
                            turnBack()
                            bool = false
                        } else { // праворуч-немає-перешколи
                            turnRight()
                            if bool == true {
                                bool = false
                            } else {
                                bool = true
                            }
                        }
                    }
                }
            } while (width < 14)
        }
        
        else if (levelName == "L2H" || levelName == "L22H") {  // паралельні лінії з цукерок
            turnLeft()
            var numb = 32
            
            repeat {
                putCandyIfNot()
                move()
                putCandyIfNot()
                
                numb = numb - 1
                
                if numb % 8 == 0 {
                    turnRight()
                    numberMove(number: numb/2)
                    turnRight()
                }
                
            } while numb > 0
        }
        
        else if (levelName == "L4H") { // хрестик
            
            for i in 0..<20 {
                putCandyIfNot()
                move()
                if facingRight || (facingDown && i>10) {
                    turnRight()
                } else if facingLeft || (facingDown && i<10) {
                    turnLeft()
                }
                move()
                putCandyIfNot()
                
                if rightIsBlocked && i<10 {
                    turnLeft()
                    repeat { move() } while frontIsClear
                    turnLeft()
                }
            }
            
        }
        
        else if (levelName == "L55H" || levelName == "L555H") { // шахматка
            
            var bool = true
            
            for _ in 0..<10 {
                repeat {
                    putCandyIfNot()
                    letsGoIfClear()
                    letsGoIfClear()
                } while frontIsClear
                
                
                if bool == true {
                    toTheRightWithATurnBack()
                    bool = false
                } else {
                    toTheLeftWithATurnBack()
                    bool = true
                }
                
                
            }
        }
        
        else if (levelName == "L3H") { // цукерки по кутам та відцентрувати робота по висоті та ширині
            
            // нехай робот приймає випадкове місце на карті
            numberMove(number: Int.random(in: 1..<15))
            turnRight()
            numberMove(number: Int.random(in: 1..<11))
            for _ in 0..<Int.random(in: 4..<8) { turnRight() }
            // а тепер будемо розв'язувати задачу :D
            
            for _ in 0..<5 {
                l3H() // цукерки по куткам
            }
            
            
            if leftIsClear || rightIsClear {
                repeat { move() } while frontIsClear
                turnRight()
                repeat { move() } while frontIsClear
            }
                turnBack()
                middle()
            
            if leftIsClear {
                turnLeft()
                middle()
            }
            else if rightIsClear {
                turnRight()
                middle()
            }

        }
        
    }
    
    
    
    
    
// мої функції та скороченя об'єму коду
    // 1
    func middle() {
        
        var enumerator = 0
        
        repeat {
            move()
            enumerator = enumerator+1
        } while frontIsClear
        
        turnBack()
        numberMove(number: Int(enumerator/2))
    }
    // 2
    func l3H() {
        repeat {
            move()
        } while frontIsClear
        if leftIsBlocked || rightIsBlocked { putCandyIfNot() }
        turnRight()
    }
    // 3
    func toTheRightWithATurnBack() {
        if  rightIsClear {
            turnRight()
            move()
            turnRight()
        }
    }
    // 4
    func toTheLeftWithATurnBack() {
        if leftIsClear {
            turnLeft()
            move()
            turnLeft()
        }
    }
    // 5
    func turnLeft() {
        turnRight()
        turnRight()
        turnRight()
    }
    // 6
    func turnBack() {
        turnRight()
        turnRight()
    }
    // 7
    func letsGoIfClear() {
        if frontIsClear { move() }
    }
    // 8
    func putCandyIfNot() {
        if noCandyPresent { put() }
    }
    // 9
    func numberMove(number: Int) {
        for _ in 0..<number { move() }
    }
    // 10
    func numberPick(number: Int) {
        for _ in 0..<number { pick() }
    }
    // 11
    func numberPut(number: Int) {
        for _ in 0..<number { put() }
    }
}
