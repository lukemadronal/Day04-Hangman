//
//  ViewController.m
//  Hangman
//
//  Created by Luke Madronal on 9/24/15.
//  Copyright © 2015 Luke Madronal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)NSArray *wordList;

@end

@implementation ViewController

NSString *temp=@"";

- (NSString *)readBundleFileToString:(NSString *)filename ofType: (NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:type];
   // NSLog(@"got here");
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

- (NSArray *)convertCSVStringToArray:(NSString *)csvString {
    NSString *cleanString = [[csvString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
    //NSLog(@"got into second");
    return [cleanString componentsSeparatedByCharactersInSet:set];
}

- (IBAction)startNewGamePressed:(id)sender {
    NSLog(@"%@",[self randomWord:(_wordList)]);

}

- (NSString *) randomWord:(NSArray *)wordList {
    return _wordList [arc4random_uniform((uint32_t)[_wordList count]-1)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view did load");
    _wordList=[self convertCSVStringToArray: [self readBundleFileToString:@"WordSetApple" ofType: @"csv"]];
    
    
    //[self readBundleFileToString:temp WordSetApple ofType :temp];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
