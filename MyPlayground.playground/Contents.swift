import UIKit

//给一个数组，要求用swift写一个函数，交换数组中的两个元素

var nums = [1,2,3,4,5,6,7]

//下面是错误写法
//func swap(_ nums: inout [Int], _ a :Int, _ b : Int){
//    let tmp = nums[a]
//    nums[a] = nums[b]
//    nums[b] = tmp
//}
//添加泛型  如果输入的是float double情况
//func swap<T>(_ nums: inout [T], _ a :Int, _ b : Int){
//    let tmp = nums[a]
//    nums[a] = nums[b]
//    nums[b] = tmp
//}
//此为防止数组越界输入的问题的严谨写法
func swap<T>(_ nums: inout [T], _ a : Int, _ b : Int){
    let count = nums.count
    if a == b || a < 0 || a > count - 1 || b < 0 || b > count - 1  {
        return
    }
    //原始替换方法
//    let tmp = nums[a]
//    nums[a] = nums[b]
//    nums[b] = tmp
    //下面为元组替换方法
    (nums[a], nums[b]) = (nums[b], nums[a])
}

swap(&nums, 1, 5)

print(nums)



//使用swift实现一个函数，输入是任一整数 输出要返回输入的整数 +2

func addTwo(input:Int) -> Int{
    return input + 2
}

//使用swift实现一个函数，输入是任一整数 输出要返回输入的整数 +任意数

//什么是柯里化
//柯里化指是从一个多参数函数变成一连串但参数函数的变换
//下面可以理解为一个闭包或者是一个函数
func add(input: Int) -> (Int) -> Int{
    return{
        value in
        return input + value
    }
}
let oldaddtwo = addTwo(input: 100)

let addTwo = add(input: 100)
let output = addTwo(3)

print(oldaddtwo)

print(output)

class BankCard {
    //余额
    var balance : Double = 0.0
    //存钱方法
    func deposit(amount: Double) {
        balance += amount
        print("balance = \(balance)")
    }
}
//正常使用
let card = BankCard()
card.deposit(amount: 100)

//柯里化调用方法
//let deposit = BankCard.deposit
//deposit(card)(100)

//实际展现
let deposit : (BankCard) -> (Double) -> () = BankCard.deposit
let depositIntoCard = deposit(card)
depositIntoCard(100)


//简化下面代码
func division(dividend :Double?, by divisor: Double?) -> Double?{
    if dividend == nil{
        return nil
    }
    if divisor == nil {
        return nil
    }
    if divisor == 0 {
        return nil
    }
    return dividend! / divisor!
}

//if let 和可选链式调用
func division1(dividend :Double?, by divisor: Double?) -> Double?{
    if let dividend = dividend, let divisor = divisor, divisor != 0
    {
        return dividend / divisor
    }
    
    return nil
    
}

//if get 和可选链式调用
func division2(dividend :Double?, by divisor: Double?) -> Double?{
    guard let dividend = dividend, let divisor = divisor, divisor != 0 else {
           return nil
    }
        return dividend / divisor
    
}

//这段代码打印出来会是什么
//考察全局变量和局部变量的问题
var car = "Benz"
let  closure = {
    [car] in//此段代码调用的时候为局部变量打印的为benz 将此段代码注释之后则可以更改成BMW
    print("I drive ,\(car)")
}
car = "BMW"
closure()
