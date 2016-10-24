//
//  ViewController.swift
//  2048
//
//  Created by PIRATE on 9/28/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var score: UILabel!
    var b = Array(repeating: Array(repeating: 0, count: 4) , count : 4)
    var lose  = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        b[0][0] = 2
        //        b[1][0] = 2
        //        b[2][0] = 2
        //        b[3][0] = 2
        //        down()
        //        print("")
        let directions : [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions
        {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToswipeGesture))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
        
    }
    
    
    
    
    func randomNum (type : Int)
    {
        switch type {
        case 0: up()
        case 1: down()
        case 2: left()
        case 3: right()
        default: break
            
        }
        for col in 0...3
        {
            for row in 0...3
            {
                ConvertNumLabel(numlabel: 100 + 4 * row + col , value: String(b[row][col]))
            }
        }
        checkRandom()
        transfer()
        if lose == true {
            
            let alert = UIAlertController(title: "Game Over", message: "You Lose", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func changeBackColor(numlabel: Int, color: UIColor)
    {
        let label = self.view.viewWithTag(numlabel) as! UILabel
        label.backgroundColor = color
    }
    
    func transfer()
    {
        for i in 0...3
        {
            for j in 0...3
            {
                let numlabel = 100 + (i * 4) + j;
                
                ConvertNumLabel(numlabel: numlabel, value: String(b[i][j]));
                switch(b[i][j])
                {
                case 2,4:changeBackColor(numlabel: numlabel, color: UIColor.cyan)
                case 8,16:changeBackColor(numlabel: numlabel, color: UIColor.green)
                case 16,32:changeBackColor(numlabel: numlabel, color: UIColor.orange)
                case 64:changeBackColor(numlabel: numlabel, color: UIColor.red)
                case 128,256,512:changeBackColor(numlabel: numlabel, color: UIColor.yellow)
                case 1024,2048:changeBackColor(numlabel: numlabel, color: UIColor.purple)
                default: changeBackColor(numlabel: numlabel, color: UIColor.brown)
                }
            }
        }
    }

    
    func checkRandom()
    {
        var check = false
        for row in 0...3
        {
            if check == true {
                break
            }
            for col in 0...3
            {
                if b[row][col] == 0
                {
                    random()
                    check = true
                    break
                }
                if  row == 3 && col == 3 && b[3][3] != 0
                {
                    checkLose()
                }
            }
        }
    }
    
    
    func checkLose()
    {
        
        var checkVertical = true
        var checkHorizontal = true
        //khong di chuyen doc duoc
        
        if( b[0][0] != b[1][0] && b[1][0] != b[2][0] && b[2][0] != b[ 3][0]
            && b[0][1] != b[1][1] && b[1][1] != b[2][1] && b[2][1] != b[ 3][1]
            && b[0][2] != b[1][2] && b[1][2] != b[2][2] && b[2][2] != b[ 3][2]
            && b[0][3] != b[1][3] && b[1][3] != b[2][3] && b[2][3] != b[ 3][3])
        {
            checkVertical = false
            print("Vertical")
        }
        // khong di chuyen ngang duoc
        if( b[0][0] != b[0][1] && b[0][1] != b[0][2] && b[0][2] != b[0][3]
            && b[1][0] != b[1][1] && b[1][1] != b[1][2] && b[1][2] != b[1][3]
            && b[2][0] != b[2][1] && b[2][1] != b[2][2] && b[2][2] != b[2][3]
            && b[3][0] != b[3][1] && b[3][1] != b[3][2] && b[3][2] != b[3][3])
        {
            checkHorizontal = false
            print("Horizontal")
        }
        
        if (checkVertical == false && checkHorizontal == false)
        {
            lose = true
        }
    }
    
    
    func random()
    {
        let numb =  ( arc4random_uniform(2) + 1 ) * 2
        let row = Int ( arc4random_uniform(4))
        let col = Int (arc4random_uniform(4))
        let label = self.view.viewWithTag(100 + row * 4 + col) as! UILabel
        
        if  b[row][col] != 0
        {
            random()
        }
        else if ( b[row][col] == 0 ){
            label.text = String (numb)
            b[row][col] = Int(numb)
        }
    }
    
    
    
    func ConvertNumLabel(numlabel: Int, value: String)
    {
        let label = self.view.viewWithTag(numlabel) as! UILabel
        label.text = value
    }
    
    
    func respondToswipeGesture( gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizerDirection.right:
                print("3")
                randomNum(type: 3)
            case UISwipeGestureRecognizerDirection.left:
                print("2")
                randomNum(type: 2)
            case UISwipeGestureRecognizerDirection.down:
                print("1")
                randomNum(type: 1)
            case UISwipeGestureRecognizerDirection.up:
                print("0")
                randomNum(type: 0)
            default:
                break
            }
        }
    }
    
    
    func up()
    {
        
        for col in 0...3
        {
            var check = false
            for row in 1 ..< 4
            {
                var tx = row
                if (b[row][col] == 0)
                {
                    continue;
                }
                for rowc in (0...row - 1).reversed()
                {
                    if (b[rowc][col] != 0 && (b[rowc][col] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        tx = rowc
                        
                    }
                }
                if (tx == row)
                {
                    continue
                }
                if (b[row][col] == b[tx][col])
                {
                    check = true
                    getScore(value : b[tx][col])
                    b[tx][col] = b[tx][col] * 2
                    
                }
                else
                {
                    b[tx][col] = b[row][col]
                }
                b[row][col] = 0;
                
                
            }
        }
    }
    
    
    
    
    func down()
    {
        for col in 0...3
        {
            var check = false
            for row in 0...3
            {
                var tx = row
                if (b[row][col] == 0)
                {
                    continue
                }
                for rowc in row + 1 ..< 4
                {
                    if (b[rowc][col] != 0 && (b[rowc][col] != b[row][col] || check))
                    {
                        break;
                    }
                    else
                    {
                        tx = rowc
                        
                    }
                }
                if (tx == row)
                {
                    continue
                }
                if (b[tx][col] == b[row][col])
                {
                    check = true
                    getScore(value: b[tx][col])
                    b[tx][col] *= 2
                    
                }
                else
                {
                    b[tx][col] = b[row][col]
                }
                b[row][col] = 0;
            }
        }
    }
    func left()
    {
        for row in 0...3
        {
            var check = false
            for col in 1...3
            {
                var ty = col
                if (b[row][col] == 0)
                {
                    continue
                }
                for colc in (0...col - 1).reversed()
                {
                    if (b[row][colc] != 0 && (b[row][colc] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        ty = colc
                        
                    }
                }
                if (ty == col)
                {
                    continue;
                }
                if (b[row][ty] == b[row][col])
                {
                    check = true
                    getScore(value : b[row][ty])
                    b[row][ty] *= 2
                    
                }
                else
                {
                    b[row][ty]=b[row][col]
                }
                b[row][col] = 0
                
            }
        }
    }
    
    
    func right()
    {
        for row in 0...3
        {
            var check = false
            for col in (0...3).reversed()
            {
                var ty = col
                if (b[row][col] == 0)
                {
                    continue
                }
                for colc in col + 1 ..< 4
                {
                    if (b[row][colc] != 0 && (b[row][colc] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        ty = colc
                        
                        
                    }
                }
                if (ty == col)
                {
                    continue;
                }
                if (b[row][ty] == b[row][col])
                {
                    check = true
                    getScore(value: b[row][ty])
                    b[row][ty] *= 2
                    
                }
                else
                {
                    b[row][ty] = b[row][col]
                }
                b[row][col] = 0
                
            }
        }
    }
    
    func getScore ( value : Int)
    {
        score.text = String(Int(score.text!)! + value)
    }
    
    
}

