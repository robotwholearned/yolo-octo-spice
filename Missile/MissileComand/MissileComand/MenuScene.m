//
//  MenuScene.m
//  MissileComand
//
//  Created by Cassandra Sandquist on 19/03/2014.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.backgroundColor = [SKColor colorWithRed:(198.0/255.0) green:(220.0/255.0) blue:(54.0/255.0) alpha:1.0];
        SKSpriteNode *title = [SKSpriteNode spriteNodeWithImageNamed:@"title"];
        title.zPosition = 2;
        title.scale = 0.5;
        title.position = CGPointMake(size.width/2, size.height/2);
        
        title.blendMode = SKBlendModeAdd;
        
        [self addChild:title];
    }
    return self;
}
@end
