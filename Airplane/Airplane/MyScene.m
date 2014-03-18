//
//  MyScene.m
//  Airplane
//
//  Created by Cassandra Sandquist on 3/15/2014.
//  Copyright (c) 2014 Cassandra Sandquist. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        screenRect = [[UIScreen mainScreen] bounds];
        screenHeight = screenRect.size.height;
        screenWidth = screenRect.size.width;
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"airPlanesBackground"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        _plane = [SKSpriteNode spriteNodeWithImageNamed:@"PLANE 8 N"];
        _plane.scale = 0.6;
        _plane.zPosition = 2;
        _plane.position = CGPointMake(screenWidth/2, 15+_plane.size.height/2);
        
        _planeShadow = [SKSpriteNode spriteNodeWithImageNamed:@"PLANE 8 SHADOW"];
        _planeShadow.scale = 0.6;
        _planeShadow.zPosition = 1;
        _planeShadow.position = CGPointMake(screenWidth/2+15, 0+_plane.size.height/2);
        
        _propeller = [SKSpriteNode spriteNodeWithImageNamed:@"PLANE PROPELLER 1"];
        _propeller.scale = 0.2;
        _propeller.position = CGPointMake(screenWidth/2, _plane.size.height+10);
        _propeller.zPosition = 3;
        
        SKTexture *propeller1 = [SKTexture textureWithImageNamed:@"PLANE PROPELLER 1"];
        SKTexture *propeller2 = [SKTexture textureWithImageNamed:@"PLANE PROPELLER 2"];
        
        SKAction *spin = [SKAction animateWithTextures:@[propeller1, propeller2] timePerFrame:0.1];
        SKAction *spinForever = [SKAction repeatActionForever:spin];
        [_propeller runAction:spinForever];
        
        
        [self addChild:background];
        [self addChild:_plane];
        [self addChild:_planeShadow];
        [self addChild:_propeller];
        
        self.motionManager   = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = 0.2;
        
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             [self outputAccelertionData:accelerometerData.acceleration];
             if(error)
             {
                 NSLog(@"%@", error);
             }
             
         }];
    }
    return self;
}
//Now that you have the values of the accelerometer
-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    
    //    x - X-axis acceleration in G's (gravitational force).
    //    y - Y-axis acceleration in G's (gravitational force).
    //    z - Z-axis acceleration in G's (gravitational force).
    
    if(fabs(acceleration.x) > fabs(currentMaxAccelX))
    {
        currentMaxAccelX = acceleration.x;
    }
    if(fabs(acceleration.y) > fabs(currentMaxAccelY))
    {
        currentMaxAccelY = acceleration.y;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    //for (UITouch *touch in touches) {}
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    float maxX, maxY, minX, minY, newY, newX;
    
    maxY = screenWidth - self.plane.size.width/2;
    minY = self.plane.size.width/2;
    
    maxX = screenHeight - self.plane.size.height/2;
    minX = self.plane.size.height/2;
    
    newY = 0;
    newX = 0;
    
    newX = currentMaxAccelX * 10;
    
    if(currentMaxAccelX > 0.05)
    {
        self.plane.texture = [SKTexture textureWithImageNamed:@"PLANE 8 R"];
    }
    else if (currentMaxAccelX < -0.05)
    {
        self.plane.texture = [SKTexture textureWithImageNamed:@"PLANE 8 L"];
    }
    else
    {
        self.plane.texture = [SKTexture textureWithImageNamed:@"PLANE 8 N"];
    }
    newY = 6.0 + currentMaxAccelY * 10;
    
    
}
@end
