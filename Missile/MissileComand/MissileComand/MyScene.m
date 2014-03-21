//
//  MyScene.m
//  MissileComand
//
//  Created by Cassandra Sandquist on 19/03/2014.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()
{
    CGSize sizeGlobal;
    SKLabelNode *labelflowerBullets1, *labelflowerBullets2, *labelflowerBullets3, *labelMissilesExploded;
    
    int position, monstersDead, missilesExploded, flowerBullets1, flowerBullets2, flowerBullets3;
}
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor colorWithRed:(198.0/255.0) green:(220.0/255.0) blue:(54.0/255.0) alpha:1.0];
        
        position = size.width/3;
        sizeGlobal = size;
        [self addFlowerCommand];
        
        //Label Informing Missiles Exploded
        labelMissilesExploded = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
        //labelMissilesExploded = [SKLabelNode new];
        labelMissilesExploded.text = [NSString stringWithFormat:@"Missiles Exploded: %d",missilesExploded];
        labelMissilesExploded.fontSize = 30;
        labelMissilesExploded.position = CGPointMake(size.width/2,size.height-(labelMissilesExploded.frame.size.height+20));
        labelMissilesExploded.zPosition = 3;
        
        flowerBullets1 = 10;
        flowerBullets2 = 10;
        flowerBullets3 = 10;
        
        labelflowerBullets1 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
        //labelflowerBullets1 = [SKLabelNode new];
        labelflowerBullets1.text = [NSString stringWithFormat:@"%d",flowerBullets1];
        labelflowerBullets1.fontSize = 30;
        labelflowerBullets1.position = CGPointMake(position-position/2,labelflowerBullets1.frame.size.height/2);
        labelflowerBullets1.zPosition = 3;
        
        labelflowerBullets2 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
        //labelflowerBullets2 = [SKLabelNode new];
        labelflowerBullets2.text = [NSString stringWithFormat:@"%d",flowerBullets2];
        labelflowerBullets2.fontSize = 30;
        labelflowerBullets2.position = CGPointMake(position*2-position/2,labelflowerBullets2.frame.size.height/2);
        labelflowerBullets2.zPosition = 3;
        
        labelflowerBullets3 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
        //labelflowerBullets3 = [SKLabelNode new];
        labelflowerBullets3.text = [NSString stringWithFormat:@"%d",flowerBullets3];
        labelflowerBullets3.fontSize = 30;
        labelflowerBullets3.position = CGPointMake(position*3-position/2,labelflowerBullets3.frame.size.height/2);
        labelflowerBullets3.zPosition = 3;
        
        [self addChild:labelMissilesExploded];
        [self addChild:labelflowerBullets1];
        [self addChild:labelflowerBullets2];
        [self addChild:labelflowerBullets3];
    }
    return self;
}
-(void)addFlowerCommand
{
    for (int i = 0; i <= 3; i++)
    {
        SKSpriteNode *flower = [SKSpriteNode spriteNodeWithImageNamed:@"flower.png"];
        flower.zPosition = 2;
        flower.position = CGPointMake(position * i - position / 2, flower.size.height / 2);
        [self addChild:flower];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    //    for (UITouch *touch in touches) {
    //        CGPoint location = [touch locationInNode:self];
    
    //    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
