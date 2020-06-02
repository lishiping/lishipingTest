//
//  LRUCache.m
//  ImageCache
//
//  Created by shiping li on 2019/7/29.
//  Copyright © 2019 lishiping copyright. All rights reserved.
//

#import "LRUCache.h"
@interface LRUCache ()
@property(nonatomic,strong)NSMutableArray *keys;
@property(nonatomic,strong)NSMutableDictionary *mDic;
@property(nonatomic,assign)NSInteger capacity;

@end
@implementation LRUCache

-(id)initWithCapacity:(NSInteger)capacity
{
    id instance = [[LRUCache alloc] init];
    _keys = [[NSMutableArray alloc] initWithCapacity:capacity];
    _mDic = [[NSMutableDictionary alloc] initWithCapacity:capacity];
    _capacity =capacity;
    return instance;
}
-(void)setItem:(id)item forKey:(NSString*)key
{
    if (key.length>0 && item) {
       id vv =  [_mDic objectForKey:key];
        if (vv) {
            [_keys removeObject:key];
        }
        [_mDic setObject:item forKey:key];

        [_keys insertObject:key atIndex:0];
        if(_keys.count>_capacity){
            [_keys removeObjectAtIndex:_capacity];
            NSString *kk = [_keys objectAtIndex:_capacity];
            [_mDic removeObjectForKey:kk];
        }
    }
}
-(id)getItemForkey:(NSString*)key
{
    id ret = nil;
    if (key.length>0) {
        ret = [_mDic objectForKey:key];
        if (ret) {
            [_keys removeObject:key];
            [_keys insertObject:key atIndex:0];
        }
    }
    return ret;
}
@end
