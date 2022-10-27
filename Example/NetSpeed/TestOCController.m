//
//  TestOCController.m
//  NetSpeed_Example
//
//  Created by CPCoder on 27/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import "TestOCController.h"
@import NetSpeed;

@interface TestOCController ()<NetSpeedProtocol>

@end

@implementation TestOCController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [NetSpeed.shared stop];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NetSpeed.shared.delegate = self;
    [NetSpeed.shared beginWithDuration:1];
}

- (void)didSentWithOctets:(uint32_t)octets {
    
}

- (void)didReceivedWithOctets:(uint32_t)octets {
    
}

@end
