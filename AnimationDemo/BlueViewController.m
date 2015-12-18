//
//  BlueViewController.m
//  AnimationDemo3
//
//  Created by He yang on 15/12/18.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "BlueViewController.h"
#import "ViewController.h"
#import "KYBubbleTransition.h"
@interface BlueViewController ()<UINavigationControllerDelegate>

@end

@implementation BlueViewController{
//    KYBubbleInteractiveTransition *transition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    //    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    //    edgeGes.edges = UIRectEdgeLeft;
    //    [self.view addGestureRecognizer:edgeGes];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
//    return transition;
//}
//
//-(void)edgePan:(UIPanGestureRecognizer *)recognizer{
//    CGFloat per = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
//    per = MIN(1.0,(MAX(0.0, per)));
//
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        transition = [[KYBubbleInteractiveTransition alloc]init];
//        ViewController *vc = (ViewController *) [[UIViewController alloc] init];
//        [transition addPopGesture:vc];
//
//
//        [self.navigationController popViewControllerAnimated:YES];
//    }else if (recognizer.state == UIGestureRecognizerStateChanged){
//        [transition updateInteractiveTransition:per];
//    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
//        if (per > 0.3) {
//            [transition finishInteractiveTransition];
//        }else{
//            [transition cancelInteractiveTransition];
//        }
//        transition = nil;
//    }
//}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        
        KYBubbleTransition *popTransiton = [KYBubbleTransition new];
        
        popTransiton.startPoint = self.view.center;
        
        popTransiton.transitionMode = Dismiss;
        popTransiton.duration = 0.3;
        popTransiton.bubbleColor = [UIColor colorWithRed:0 green:127/255 blue:255/255 alpha:1];
        
        return popTransiton;
    }else{
        return nil;
    }
}

- (IBAction)popClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
