//
//  GifTableViewCell.m
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/14/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import "GifTableViewCell.h"

@implementation GifTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    float indentPoints = self.indentationLevel * self.indentationWidth;
    float scale = (320 / self.imageView.frame.size.width);
    float width = self.imageView.frame.size.width * scale;
    if(isnan(width))width=0;
    float height = self.imageView.frame.size.height * scale;
        if(isnan(height))height=0;
    //[cell.imageView setContentScaleFactor:2];
    NSLog(@"image size: %f, %f",width,height);
    CGRect irect = CGRectMake(
                                        indentPoints,
                                        0,
                                        width - indentPoints,
                                        height
                                        );
    self.imageView.frame = irect;
    /*CGRect crect = CGRectMake(self.frame.origin.x,
                              self.frame.origin.y,
                              320,
                              height
                              );
    self.frame = crect;*/
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
