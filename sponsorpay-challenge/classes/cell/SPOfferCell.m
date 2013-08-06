//
//  SPOfferCell.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOfferCell.h"
#import "SPOffer.h"
#import "UIImageView+WebCache.h"

@interface SPOfferCell()
@property (nonatomic, weak) SPOffer *offer;
@property (nonatomic, weak) UIImageView *offerThumbnail;
@end

@implementation SPOfferCell

+ (CGFloat) heightForOffer: (SPOffer *) offer {
    CGFloat offerSize = [self heightForTitle:offer];
    offerSize += [self heightForTeaser:offer];
    offerSize += 15;
    return MAX(offerSize, 60);
}
+ (CGFloat) heightForTitle: (SPOffer *) offer {
    return [offer.title sizeWithFont:[UIFont boldSystemFontOfSize:14]
                   constrainedToSize:CGSizeMake(255, 200)
                       lineBreakMode:NSLineBreakByTruncatingTail].height;
}
+ (CGFloat) heightForTeaser: (SPOffer *) offer {
    return [offer.teaserWithPayout sizeWithFont:[UIFont systemFontOfSize:14]
                              constrainedToSize:CGSizeMake(255, 200)
                                  lineBreakMode:NSLineBreakByTruncatingTail].height;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UIImageView *offerThumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        self.offerThumbnail = offerThumbnail;
        [self.contentView addSubview:offerThumbnail];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void) setOffer: (SPOffer *) offer {
    _offer = offer;
    [self.offerThumbnail setImageWithURL:offer.thumbnail.hires];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    CGFloat heightForTitle = [[self class] heightForTitle:self.offer];
    CGFloat heightForTeaser = [[self class] heightForTeaser:self.offer];
    [self.offer.title drawInRect:CGRectMake(60, 5, 255, heightForTitle)
                        withFont:[UIFont boldSystemFontOfSize:14]];
    [self.offer.teaserWithPayout drawInRect:CGRectMake(60, heightForTitle + 10, 255, heightForTeaser)
                                   withFont:[UIFont systemFontOfSize:14]];
}
@end
