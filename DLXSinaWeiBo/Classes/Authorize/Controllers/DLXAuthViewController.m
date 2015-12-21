//
//  DLXAuthViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXAuthViewController.h"
#import "DLXAuthConfig.h"
#import "DLXAccount.h"
#import "DLXAccountManager.h"
#import "DLXMainViewController.h"
#import "DLXHttpManager.h"
#import "MBProgressHUD.h"


@interface DLXAuthViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;

}
@end

@implementation DLXAuthViewController

-(void)loadView
{
    [super loadView];
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame ];
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_webView setDelegate:self];
    [self loadRequest];
    
}
-(void)loadRequest
{
    NSString *urlString = [WBBaseUrl stringByAppendingFormat:@"/%@?client_id=%@&redirect_uri=%@&display=mobile",WBAuth2,WBAppKey,WBRedirect_uri];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_webView loadRequest:req];
}

#pragma mark -webView的代理方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

   // NSLog(@"%@",request.URL.absoluteString);
    NSString *reqString = request.URL.absoluteString;
    NSRange range = [reqString rangeOfString:@"code="];
    if (range.location != NSNotFound)//授权成功进入授权
    {
        NSString *code = [reqString substringFromIndex:range.location+range.length];
        [self getAccessTokenWithCode:code];
        return NO;
    }
    
    return YES;
}
-(void)getAccessTokenWithCode:(NSString *)code
{
    NSDictionary *dict=@{@"client_id":WBAppKey,
                         @"client_secret":WBClient_secret,
                         @"grant_type":WBGrant_type,
                         @"code":code,
                         @"redirect_uri":WBRedirect_uri};
    [DLXHttpManager postRequestWithPath:WBAccess_token parameters:dict success:^(id JSON) {
        NSLog(@"success:%@",JSON);
        //保存帐号在文件中
        DLXAccount *account = [[DLXAccount alloc]init];
        [account setAccess_token:JSON[@"access_token"]];
        [account setUid:JSON[@"uid"]];
        DLXAccountManager *manager = [[DLXAccountManager alloc]init];
        [manager save:account];
        [self.view.window setRootViewController:[[DLXMainViewController alloc]init]];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hub setLabelText:@"我转，我转，我转转转..."];
    [hub setDimBackground:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

}
@end
