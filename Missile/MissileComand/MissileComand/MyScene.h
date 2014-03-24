//
//  MyScene.h
//  MissileComand
//

//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger
{
    ExplosionCategory   = (1 << 0),
    MissileCategory     = (1 << 1),
    MonsterCategory     = (1 << 2)
} NodeCategory;

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@end
