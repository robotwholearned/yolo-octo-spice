//
//  MenuScene.m
//  MissileComand
//
//  Created by Cassandra Sandquist on 19/03/2014.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "MenuScene.h"

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
        title.position = CGPointMake(size.width/2, size.height/2);
        
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
    
    singlePlayerButton.frame = CGRectMake(view.frame.size.width/2 -( buttonImageSingle.size.height*2), view.frame.size.height, buttonImageSingle.size.width, buttonImageSingle.size.height);
    
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
-(void)moveToSinglePlayerGame
{
    //transitions the game to the MyScene scene and removes the buttons.
}
-(void)moveToMultiPlayerGame
{
    //transitions the game to the MultiScene scene and also removes the buttons.
}
@end
