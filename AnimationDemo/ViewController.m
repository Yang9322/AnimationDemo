//
//  ViewController.m
//  AnimationDemo
//
//  Created by He yang on 15/12/17.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "ViewController.h"
#import "KYBubbleTransition.h"
#import "BlueViewController.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define HEIGHT 200
#define BUTTONCOUNT 5

@interface ViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *blueBtn;
@property (weak, nonatomic) IBOutlet UIButton *orrangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowBtn;
@property (nonatomic,weak)BlueViewController *blueVc;

@end

@implementation ViewController{
    BOOL triggered;
    UIView *bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"bubleAnimation";
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, HEIGHT)];
    bottomView.backgroundColor = [UIColor blueColor];
    for (id subview in bottomView.subviews) {
        [subview removeFromSuperview];
    }
    [self.view addSubview:bottomView];
    
    
    for (int i = 0; i < BUTTONCOUNT; i++) {
        UIButton *button = [[UIButton alloc] init];
        CGFloat buttonWidth = SCREENWIDTH / 4;
        CGFloat buttonHeight = HEIGHT / 2;
        int row = i / 4;
        int line = i % 4;
        button.frame = CGRectMake(line * buttonWidth, row * buttonHeight, buttonWidth, buttonHeight);
        [button setTitle:[NSString stringWithFormat:@"第%d个",i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        [bottomView addSubview:button];
    }
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)blueBtnCliked:(id)sender {
    BlueViewController *blueController = [[BlueViewController alloc] init];
    _blueVc = blueController;
    [self.navigationController pushViewController:blueController animated:YES];
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, HEIGHT);
        
    }];
    
}



- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        
        KYBubbleTransition *bubleTransition = [KYBubbleTransition new];
        if (_blueVc == toVC) {
            bubleTransition.startPoint = self.blueBtn.center;
        }
        bubleTransition.transitionMode = Present;
        bubleTransition.duration = 0.3;
        bubleTransition.bubbleColor = [UIColor colorWithRed:0 green:127/255 blue:255/255 alpha:1];
        
        return bubleTransition;
    }else{
        return nil;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    
    NSArray *btnAry = [NSArray arrayWithObjects:self.blueBtn,self.orrangeBtn,self.redButton,self.yellowBtn,nil];
    self.redButton.transform = CGAffineTransformMakeTranslation(-29, 700);
    self.blueBtn.transform = CGAffineTransformMakeTranslation(20, 700);
    self.orrangeBtn.transform = CGAffineTransformMakeTranslation(40, 700);
    self.yellowBtn.transform = CGAffineTransformMakeTranslation(60, 700);
    
    for (int i = 0; i < btnAry.count; i ++) {
        [UIView animateWithDuration:1 delay:i * 0.15 usingSpringWithDamping:1 initialSpringVelocity:0.8 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            UIButton *btn = btnAry[i];
            btn.transform = CGAffineTransformIdentity;
            
            
        } completion:^(BOOL finished){
            
            if ( i == btnAry.count - 1) {
                
                for (UIButton *btn in btnAry) {
                    
                    
                    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                    //                    pathAnimation.calculationMode = kCAAnimationPaced;
                    pathAnimation.fillMode = kCAFillModeForwards;
                    pathAnimation.removedOnCompletion = false;
                    pathAnimation.repeatCount = MAXFLOAT;
                    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                    if (btn == self.yellowBtn) {
                        pathAnimation.duration = 5.0;
                    }else if (btn == self.orrangeBtn){
                        pathAnimation.duration = 6.0;
                    }else if (btn == self.redButton){
                        pathAnimation.duration = 7.0;
                    }else if (btn == self.blueBtn){
                        pathAnimation.duration = 8.0;
                    }
                    //设置button移动路径
                    CGMutablePathRef ellipsePath = CGPathCreateMutable();
                    
                    CGRect circleContainer = CGRectInset(btn.frame, btn.frame.size.width/2 - 3 , btn.frame.size.width / 2 - 3);
                    
                    
                    CGPathAddEllipseInRect(ellipsePath, nil, circleContainer);
                    pathAnimation.path = ellipsePath;
                    [btn.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
                    
                    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
                    scaleX.values = @[@1.0,@1.1,@1.0];
                    scaleX.keyTimes = @[@0.0,@0.5,@1.0];
                    scaleX.repeatCount = MAXFLOAT;
                    scaleX.autoreverses = YES;
                    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                    if (btn == self.yellowBtn) {
                        scaleX.duration = 3;
                    }else if (btn == self.orrangeBtn){
                        scaleX.duration = 4;
                    }else if (btn == self.redButton){
                        scaleX.duration = 6;
                    }else if (btn == self.blueBtn){
                        scaleX.duration = 5;
                    }
                    [btn.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
                    
                    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
                    scaleY.values = @[@1.0,@1.1,@1.0];
                    scaleY.keyTimes = @[@0.0,@0.5,@1.0];
                    scaleY.repeatCount = MAXFLOAT;
                    scaleY.autoreverses = YES;
                    scaleY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                    if (btn == self.yellowBtn) {
                        scaleY.duration = 4;
                    }else if (btn == self.orrangeBtn){
                        scaleY.duration = 5;
                    }else if (btn == self.redButton){
                        scaleY.duration = 2;
                    }else if (btn == self.blueBtn){
                        scaleY.duration = 3;
                    }
                    [btn.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
                    
                    
                    
                    
                }
                
            }
        }];
    }
    
}

-(void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    
    CGPoint translationPoint = [gestureRecognizer translationInView:self.view];
    
    CGFloat translationY = translationPoint.y;
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (translationY < -20 &&translationY > - 220) {
            if (triggered) {
                return;
            }
            CGFloat realOffsetY = translationY + 20;
            NSLog(@" 111---  %f ---111",realOffsetY );
            
            CGFloat frameY = SCREENHEIGHT + realOffsetY;
            [UIView animateWithDuration:1/ 60 animations:^{
                bottomView.frame = CGRectMake(0, frameY, SCREENWIDTH, HEIGHT);
            }];
        }else if (translationY > 20){
            if (triggered) {
                CGFloat realOffsetY = translationY - 20;
                
                CGFloat frameY = SCREENHEIGHT-HEIGHT + realOffsetY;
                [UIView animateWithDuration:1/ 60 animations:^{
                    bottomView.frame = CGRectMake(0, frameY, SCREENWIDTH, HEIGHT);
                }];
            }
        }
        
        
    }else if (gestureRecognizer.state == UIGestureRecognizerStateCancelled || gestureRecognizer.state == UIGestureRecognizerStateEnded){
        
        
        if (triggered) {
            if (translationY > 100){
                [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    bottomView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, HEIGHT);
                    triggered = NO;
                }completion:^(BOOL finished) {
                }];
            }else{
                [UIView animateWithDuration:0.3 animations:^{
                    bottomView.frame = CGRectMake(0, SCREENHEIGHT - HEIGHT, SCREENWIDTH, HEIGHT);
                }];
                triggered = YES;
            }
        }else{
            if (translationY < - 100) {
                [UIView animateWithDuration:0.3 animations:^{
                    bottomView.frame = CGRectMake(0, SCREENHEIGHT-HEIGHT, SCREENWIDTH, HEIGHT);
                    triggered = YES;
                }];
            }else{
                [UIView animateWithDuration:0.3 animations:^{
                    bottomView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, HEIGHT);
                    triggered = NO;
                }];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)trigger:(id)sender {
    
    
    triggered = !triggered;
    if (triggered) {
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            bottomView.frame = CGRectMake(0, SCREENHEIGHT-HEIGHT, SCREENWIDTH, HEIGHT);
            for (int i = 0; i < bottomView.subviews.count; i ++) {
                
            }
        } completion:^(BOOL finished) {
            
            
        }];
        
        [self animateButtons];
        
        
    }else{
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            bottomView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, HEIGHT);
            
        }completion:^(BOOL finished) {
            
            
        }];
    }
}



-(void)animateButtons{
    
    
    for (NSInteger i = 0; i < bottomView.subviews.count; i++) {
        
        UIButton *button = bottomView.subviews[i];
        button.transform = CGAffineTransformMakeTranslation(0, SCREENHEIGHT + 90);
        
        [UIView animateWithDuration:0.7 delay:i*(0.3/bottomView.subviews.count) usingSpringWithDamping:0.7f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            
            button.transform =  CGAffineTransformIdentity;
            
        } completion:NULL];
        
    }
    
    
}
@end
