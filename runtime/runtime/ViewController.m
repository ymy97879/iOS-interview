//
//  ViewController.m
//  runtime
//
//  Created by ymy on 2020/8/3.
//  Copyright © 2020 ymy. All rights reserved.
//

#import "ViewController.h"
#import "Persion.h"
#import <objc/runtime.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *celiangBtn;
@property (nonatomic , strong)Persion * persion;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.persion = [[Persion alloc]init];
    self.persion.name = @"TOM";
    NSLog(@"%@",self.persion.name);
}
//1.使用runtime改变实例成员的值
- (void) changeVarName{
    //成员变量个数
     unsigned int count = 0;
     
     //获取所有的成员变量
     
     Ivar* ivar = class_copyIvarList([self.persion class], &count);
     
     //遍历
     
     for (int i = 0; i<count; i++) {
         //成员变量
         Ivar var = ivar[i];
         //实例变量名
         const char * varName = ivar_getName(var);
         //转换一下
         NSString * name = [NSString stringWithUTF8String:varName];
         
         if ([name isEqualToString:@"_name"]) {
             object_setIvar(self.persion, var, @"Jerry");
             break;
         }
     }
}
//使用runtime来动态添加方法
- (void) addMethod{
    //"v@:@ v标识void @标识id类型  ：表示 SEL方法"
    class_addMethod([self.persion class], @selector(run:), (IMP)runMethod, "v@:@");
}
-(void)run:(NSString*)type{
    
}
void runMethod(id self,SEL _cmd, NSString *miles){
    NSLog(@"%@",miles);
}
// 使用runtime交换两个方法
-(void)exchangedMethod{
    //获取方法
    Method m1 = class_getInstanceMethod([self.persion class], @selector(fristMethod));
    Method m2 = class_getInstanceMethod([self.persion class], @selector(secondMethod));
    
    //交换
    method_exchangeImplementations(m1, m2);
    
}
- (IBAction)onChangedButtonClicked:(id)sender {
 
    [self exchangedMethod];
    [self addMethod];
    
}
- (IBAction)onTestButtonClicked:(id)sender {

//    [self.persion fristMethod];
    if ([self.persion respondsToSelector:@selector(run:)]) {
        [self.persion performSelector:@selector(run:) withObject:@"1 mile"];
    }else{
        NSLog(@"方法没有实现");
    }
}

@end
