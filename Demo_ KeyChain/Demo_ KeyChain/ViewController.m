//
//  ViewController.m
//  Demo_ KeyChain
//
//  Created by a on 16/7/2.
//  Copyright © 2016年 liyunqi. All rights reserved.
//

#import "ViewController.h"
#import "QQKeyChain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //存
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    //@"...."是要存的密码字符串
    [usernamepasswordKVPairs setObject:@"...." forKey:KEY_PASSWORD];
    [QQKeyChain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
    
    //取
    usernamepasswordKVPairs = (NSMutableDictionary *)[QQKeyChain load:KEY_USERNAME_PASSWORD];
    NSLog(@"%@",[usernamepasswordKVPairs objectForKey:KEY_PASSWORD]);
    
    //删
    [QQKeyChain delete:KEY_USERNAME_PASSWORD];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
