//
//  DFAppDelegate.m
//  DFSSHWrapper
//
//  Created by dan on 13/09/2012.
//  Copyright (c) 2012 dan. All rights reserved.
//

#import "DFAppDelegate.h"
#import "DFSSHServer.h"
#import "DFSSHConnector.h"
#import "DFSSHOperator.h"
#import "DFSSHConnectionType.h"

@implementation DFAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    DFSSHServer *server = [[DFSSHServer alloc]init];
    [server setSSHHost:@"<HOSTNAME>" port:22 user:@"dan" key:@"" keypub:@"" password:@"<PASSWORD>"];
    
    DFSSHConnector *connection = [[DFSSHConnector alloc] init];
    DFSSHConnectionType *connectionType = [[DFSSHConnectionType alloc] init];
    connectionType.password=false;
    connectionType.keyboard_interactive=false;
    connectionType.autoDetect=true;
    
    [connection connect:server connectionType:connectionType];
    
    if ([server connectionStatus]) {
        NSLog(@"Server Connected");
        
       // NSLog(@”Server 1 connected”);
        
    }
    NSLog(@"%@",[DFSSHOperator execCommand:@"uname -a" server:server]);
    
    //NSLog(@”%@”,[sshOperator execCommand:@"uname -a" DFSSServer:server]);
    
    [connection closeSSH:server];
    
    
}

@end
