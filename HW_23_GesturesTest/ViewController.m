//
//  ViewController.m
//  HW_23_GesturesTest
//
//  Created by Romanos on 6/29/16.
//  Copyright © 2016 Roman Kotelevits. All rights reserved.
//

/*
 
Урок № 23 - GesturesTest
 
 Ученик
 
 1. Добавьте квадратную картинку на вьюху вашего контроллера
 2. Если хотите, можете сделать ее анимированной
 
 Студент
 
 3. По тачу анимационно передвигайте картинку со ее позиции в позицию тача
 4. Если я вдруг делаю тач во время анимации, то картинка должна двигаться в новую точку без рывка (как будто она едет себе и все)
 
 Мастер
 
 5. Если я делаю свайп вправо, то давайте картинке анимацию поворота по часовой стрелке на 360 градусов
 6. То же самое для свайпа влево, только анимация должна быть против часовой (не забудьте остановить предыдущее кручение)
 7. По двойному тапу двух пальцев останавливайте анимацию
 
 Супермен
 
 8. Добавьте возможность зумить и отдалять картинку используя пинч
 9. Добавьте возможность поворачивать картинку используя ротейшн
 
 
 */



#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView* testView;
@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView* viewBall = [[UIImageView alloc] initWithFrame:CGRectMake(125, 125, 125, 125)];

    viewBall.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    viewBall.backgroundColor = [UIColor clearColor];
    
    UIImage* image1 = [UIImage imageNamed:@"ball.jpeg"];
    
    viewBall.image = image1;
    
    [self.view addSubview:viewBall];
    
    self.testView = viewBall;
    
    UITapGestureRecognizer* tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                         action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapGesture];

    UITapGestureRecognizer* doubleTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                         action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:doubleTapGesture];
    
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    UITapGestureRecognizer* doubleTapDoubleTouchGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                         action:@selector(handleDoubleTapDoubleTouch:)];
    
    doubleTapDoubleTouchGesture.numberOfTapsRequired = 2;
    doubleTapDoubleTouchGesture.numberOfTouchesRequired = 2;
    
    [self.view addGestureRecognizer:doubleTapDoubleTouchGesture];
    
    
    UISwipeGestureRecognizer* horizontalRightSwipe =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleHorizontalRightSwipe:)];
    
    horizontalRightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    horizontalRightSwipe.delegate = self;
    
    [self.view addGestureRecognizer:horizontalRightSwipe];

    UISwipeGestureRecognizer* horizontalLeftSwipe =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleHorizontalLeftSwipe:)];
    
    horizontalLeftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    horizontalLeftSwipe.delegate = self;
    
    [self.view addGestureRecognizer:horizontalLeftSwipe];
    
    
    UIPinchGestureRecognizer* pinchGesture =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    
    [self.view addGestureRecognizer:pinchGesture];
    
    
    UIRotationGestureRecognizer* rotationGesture =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(handleRotation:)];
    
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    //[self.testView.layer removeAllAnimations];
    
    CGFloat r = (float)(arc4random() % (int)(M_PI * 2*10000)) / 10000 - M_PI;
    
    [UIView animateWithDuration:0.8f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear /*| UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse*/
                     animations:^{
                         self.testView.center = [tapGesture locationInView:self.view];
                         
                         CGAffineTransform transform = CGAffineTransformMakeRotation(r);//CGAffineTransformConcat(scale, rotation);
                         
                         self.testView.transform = transform;

                     }
                     completion:^(BOOL finished) {
                         //NSLog(@"animation finished! %d", finished);
                         //NSLog(@"\nview frame = %@\nview bounds = %@", NSStringFromCGRect(self.testView.frame), NSStringFromCGRect(self.testView.bounds));
                     }];
}


- (void) handleDoubleTapDoubleTouch:(UIGestureRecognizer*) doubleTapDoubleTouchGesture {
    
    NSLog(@"Double tap double touch: %@", NSStringFromCGPoint([doubleTapDoubleTouchGesture locationInView:self.view]));
    
    [self.testView.layer removeAllAnimations];
    
}

- (void) handleDoubleTap: (UITapGestureRecognizer*) doubleTapGesture {
    
    NSLog(@"Double tap: %@", NSStringFromCGPoint([doubleTapGesture locationInView:self.view]));
    
    [self.testView.layer removeAllAnimations];
    
}

- (void) handleHorizontalRightSwipe: (UISwipeGestureRecognizer*) swipeGesture {
    
    NSLog(@"Horizontal Right Swipe: %@", NSStringFromCGPoint([swipeGesture locationInView:self.view]));
   
    [self rotateView:self.testView angleOfRotation:3.14 withRotate:true];
    
}


- (void) handleHorizontalLeftSwipe: (UISwipeGestureRecognizer*) swipeGesture {
    
    NSLog(@"Horizontal Left Swipe: %@", NSStringFromCGPoint([swipeGesture locationInView:self.view]));
    
    [self rotateView:self.testView angleOfRotation:-3.14 withRotate:true];
    
}


- (void) rotateView:(UIView*) view angleOfRotation:(CGFloat) angle withRotate:(BOOL) rotate {
    
    CGAffineTransform newRotation = CGAffineTransformRotate(self.testView.transform, angle);
    
    [view.layer removeAllAnimations];
    
    [UIView animateWithDuration:0.6 //animateKeyframesWithDuration
                          delay:0
                        options:UIViewAnimationCurveLinear|UIViewAnimationOptionBeginFromCurrentState//UIViewAnimationOptionRepeat//|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.testView.transform = newRotation;
                     } completion:^(BOOL finished) {
                         //__weak UIView* wTestView = self.testView;
                         if (rotate) {
                             __weak UIView* weakRotateView = view;
                             
                             [self rotateView: weakRotateView angleOfRotation:angle withRotate:false];
                         }
                     }];
    
}

- (void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    
    //NSLog(@"Pinch gesture: %@", NSStringFromCGPoint([pinchGesture locationInView:self.view]));
    NSLog(@"handlePinch %1.3f", pinchGesture.scale);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1.f;
    }
    
    CGFloat newScale = 1.f + pinchGesture.scale - self.testViewScale;
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.testView.transform = newTransform;
    
    self.testViewScale = pinchGesture.scale;
    
}


- (void) handleRotation:(UIRotationGestureRecognizer*) rotationGesture {
    
    
    NSLog(@"handleRotation %1.3f", rotationGesture.rotation);
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.testViewRotation;
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.testView.transform = newTransform;
    
    self.testViewRotation = rotationGesture.rotation;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]];
}

@end
