//
//  ScreenTestView.m
//  ScreenTest
//
//  Created by Anthony Fruzza on 12/4/16.
//  Copyright © 2016 Anthony Fruzza. All rights reserved.
//

#import "ScreenTestView.h"

#define SPRITE_WIDTH  16
#define SPRITE_HEIGHT 15
#define H_PIXEL_RATIO 180
#define V_PIXEL_RATIO 100
#define COLOR_TRANSPARENT 7


@implementation ScreenTestView
float offset_x, offset_y;
- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/3.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    NSBezierPath *path;
    NSRect rect;
    NSSize size;
    NSColor *color;
    unsigned int indexColor, imagePicker;
    
    CGFloat alphaVal  = 1;
    NSArray *colorMap = @[
                          // 0 Black
                          [NSColor colorWithCalibratedRed: 0.0
                                                    green: 0.0
                                                     blue: 0.0
                                                    alpha: alphaVal
                           ],
                          // 1 White
                          [NSColor colorWithCalibratedRed: 255/255
                                                    green: 255/255
                                                     blue: 255/255
                                                    alpha: alphaVal
                           ],
                          // 2 Red
                          [NSColor colorWithCalibratedRed: 130.0/255.0
                                                    green: 55.0/255.0
                                                     blue: 50.0/255.0
                                                    alpha:alphaVal
                           ],
                          // 3 Cyan
                          [NSColor colorWithCalibratedRed: 106.0/255.0
                                                    green: 175.0/255.0
                                                     blue: 180.0/255.0
                                                    alpha: alphaVal
                           ],
                          // 4 L Brown
                          [NSColor colorWithCalibratedRed: 138.0/255.0
                                                    green: 84.0/255.0
                                                     blue: 36.0/255.0
                                                    alpha: alphaVal
                           ],
                          // 5 Brown
                          [NSColor colorWithCalibratedRed: 87/255.0
                                                    green: 66/255.0
                                                     blue: 9/255.0
                                                    alpha: alphaVal
                           ],
                          // 6 Pink
                          [NSColor colorWithCalibratedRed: 224/255.0
                                                    green: 198/255.0
                                                     blue: 190/255.0
                                                    alpha: alphaVal
                           ],
                          // 7 Dark Grey
                          [NSColor colorWithCalibratedRed: 80/255.0
                                                    green: 80/255.0
                                                     blue: 80/255.0
                                                    alpha: alphaVal
                           ],
                          // 8 Purple
                          [NSColor colorWithCalibratedRed: 138/255.0
                                                    green: 67/255.0
                                                     blue: 149/255.0
                                                    alpha: alphaVal
                           ],
                          // 9 Green
                          [NSColor colorWithCalibratedRed: 88/255.0
                                                    green: 160/255.0
                                                     blue: 78/255.0
                                                    alpha: alphaVal
                           ],
                          // 10 Blue
                          [NSColor colorWithCalibratedRed: 64/255.0
                                                    green: 53/255.0
                                                     blue: 139/255.0
                                                    alpha: alphaVal
                           ],
                          // 11 Yellow
                          [NSColor colorWithCalibratedRed: 192/255.0
                                                    green: 205/255.0
                                                     blue: 120/255.0
                                                    alpha: alphaVal
                           ],
                          // 12 Grey
                          [NSColor colorWithCalibratedRed: 121/255.0
                                                    green: 121/255.0
                                                     blue: 121/255.0
                                                    alpha: alphaVal
                           ],
                          // 13 Light Green
                          [NSColor colorWithCalibratedRed: 151/255.0
                                                    green: 224/255.0
                                                     blue: 141/255.0
                                                    alpha: alphaVal
                           ],
                          // 14 Light Blue
                          [NSColor colorWithCalibratedRed: 121/255.0
                                                    green: 108/255.0
                                                     blue: 195/255.0
                                                    alpha: alphaVal
                           ],
                          // 15 Light Grey
                          [NSColor colorWithCalibratedRed: 160/255.0
                                                    green: 160/255.0
                                                     blue: 160/255.0
                                                    alpha: alphaVal
                           ],
                          // 16 cut out
                          [NSColor colorWithCalibratedRed: 160/255.0
                                                    green: 160/255.0
                                                     blue: 160/255.0
                                                    alpha: 0
                           ]

                          ];

    
    // Open eyed bitmap
    unsigned int myImage[SPRITE_WIDTH*SPRITE_HEIGHT] =
    {   7,7,7,7,7,7,4,4,4,4,7,7,7,7,7,7,
        7,7,7,7,4,4,4,4,4,4,4,4,7,7,7,7,
        7,7,7,0,4,4,4,0,0,4,4,4,0,7,7,7,
        7,7,0,4,6,6,4,4,4,4,6,6,4,0,7,7,
        7,0,4,4,6,6,6,6,6,6,6,6,4,4,0,7,
        7,0,4,4,1,1,6,6,6,6,1,1,4,4,0,7,
        0,6,6,6,1,0,6,6,6,6,0,1,6,6,6,0,
        0,6,6,6,1,1,6,6,6,6,1,1,6,6,6,0,
        7,0,6,6,6,6,6,6,6,6,6,6,6,6,0,7,
        7,0,6,6,0,0,6,6,6,6,0,0,6,6,0,7,
        7,0,6,6,6,6,6,6,6,6,6,6,6,6,0,7,
        7,7,4,4,6,6,6,6,6,6,6,6,4,4,7,7,
        7,7,7,0,6,6,4,4,4,4,6,6,0,7,7,7,
        7,7,7,7,4,4,4,4,4,4,4,4,7,7,7,7,
        7,7,7,7,7,7,4,4,4,4,7,7,7,7,7,7
    };

    // Close eyed bitmap
    unsigned int myImageBlink[SPRITE_WIDTH*SPRITE_HEIGHT] =
    {   7,7,7,7,7,7,4,4,4,4,7,7,7,7,7,7,
        7,7,7,7,4,4,4,4,4,4,4,4,7,7,7,7,
        7,7,7,0,4,4,4,0,0,4,4,4,0,7,7,7,
        7,7,0,4,6,6,4,4,4,4,6,6,4,0,7,7,
        7,0,4,4,6,6,6,6,6,6,6,6,4,4,0,7,
        7,0,4,4,6,6,6,6,6,6,6,6,4,4,0,7,
        0,6,6,6,6,6,6,6,6,6,6,6,6,6,6,0,
        0,6,6,6,0,0,6,6,6,6,0,0,6,6,6,0,
        7,0,6,6,6,6,6,6,6,6,6,6,6,6,0,7,
        7,0,6,6,0,0,6,6,6,6,0,0,6,6,0,7,
        7,0,6,6,6,6,6,6,6,6,6,6,6,6,0,7,
        7,7,4,4,6,6,6,6,6,6,6,6,4,4,7,7,
        7,7,7,0,6,6,4,4,4,4,6,6,0,7,7,7,
        7,7,7,7,4,4,4,4,4,4,4,4,7,7,7,7,
        7,7,7,7,7,7,4,4,4,4,7,7,7,7,7,7
    };

    // 0, 0 is at the bottom left corner
    size = [self bounds].size; // Screen bound
    
    // Draw over the last frame filling the screen
    offset_x = (size.width/H_PIXEL_RATIO)  * SSRandomIntBetween( 0, H_PIXEL_RATIO - SPRITE_WIDTH );
    offset_y = (size.height/V_PIXEL_RATIO) * SSRandomIntBetween( 0, V_PIXEL_RATIO - SPRITE_HEIGHT );
    
    rect.origin.y = 0;
    rect.origin.x = 0;
    rect.size     = NSMakeSize(size.width, size.height);
    color         = [NSColor colorWithCalibratedRed: 128/255.0
                                              green: 128/255.0
                                               blue: 128/255.0
                                              alpha: 0.5 ];
    path  = [NSBezierPath bezierPathWithRect:rect];
    [color set];
    [path fill];

    // Set pixel size/aspect ratio
    rect.size = NSMakeSize(size.width/H_PIXEL_RATIO, size.height/V_PIXEL_RATIO);

    // Randomly choose which image to draw 3 times more likely to be number greater than 0
    imagePicker = SSRandomIntBetween(0, 4);
    // Draw from the chosen image with transparency being COLOR_TRANSPARENT
    for(int y = SPRITE_HEIGHT-1; y > -1; y--){
        rect.origin.y = ((size.height/V_PIXEL_RATIO) * y) + offset_y;
        for(int x = 0; x < SPRITE_WIDTH; x++){
            rect.origin.x = ((size.width/H_PIXEL_RATIO) * x) + offset_x;
            path  = [NSBezierPath bezierPathWithRect:rect];
            if(imagePicker){
                indexColor = myImage[(y * SPRITE_WIDTH) + x] == COLOR_TRANSPARENT? 16 : myImage[(y * SPRITE_WIDTH) + x];
            }else{
                indexColor = myImageBlink[(y * SPRITE_WIDTH) + x] == COLOR_TRANSPARENT? 16 : myImageBlink[(y * SPRITE_WIDTH) + x];
            }
            color = colorMap[indexColor];
            [color set];
            [path fill];
        }
    }
    
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
