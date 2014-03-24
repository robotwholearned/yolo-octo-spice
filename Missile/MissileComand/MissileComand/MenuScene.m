//
//  MenuScene.m
//  MissileComand
//
//  Created by Cassandra Sandquist on 19/03/2014.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "MenuScene.h"
#import "MyScene.h"
#import "MultiScene.h"

@interface MenuScene ()
{
    CGSize sizeGlobal;
    UIButton *singlePlayerButton;
    UIButton *multiplayerButton;
}

@end

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
        //title.position = CGPointMake(self.frame.size.width/2-(title.size.width/2), self.frame.size.height/2-(title.size.height/2));
        title.position = CGPointMake(0, 0);
        
        title.blendMode = SKBlendModeAdd;
        
        [self addChild:title];
        
        sizeGlobal = size;
    }
    return self;
}
-(void)didMoveToView:(SKView *)view
{
    //to present the buttons when the game transitions to the menu view.
    
    UIImage *buttonImageSingle = [UIImage imageNamed:@"singleBtn"];
    singlePlayerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSLog(@"%f, %f", sizeGlobal.height, sizeGlobal.width);
    
    singlePlayerButton.frame = CGRectMake(sizeGlobal.height/8, sizeGlobal.width/2+250, buttonImageSingle.size.width, buttonImageSingle.size.height);
    
    NSLog(@"%f, %f", singlePlayerButton.frame.origin.x, singlePlayerButton.frame.origin.y);
    
    singlePlayerButton.backgroundColor = [UIColor clearColor];
    [singlePlayerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *strechableButtonImageSingle = [buttonImageSingle stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [singlePlayerButton setBackgroundImage:strechableButtonImageSingle forState:UIControlStateNormal];
    [singlePlayerButton addTarget:self action:@selector(moveToSinglePlayerGame) forControlEvents:UIControlEventTouchUpInside];

    UIImage *buttonImageMulti = [UIImage imageNamed:@"multiBtn"];
    multiplayerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    multiplayerButton.frame = CGRectMake(sizeGlobal.height/2+100, sizeGlobal.width/2+250, buttonImageMulti.size.width, buttonImageMulti.size.height);
    multiplayerButton.backgroundColor = [UIColor clearColor];
    [multiplayerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *strechableButtonImageMulti = [buttonImageMulti stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [multiplayerButton setBackgroundImage:strechableButtonImageMulti forState:UIControlStateNormal];
    [multiplayerButton addTarget:self action:@selector(moveToMultiPlayerGame) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:singlePlayerButton];
    [self.view addSubview:multiplayerButton];
    
}
//Create an instance of either MyScene or MultiScene.
//Create a scene transition.
//Present the new scene.
//Remove the buttons.
-(void)moveToSinglePlayerGame
{
    SKScene * scene = [MyScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [(SKView *)self.view presentScene:scene transition:[SKTransition revealWithDirection:SKTransitionDirectionLeft duration:0.0]];
    [self cleanupButtons];
}
-(void)moveToMultiPlayerGame
{
    SKScene * scene = [MultiScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [(SKView *)self.view presentScene:scene transition:[SKTransition revealWithDirection:SKTransitionDirectionLeft duration:0.0]];
    [self cleanupButtons];
}
-(void)cleanupButtons
{
    [singlePlayerButton removeFromSuperview];
    [multiplayerButton removeFromSuperview];
}
@end
