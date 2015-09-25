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
@property (nonatomic, strong)NSString *guessWord;
@property (nonatomic, strong)NSMutableArray *excludedButtons;
@property (nonatomic,weak) IBOutlet UIView *firstView;
@property (nonatomic, strong)NSMutableArray *letterList;
@property (nonatomic, weak) IBOutlet UIImageView *nooseview;
@property (nonatomic, strong) IBOutlet UIButton *newgamedisplay;


@end

@implementation ViewController



int lifeCount=0;

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
    lifeCount=0;
    _newgamedisplay.titleLabel.text = @"GUESS LETTERS!";
    _guessWord=[self randomWord:(_wordList)];
     _letterList= [[NSMutableArray alloc] init];
        for (int i=0;i<_guessWord.length;i++) {
//        NSString *letter = [_guessWord characterAtIndex:i];
        NSString *letter = [_guessWord substringWithRange:NSMakeRange(i, 1)];
        [_letterList addObject:letter];
    }
    [_excludedButtons removeAllObjects];
    //clear death counter
    
    for (id object in [_firstView subviews]) {
        [object removeFromSuperview];
    }

    for (int i=0;i<_guessWord.length;i++) {
        UIView *hashMark = [[UIView alloc] initWithFrame:CGRectMake(10.0+(20*i), 23.0, 10, 2)];
        [hashMark setBackgroundColor:[UIColor grayColor]];
        [_firstView addSubview:hashMark];
        UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0+(20*i), 0.0, 10, 21)];
        letterLabel.textColor = [UIColor whiteColor];
        letterLabel.font = [UIFont fontWithName:@"Futura" size:16.0];
        letterLabel.tag = i;
        letterLabel.text = _letterList[i];
        [_firstView addSubview:letterLabel];

        
    }

}

- (IBAction)keyboardPressed:(UIButton *)button {
    NSString *buttonLetter = [button currentTitle];
    NSLog(@"%@ Letter Pressed", buttonLetter );
    NSString *buttontemp =[NSString stringWithFormat:@"%@", buttonLetter];
    if (![_excludedButtons containsObject:(@"a")]) {
        NSLog(@"%@", buttontemp);
        [self checkLetter:buttonLetter];
    }
    
}

        

-(void)checkLetter:(NSString *) letter {
    [_excludedButtons addObject:letter];
    NSLog(@"the letter is: %@ and the word is: %@",letter,_guessWord);
    if ([[_guessWord uppercaseString] containsString:letter]) {
        NSLog(@"i found an A");
        //display letter
        for (int i=0; i < _letterList.count; i++) {
            if( [[_letterList[i] uppercaseString] isEqualToString:letter] ) {
                NSLog(@"the letter is: %@ and the word is: %@",letter,_guessWord);
                for (id object in [_firstView subviews]) {
                    if ([object isKindOfClass: [UILabel class]]) {
                        UILabel *currentLabel = (UILabel *)object;
                        if (currentLabel.tag == i) {
                            currentLabel.textColor = [UIColor blackColor];
                        }
                    }
                }
            }
        }
        
    } else {
        lifeCount++;
        NSString *temp=[NSString stringWithFormat:@"Hangman%i.png", lifeCount];
        [_nooseview setImage:[UIImage imageNamed:temp]];
        if (lifeCount == 10) {
        _newgamedisplay.titleLabel.text = @"YOU DIED. PRESS TO PLAY AGAIN";
        }
    }
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
