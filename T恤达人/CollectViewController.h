//
//  CollectViewController.h
//  TPityEredar
//
//  Created by mac on 15-7-29.
//  Copyright (c) 2015年 刘 朋飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionViewCell.h"
#import "SubjectModel.h"
@interface CollectViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_dataArray;
    UICollectionView * _collection;
    UISegmentedControl *_segcontrol ;
}

@end
