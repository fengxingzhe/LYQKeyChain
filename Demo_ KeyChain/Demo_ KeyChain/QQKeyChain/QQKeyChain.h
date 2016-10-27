//
//  QQKeyChain.h
//  Demo_ KeyChain
//
//  Created by a on 16/7/2.
//  Copyright © 2016年 liyunqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

#define KEY_PASSWORD  @"com.rry.app.password"
#define KEY_USERNAME_PASSWORD  @"com.rry.app.usernamepassword"

@interface QQKeyChain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

//2016.3.23最新更新
+ (void)rhKeyChainSave:(NSString *)service;

+ (NSString *)rhKeyChainLoad;

+ (void)rhKeyChainDelete:(NSString *)service;
@end
