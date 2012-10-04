DFSSHServer *server = [[sshServer alloc] init];


[server setSSHHost:@"192.168.2.100" port:22 user:@"dan" key:@"" keypub:@"" password:@"XXXXX"];


DFSSHConnector *connection = [[sshConnector alloc] init];


[connection connect:server];


if ([server connectionStatus]) {

         NSLog(@”Server 1 connected”);

}


NSLog(@”%@”,[DFSSHOperator execCommand:@"uname -a" sshServer:server]);
[connection closeSSH:server];
