//
//  WheelView.m
//  转盘
//
//  Created by ohhh on 2017/6/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "WheelView.h"
#import "WheelButton.h"

@interface WheelView ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *centerView;

@property (nonatomic, weak) UIButton * lastBtn;

@property (nonatomic,strong) CADisplayLink *link;

@end


@implementation WheelView

+ (instancetype)wheelView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

-(CADisplayLink *)link{
    
    if (!_link) {
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(angleChange)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}


-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    _centerView.userInteractionEnabled = YES;
    
    CGFloat w = self.bounds.size.width;
    
    CGFloat btnW = 68;
    CGFloat btnH = 143;
    
    
    UIImage * image = [UIImage imageNamed:@"LuckyAstrology"];
    
    UIImage * selectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat imageW = image.size.width / 12 * scale;
    CGFloat imageH = image.size.height * scale;
    
    
    for (int i = 0; i < 12; i++) {
        
        WheelButton * btn = [WheelButton buttonWithType:UIButtonTypeCustom];
        
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        
        btn.layer.position = CGPointMake(w*0.5, w*0.5);
        
        btn.bounds = CGRectMake(0, 0, btnW, btnH);
        
        CGFloat radion = (30 * i)/180.f*M_PI;
        
        btn.transform = CGAffineTransformMakeRotation(radion);
        
        [_centerView addSubview:btn];
        
        
        CGRect clipR = CGRectMake(i*imageW, 0, imageW, imageH);
        
        CGImageRef imageR = CGImageCreateWithImageInRect(image.CGImage, clipR);
        UIImage * img = [UIImage imageWithCGImage:imageR];
        [btn setImage:img forState:UIControlStateNormal];
        
        
        CGImageRef selectedImageR = CGImageCreateWithImageInRect(selectedImage.CGImage, clipR);
        UIImage * selectedImg = [UIImage imageWithCGImage:selectedImageR];
        [btn setImage:selectedImg forState:UIControlStateSelected];
        
        
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [self btnClick:btn];
        }
    }
}

- (void)btnClick:(UIButton *)btn{
    
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
}

-(void)start{

    self.link.paused = NO;
}

-(void)pause{
    
    self.link.paused = YES;
}

// 1秒种转45度 
- (void)angleChange{
    
    CGFloat angle = (45.0/60.0)/180.0*M_PI;
    
    _centerView.transform = CGAffineTransformRotate(_centerView.transform, angle);
}


- (IBAction)startPicker:(UIButton *)sender {
    
    self.link.paused = YES;
    
    // 点击的不是实际位置  中间的转盘快速旋转 并且不需要与用户交互 所以可以用核心动画
    CABasicAnimation * anim = [CABasicAnimation animation];

    anim.keyPath = @"transform.rotation";

    anim.toValue = @(M_PI*2*3);
    
    anim.delegate = self;

    anim.duration = 0.5;

    [_centerView.layer addAnimation:anim forKey:nil];
    
    
    // 点击哪个星座 就把当前星座指向中心点上面
    // 先清空定时器旋转的角度 然后再把一开始btn布局时旋转的角度转回来
    // 根据选中的按钮获取旋转的度数
    // 通过transform获取角度
    CGFloat angle = atan2(self.lastBtn.transform.b, self.lastBtn.transform.a);
    _centerView.transform = CGAffineTransformMakeRotation(-angle);
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.link.paused = NO;
    });
}



@end
