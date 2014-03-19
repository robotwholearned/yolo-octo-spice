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
        
        
        //adding the smokeTrail
        NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"trail" ofType:@"sks"];
        _smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
        _smokeTrail.position = CGPointMake(screenWidth/2, 15);
        
        [self addChild:background];
        [self addChild:_plane];
        [self addChild:_planeShadow];
        [self addChild:_propeller];
        [self addChild:_smokeTrail];
        
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
        //wait for one and then run EnemiesAndClouds, repeat forever
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction waitForDuration:1],[SKAction runBlock:^{[self EnemiesAndClouds];}]]]]];
        
    }
    return self;
}
-(void)EnemiesAndClouds
{
    //CGPathAddCurveToPoint - creates a BEzier curve, with two control points
    int goOrNot = [self getRandomNumberBetween:0 to:1];
    if (goOrNot == 1)
    {
        SKSpriteNode *enemy;
    
        int randomEnemy = [self getRandomNumberBetween:0 to:1];
        if(randomEnemy == 0)
            enemy = [SKSpriteNode spriteNodeWithImageNamed:@"PLANE 1 N.png"];
        else
            enemy = [SKSpriteNode spriteNodeWithImageNamed:@"PLANE 2 N.png"];

        enemy.scale = 0.6;
        enemy.position = CGPointMake(screenRect.size.width/2, screenRect.size.height/2);
        enemy.zPosition = 1;
        
        CGMutablePathRef cgpath = CGPathCreateMutable();
        
        //random values
        float xStart = [self getRandomNumberBetween:0+enemy.size.width to:screenRect.size.width-enemy.size.width ];
        float xEnd = [self getRandomNumberBetween:0+enemy.size.width to:screenRect.size.width-enemy.size.width ];
        
        //ControlPoint1
        float cp1X = [self getRandomNumberBetween:0+enemy.size.width to:screenRect.size.width-enemy.size.width ];
        float cp1Y = [self getRandomNumberBetween:0+enemy.size.width to:screenRect.size.width-enemy.size.height ];
        
        //ControlPoint2
        float cp2X = [self getRandomNumberBetween:0+enemy.size.width to:screenRect.size.width-enemy.size.width ];
        float cp2Y = [self getRandomNumberBetween:0 to:cp1Y];
        
        CGPoint s = CGPointMake(xStart, 1024.0);
        CGPoint e = CGPointMake(xEnd, -100.0);
        CGPoint cp1 = CGPointMake(cp1X, cp1Y);
        CGPoint cp2 = CGPointMake(cp2X, cp2Y);;
        CGPathMoveToPoint(cgpath, NULL, s.x, s.y);
        CGPathAddCurveToPoint(cgpath, NULL, cp1.x, cp1.y, cp2.x, cp2.y, e.x, e.y);
        
        SKAction *planeDestroy = [SKAction followPath:cgpath asOffset:NO orientToPath:YES duration:5];
        [self addChild:enemy];
        
     
        SKAction *remove = [SKAction removeFromParent];
        [enemy runAction:[SKAction sequence:@[planeDestroy, remove]]];
        
        CGPathRelease(cgpath);
    }
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random()%(to-from + 1);
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
    float maxX, maxY, minX, minY, newY, newX, newXshadow, newYshadow, newXpropeller, newYpropeller;
    
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
    
    newXshadow = newX+self.planeShadow.position.x;
    newYshadow = newY+self.planeShadow.position.y;
    
    newXshadow = MIN(MAX(newXshadow,minY+15),maxY+15);
    newYshadow = MIN(MAX(newYshadow,minX-15),maxX-15);
    
    newXpropeller = newX+self.propeller.position.x;
    newYpropeller = newY+self.propeller.position.y;
    
    newXpropeller = MIN(MAX(newXpropeller,minY),maxY);
    newYpropeller = MIN(MAX(newYpropeller,minX+(self.plane.size.height/2)-5),maxX+(self.plane.size.height/2)-5);
    
    newX = MIN(MAX(newX+self.plane.position.x,minY),maxY);
    newY = MIN(MAX(newY+self.plane.position.y,minX),maxX);
    
    self.plane.position = CGPointMake(newX, newY);
    self.planeShadow.position = CGPointMake(newXshadow, newYshadow);
    self.propeller.position = CGPointMake(newXpropeller, newYpropeller);
    self.smokeTrail.position = CGPointMake(newX,newY-(self.plane.size.height/2));
}
@end
