//
//  PNResultTableViewController.m
//  PalindromicNumberDemo
//
//  Created by 戴 立慧 on 13-3-16.
//
//

#import "PNResultTableViewController.h"

@interface PNResultTableViewController ()
@property (nonatomic, strong) NSMutableArray *palindromicNumbersArray; // 回文数查找结果数组
@end

@implementation PNResultTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.palindromicNumbersArray = [NSMutableArray array]; // 初始化
    
    
    __block PNResultTableViewController * blockself = self;
    
    //在子线程中查找
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger i = 0;
        while (YES) {
            NSInteger palindromicNumber = [blockself findPalindromNumberAtIndex:i]; //查找第i个回文数
            if (palindromicNumber <= blockself.inputNum) { //判断是否超出范围
                [blockself.palindromicNumbersArray addObject:[NSNumber numberWithInteger:palindromicNumber]];
                i ++;
            }
            else
                break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"the last palindromic number is %d",[[self.palindromicNumbersArray lastObject] integerValue]);
            [blockself.tableView reloadData]; //更新tableview
        });
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.palindromicNumbersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PalindromicNumberCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.palindromicNumbersArray[indexPath.row] stringValue];
    
    return cell;
}

#pragma mark - custom methods

//找到第n个回文数（从小到大），根据规律，位数没增加2，回文数数量为10倍
- (NSInteger)findPalindromNumberAtIndex:(NSInteger)index
{
    
    NSInteger count = 0;
    NSInteger number = 9;                        //记录数位上的回文数，从个位开始
    NSInteger w = 0;                            //记录数位
    
    NSInteger half;                            //保存回文数的左半边的结果
    NSInteger h = 1;                            //回文数的左半边的起始基数
    NSInteger res;                            //结果
    
    while(true) {
        if(w > 0 && w%2 == 0) {            //每进两个数位，回文数乘以10
            number *= 10;
        }
        w++;                            //数位加一
        if(count + number > index)        //回文数大于查找的回数,跳出
            break;
        
        count += number;                //回文数加上当前数位上的回文数
    }
    
    index -= count;                        //在当前数位上的位置。
    
    for(int i = 0; i < (w-1) / 2; i++) {    //求回文数的左半边的基数
        h *= 10;
    }
    
    half = h + index;                        //回文数的左半边，如100 + 50 = 150
    
    res = half;
    
    if(w%2 != 0)                            //如果为奇数，则中间那个数不必算入右半边了！
        half /=10;
    
    while(half != 0) {                        //拼接回文数
        res = res *10 + half % 10;
        half /= 10;
    }
    
    return res;
    
    
}


@end
