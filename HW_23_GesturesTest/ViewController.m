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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView* viewBall = [[UIImageView alloc] initWithFrame:CGRectMake(125, 125, 125, 125)];

    viewBall.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    viewBall.backgroundColor = [UIColor clearColor];
    
    UIImage* image1 = [UIImage imageNamed:@"Ball.jpeg"];
    
    viewBall.image = image1;
    
    [self.view addSubview:viewBall];
    
    self.testView = viewBall;
    
    UITapGestureRecognizer* tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                         action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    //UIView animateWithDuration:0.3f animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>
    
    CGFloat r = (float)(arc4random() % (int)(M_PI * 2*10000)) / 10000 - M_PI;
    
    [UIView animateWithDuration:0.8f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear /*| UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse*/
                     animations:^{
                         self.testView.center = [tapGesture locationInView:self.view];
                         //view.backgroundColor = [self randomColor];
                         
                         //CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
                         //¬CGAffineTransform rotation = CGAffineTransformMakeRotation(r);
                         
                         CGAffineTransform transform = CGAffineTransformMakeRotation(r);//CGAffineTransformConcat(scale, rotation);
                         
                         self.testView.transform = transform;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"animation finished! %d", finished);
                         NSLog(@"\nview frame = %@\nview bounds = %@", NSStringFromCGRect(self.testView.frame), NSStringFromCGRect(self.testView.bounds));
                         
                         
                         //__weak UIView* v = view;
                         //[self moveView:v];
                     }];
}

@end
