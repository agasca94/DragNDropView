//
//  Stack.swift
//  Ornametria-iOS
//
//  Created by Aranza Tovar on 11/04/17.
//  Copyright © 2017 brounie. All rights reserved.
//

import Foundation

public class Stack<T>{
    
    private var top: Int
    private var items: [T]
    var size:Int
    
    init(){
        top = -1
        items = [T]()
        size = 0
    }
    
    func push(item: T) -> Bool {
        items.append(item)
        top += 1
        return true
    }
    
    func pop() -> T? {
        if !isEmpty() {
            top -= 1
            return items.removeLast()
        }
        return nil
    }
    
    func peek() -> T? {
        if !isEmpty() {
            return items.last
        }
        return nil
    }
    
    func count() -> Int {
        return (top + 1)
    }
    
    func printStack() {
        for i in items{
            print("|  \(i)  |")
        }
        print(" ------ ")
        print("\n\n")
    }
    
    func isEmpty() -> Bool {
        return top == -1
    }
    
    func clear(){
        top = -1
        items = [T]()
        size = 0
    }
}
