//
//  AssignmentsTableViewController.m
//  KumonApp
//
//  Created by malena mesarina on 2/21/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "AssignmentsTableViewController.h"
#import "MyCell.h"
#import <Parse/Parse.h>

@interface AssignmentsTableViewController ()
@property (strong, nonatomic) NSMutableArray *testArray;
@property (strong, nonatomic) NSMutableDictionary *assignmentsNamesToImagesDic;
@property (nonatomic, strong) NSString *studentUserName;
- (void) GetAssignments;

@end

@implementation AssignmentsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		self.testArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	//For testing ....
	
	self.studentUserName = @"mmesarina";
	
	
	
	
	//MAKE THE NAVIGATIONBAR LIGHT BLUE
	
	self.navigationController.navigationBar.hidden = NO;
	self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:84.0/255.0 green:172.0/255.0 blue:239.0/255.0 alpha:1];
	
	// Set background image
	UIImageView *boxBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asgmt_background.png"]];
	[self.tableView setBackgroundView:boxBackView];
	
		
	// Register AssignmentCell
	
	UINib *myCellNib = [UINib nibWithNibName:@"MyCell" bundle:nil];
    [self.tableView registerNib:myCellNib forCellReuseIdentifier:@"MyCell"];
	
	
	
	// Load the Assignments dictionary mapping assignment key to assignment PNG name
	self.assignmentsNamesToImagesDic = (NSMutableDictionary*) @{@"B46":@"asgmt_b46", @"B47":@"asgmt_b47", @"B48":@"asgmt_b48", @"B49":@"asgmt_b49"};
	
	// Later .... read the assignments from Parse assigned to this student.
	[self GetAssignments];
	
	
	[self.tableView reloadData];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
	
	
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	// Replace later with actual count of assignments assigned to student
   // NSInteger count = [self.testArray count];
	//return count;
	
	
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	//cell.MyLabel.text = @"YEY";
	//cell.AnotherLabel.text = @"MALENA";
	
	NSString *assignmentNumberString = @"B46";
	
	UIImage* image = [UIImage imageNamed:@"asgmt_b46.png"];
	UIImageView *asgmView = (UIImageView*)[cell viewWithTag:1];
	//asgmView.frame =CGRectMake(0,0,100,20);
	
	asgmView.image = image;

	cell.backgroundColor = [UIColor clearColor];
	
	
	
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = screenRect.size.width;
    width -= 64;
	
	//GET SIZE OF RETWEET USERNAME
	
	UIImageView *asmgtImageView = [[UIImageView alloc] init];
	asmgtImageView.frame =CGRectMake(0,0,260,110);
	
	CGFloat h = asmgtImageView.frame.size.height;
	
	
	
    return h;
	
	
}

- (void) GetAssignments {
	
	NSLog(@"In GetAssignments");
	
	PFQuery *query = [PFQuery queryWithClassName:@"Student"];
	[query whereKey:@"UserName" equalTo:@"mmesarina"];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			// The find succeeded.
			NSLog(@"Successfully retrieved %d entries.", objects.count);
			// Do something with the found objects
			for (PFObject *object in objects) {
				NSLog(@"%@", object.objectId);
			}
		} else {
			// Log details of the failure
			NSLog(@"Error: %@ %@", error, [error userInfo]);
		}
	}];}
#pragma - private methods


/*
- (void)GetAssignments {
	
	
	PFQuery *query = [PFQuery queryWithClassName:@"AssignmentsToUsers"];
	[query whereKey:@"UserName" equalTo:self.u containedIn:<#(NSArray *)#>]
	[query whereKey:@"Username" equalTo:  ];
	[query whereKey:@"Password" equalTo:self.PasswordText.text];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			//Success in finding user
			NSLog(@"User was found");
		} else {
			// Ned to think abou
			NSLog(@"Username is not in DB");
			
		}
	}];

	
}
*/

@end
