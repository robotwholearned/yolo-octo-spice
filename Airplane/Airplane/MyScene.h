//
//  MyScene.h
//  Airplane
//

//  Copyright (c) 2014 Cassandra Sandquist. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene
{
    CGRect screenRect;
    CGFloat screenHeight;
    CGFloat screenWidth;
}

@property SKSpriteNode *plane;
@property SKSpriteNode *planeShadow;
@property SKSpriteNode *propeller;

@end
