//
//  NewsFeedViewController.m
//  InstaMakers
//
//  Created by John Blanchard on 8/19/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "NewsFeedTableViewCell.h"
#import "Parse/Parse.h"
#import "Person.h"

#define ColorBostonBlue [UIColor colorWithRed:0.29 green:0.63 blue:0.69 alpha:1]
#define ColorMalibu [UIColor colorWithRed:0.36 green:0.78 blue:0.84 alpha:1]
#define ColorTealBlue [UIColor colorWithRed:0.24 green:0.47 blue:0.55 alpha:1]

@interface NewsFeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *likeHeartImageView;

@property NSArray* persons;
@end

@implementation NewsFeedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshDisplay];
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self refreshDisplay];
    [self.tableView reloadData];
}

- (void) refreshDisplay
{
    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", [error userInfo]);
        } else {
            self.persons = objects;
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.persons.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsFeedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    PFUser* aPerson = [self.persons objectAtIndex:indexPath.row];
    NSLog(@"%@", aPerson);
    cell.photoImageView.image = [UIImage imageWithData:aPerson[@"profilepicture"]];
    cell.heartImageView.image = [UIImage imageWithContentsOfFile:@"heart"];
    cell.likerCountLabel.text = @"Number of Likes";
    cell.likerCountLabel.textColor = ColorTealBlue;
    cell.backgroundColor = ColorMalibu;
    
    NSString* name = [NSString stringWithFormat:@"%@ %@", aPerson[@"firstname"], aPerson[@"lastname"]];
    cell.nameLabel.text = name;
    cell.nameLabel.textColor = ColorTealBlue;
    cell.profilePictureImageView.image = [UIImage imageWithData:aPerson[@"profilepicture"]];
    return cell;
}

@end
