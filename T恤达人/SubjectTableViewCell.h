//
//  SubjectTableViewCell.h
//  TPityEredar
//
//  Created by Mac on 15-7-28.
//  Copyright (c) 2015年 刘 朋飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *footimage;
@property(nonatomic,strong)UIImageView *picimage;
@property(nonatomic,strong)UILabel *namelable;
@property(nonatomic,strong)UILabel *productslable;
@property(nonatomic,strong)UILabel *countLikeLable;
@property(nonatomic,strong)UIImageView *productsimage;
@property(nonatomic,strong)UIImageView *xiangqingimage;
@property(nonatomic,strong)UIButton *countLikeButton,*shareButton,*taobaoButton;
@end
