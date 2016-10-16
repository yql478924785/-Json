//
//  ViewController.m
//  jsonDemo
//
//  Created by apple on 2016/10/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "YQLNewsModel.h"
#import "YQLNewsCell.h"

@interface ViewController ()<UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray<YQLNewsModel *> *newsListArrM;

@property (nonatomic,weak)UITableView *tableView;

@end

static NSString *cellId = @"cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setupUI];
    
}

/*
 * 加载数据,解析json,会开启一条子线程执行加载
 */
- (void)loadData{

    //统一资源路径
    NSURL *url = [NSURL URLWithString:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1428742869/type/0?channel=appstore&uuid=64543C0F-89E1-4D63-B947-DB4C504D13B1&net=5&model=iPhone&ver=1.0.5"];
    
    //网络下载二进制数据(json)
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@",data);
//        NSLog(@"%@",response);
//        NSLog(@"%@",error);
        
        //反序列化,将二进制数据转化为数组(存储字典)
        NSArray<NSDictionary *> *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //存储model可变数组
        NSMutableArray<YQLNewsModel *> *arrM = [NSMutableArray array];
        
        //遍历数组字典转模型
        
        for (NSDictionary *dict in arr) {
            YQLNewsModel *model = [[YQLNewsModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [arrM addObject:model];
        }
        
        //属性赋值,存在字典转换的模型数组
        self.newsListArrM = arrM;
        
        //在主队列中刷新UI界面
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    }]resume];
    
    
}

/*
 * 界面设置
 */
- (void)setupUI{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.rowHeight = 140;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:@"YQLNewsCell" bundle:nil] forCellReuseIdentifier:cellId];
    
}

#pragma mark
#pragma mark - 数据源代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsListArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YQLNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    YQLNewsModel *model = self.newsListArrM[indexPath.row];
    
    if ([model.img isEqualToString:@""]) {
        NSLog(@"%zd",indexPath.row);
    }
    
    cell.model = model;
    
    return cell;
}
@end















