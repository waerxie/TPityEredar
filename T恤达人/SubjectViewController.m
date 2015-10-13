//
//  SubjectViewController.m
//  TPityEredar
//
//  Created by mac on 15-7-29.
//  Copyright (c) 2015年 刘 朋飞. All rights reserved.
//

#import "SubjectViewController.h"

@interface SubjectViewController ()

@end

@implementation SubjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title = @"主题";
    _dataArray = [[NSMutableArray alloc]init];
    //获得推荐数据
    [NetWorkRequest getRecommendCompletion:^(NSDictionary *dic)
    {
        SubjectModel *object = [[SubjectModel alloc]initWithDictionary:dic];
        [_dataArray addObject:object];
    //获得列表数据  （写到推荐数据回调方法里边保证数组先获得推荐数据）
    [NetWorkRequest getSubjectDataCompletion:^(NSDictionary *dic)
         {
            for (int i=0; i<[dic[@"result"] count]; i++)
             {
                 if (_dataArray.count>0)
                 {
                     NSDictionary *dataDic = dic[@"result"][i];
                     SubjectModel *object = [[SubjectModel alloc]initWithDictionary:dataDic];
                     [_dataArray addObject:object];
                     [_tableView reloadData];
                 }
                 
             }
         }];
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //上拉和下拉刷新
    
    __weak SubjectViewController *weakSelf = self;
    
    // setup pull-to-refresh
    //[_tableView addPullToRefreshWithActionHandler:^{
        //[weakSelf insertRowAtTop];
    //}];
    
    // setup infinite scrolling
    [_tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];

    
    
 
    
}
//- (void)insertRowAtTop {
//    
//    
//    NSLog(@"xia la");
//
//    [_tableView.pullToRefreshView stopAnimating];
//   
//}


- (void)insertRowAtBottom {
    NSLog(@"shangla");
    
    static int count;
    count ++;
    if (count==1)
    {
        NSLog(@"加载一组数据");
        [NetWorkRequest getSubjectDataOneCompletion:^(NSDictionary *dic)
         {
             for (int i=0; i<[dic[@"result"] count]; i++)
             {
                 if (_dataArray.count>0)
                 {
                     NSDictionary *dataDic = dic[@"result"][i];
                     SubjectModel *object = [[SubjectModel alloc]initWithDictionary:dataDic];
                     [_dataArray addObject:object];
                     [_tableView reloadData];
                 }
                 
             }
         }];

    }
    if (count==2)
    {
        NSLog(@"在加载一组数据");
        [NetWorkRequest getSubjectDataTwoCompletion:^(NSDictionary *dic)
         {
             for (int i=0; i<[dic[@"result"] count]; i++)
             {
                 if (_dataArray.count>0)
                 {
                     NSDictionary *dataDic = dic[@"result"][i];
                     SubjectModel *object = [[SubjectModel alloc]initWithDictionary:dataDic];
                     [_dataArray addObject:object];
                     [_tableView reloadData];
                 }
                 
             }
         }];

    }
        
    [_tableView.infiniteScrollingView stopAnimating];
    
}





#pragma mark----
#pragma mark 表的布局
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[SubjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = 0;
    }
    
    SubjectModel *object = _dataArray[indexPath.row];
    
    if (indexPath.row==0)
    {
        [cell.picimage  setImageWithURL:[NSURL URLWithString:object.pic] placeholderImage:nil];
        cell.picimage. frame = CGRectMake(10, 5, self.view.frame.size.width-20, 80);
        cell.productslable.hidden = YES;
        cell.footimage.hidden = YES;
        cell.productsimage.hidden = YES;
        cell.namelable.hidden = YES;
        
    }else
    {
        
        cell.productslable.hidden = NO;
        cell.footimage.hidden = NO;
        cell.productsimage.hidden = NO;
        cell.picimage.hidden = NO;
        cell.namelable.hidden = NO;
        cell.namelable.text = object.name;
        [cell.picimage  setImageWithURL:[NSURL URLWithString:object.pic] placeholderImage:nil];
        cell.picimage. frame = CGRectMake(20, 5, self.view.frame.size.width-40, 200);
        cell.productslable.text = object.subDesc;
        cell.productslable.font = [UIFont systemFontOfSize:15];
        cell.productslable.frame =CGRectMake(20, 205, self.view.frame.size.width-40, 70);
    
        [cell.footimage setImage:[UIImage imageNamed:@"cell_bottom_bg"]];
        [cell.productsimage setImage:[UIImage imageNamed:@"cell_bg"]];
        cell.productsimage.frame = CGRectMake(0, 205, self.view.frame.size.width, 70);
        
    }
     
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row==0?100:300;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.object = _dataArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;//隐藏分栏控制器
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
