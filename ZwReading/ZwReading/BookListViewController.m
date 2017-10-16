//
//  BookListViewController.m
//  ZwReading
//
//  Created by DengZw on 2017/6/27.
//  Copyright © 2017年 ALonelyEgg.com. All rights reserved.
//

#import "BookListViewController.h"

#import "BookScanViewController.h"

@interface BookListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *listTbView;
@property (nonatomic, strong) NSMutableArray *listArray; /**< <#注释文字#> */

@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"书架";
    
    [self loadFileList];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    BookScanViewController *detail = (BookScanViewController *)[segue destinationViewController];
    detail.bookName = (NSString *)sender;
}

- (void)loadFileList
{
    
    self.listArray = [[NSMutableArray alloc] init];
    
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Books.bundle/Books"];
    
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *myDirectoryEnumerator = [myFileManager enumeratorAtPath:path];
    
    //列举目录内容，可以遍历子目录
    NSLog(@"用enumeratorAtPath:显示目录%@的内容：",path);
    while((path = [myDirectoryEnumerator nextObject]) != nil)
    {
        NSLog(@"%@",path);
    
        [self.listArray addObject:path];
    }
    
    [self.listTbView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView DD
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *path = self.listArray[indexPath.row];
    NSArray *fileName = [path componentsSeparatedByString:@"."];
    NSString *name = fileName[0];
    
    cell.textLabel.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"ShowBookScanViewController" sender:self.listArray[indexPath.row]];
}

@end
