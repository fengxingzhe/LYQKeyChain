//
//  QQKeyChain.m
//  Demo_ KeyChain
//
//  Created by a on 16/7/2.
//  Copyright © 2016年 liyunqi. All rights reserved.
//

#import "QQKeyChain.h"

@implementation QQKeyChain
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            //OC对象和CF对象之间的桥接(bridge) 在开发iOS应用程序时我们有时会用到Core Foundation对象简称CF
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}


#pragma mark =======================================================
static NSString * const kRHDictionaryKey = @"com.xxxx.dictionaryKey";
static NSString * const kRHKeyChainKey = @"com.xxxx.keychainKey";

+ (void)rhKeyChainSave:(NSString *)service {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:service forKey:kRHDictionaryKey];
    [self save:kRHKeyChainKey data:tempDic];
}

+ (NSString *)rhKeyChainLoad{
    NSMutableDictionary *tempDic = (NSMutableDictionary *)[self load:kRHKeyChainKey];
    return [tempDic objectForKey:kRHDictionaryKey];
}

+ (void)rhKeyChainDelete{
    [self delete:kRHKeyChainKey];
}
@end
