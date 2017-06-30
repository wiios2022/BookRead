//
//  BookScanViewController.m
//  ZwReading
//
//  Created by DengZw on 2017/6/27.
//  Copyright © 2017年 ALonelyEgg.com. All rights reserved.
//

#import "BookScanViewController.h"
#import "MemoryManager.h"

@interface BookScanViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *bookTxtView;

@end

@implementation BookScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *fileName = [self.bookName componentsSeparatedByString:@"."];
    NSString *name = fileName[0];
    self.navigationItem.title = name;
    
    UIImage *leftImg = [[UIImage imageNamed:@"ic_commodity_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImg
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self.navigationController
                                                                           action:@selector(popViewControllerAnimated:)];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.bookTxtView.layoutManager.allowsNonContiguousLayout = NO;
    
    [self loadFileList];
}

- (void)loadFileList
{
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Books.bundle/Books/%@", self.bookName]];
    NSLog(@"path : %@", path);
    
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    if([myFileManager fileExistsAtPath:path])
    {
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        if (content)
        {
            self.bookTxtView.text = content;
    
            
            double oldHeight = [[MemoryManager sharedInstance] loadHeightByBook:self.bookName];
            
            if (oldHeight)
            {
                NSLog(@"old height : %f", oldHeight);
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.bookTxtView setContentOffset:CGPointMake(0, oldHeight) animated:NO];
                }];
            }
            else
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.bookTxtView setContentOffset:CGPointMake(0, -64) animated:NO];
                }];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"save height : %f", scrollView.contentOffset.y);
    [[MemoryManager sharedInstance] saveHeight:scrollView.contentOffset.y book:self.bookName];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"1111save height : %f", scrollView.contentOffset.y);
    [[MemoryManager sharedInstance] saveHeight:scrollView.contentOffset.y book:self.bookName];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"22222save height : %f", scrollView.contentOffset.y);
    [[MemoryManager sharedInstance] saveHeight:scrollView.contentOffset.y book:self.bookName];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
