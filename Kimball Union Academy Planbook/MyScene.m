//
//  MyScene.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/21/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "MyScene.h"

//used to display particles

@implementation MyScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        [self newExplosion];
        
        
    }
    return self;
}

//particle explosion - uses MyParticle.sks
- (void) newExplosion
{
    SKEmitterNode *emitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"]];
    emitter.position = CGPointMake(self.frame.size.width * .5, 100);
    emitter.name = @"explosion";
    emitter.targetNode = self.scene;
    emitter.numParticlesToEmit = 0;
    emitter.zPosition=2.0;
    [self addChild:emitter];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins
    
    
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
