# CLI commnands can be used for querying for any metadata or attribute for this purpose.
-------
## Below Command will return all the attributes for the instance specified.

```
aws ec2 describe-instances --region "region-name"  --instance-id "instance-id" --output json
```
e.g.

**Command**

aws ec2 describe-instances --region us-east-1  --instance-id "i-0d30e9085b0a4b3a3" --output json

**Output**

```
{
    "Reservations": [
        {
            "Groups": [],
            "Instances": [
                {
                    "AmiLaunchIndex": 0,
                    "ImageId": "ami-0d5eff06f840b45e9",
                    "InstanceId": "i-0d30e9085b0a4b3a3",
                    "InstanceType": "t2.small",
                    "KeyName": "kpmg-challenge-test-ec2-key",
                    "LaunchTime": "2021-06-03T06:42:17.000Z",
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "Placement": {
                        "AvailabilityZone": "us-east-1e",
                        "GroupName": "",
                        "Tenancy": "default"
                    },
                    "PrivateDnsName": "ip-172-31-61-104.ec2.internal",
                    "PrivateIpAddress": "172.31.61.104",
                    "ProductCodes": [],
                    "PublicDnsName": "-",
                    "PublicIpAddress": "-",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "StateTransitionReason": "",
                    "SubnetId": "subnet-0cbfebf1601adfe4c",
                    "VpcId": "vpc-09945915a88781c3f",
                    "Architecture": "x86_64",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/xvda",
                            "Ebs": {
                                "AttachTime": "2021-06-03T06:42:18.000Z",
                                "DeleteOnTermination": true,
                                "Status": "attached",
                                "VolumeId": "vol-0700ead4cdac747a7"
                            }
                        }
                    ],
                    "ClientToken": "",
                    "EbsOptimized": false,
                    "EnaSupport": true,
                    "Hypervisor": "xen",
                    "NetworkInterfaces": [
                        {
                            "Association": {
                                "IpOwnerId": "amazon",
                                "PublicDnsName": "-",
                                "PublicIp": "-
                            },
                            "Attachment": {
                                "AttachTime": "2021-06-03T06:42:17.000Z",
                                "AttachmentId": "eni-attach-056d78d28d6c4eee9",
                                "DeleteOnTermination": true,
                                "DeviceIndex": 0,
                                "Status": "attached"
                            },
                            "Description": "",
                            "Groups": [
                                {
                                    "GroupName": "launch-wizard-3",
                                    "GroupId": "sg-0b91eb3c903f3dc88"
                                }
                            ],
                            "Ipv6Addresses": [],
                            "MacAddress": "06:65:67:6b:ca:fb",
                            "NetworkInterfaceId": "eni-0a78c59e15e746dd8",
                            "OwnerId": "369589790341",
                            "PrivateDnsName": "ip-172-31-61-104.ec2.internal",
                            "PrivateIpAddress": "172.31.61.104",
                            "PrivateIpAddresses": [
                                {
                                    "Association": {
                                        "IpOwnerId": "amazon",
                                        "PublicDnsName": "-",
                                        "PublicIp": "-"
                                    },
                                    "Primary": true,
                                    "PrivateDnsName": "ip-172-31-61-104.ec2.internal",
                                    "PrivateIpAddress": "172.31.61.104"
                                }
                            ],
                            "SourceDestCheck": true,
                            "Status": "in-use",
                            "SubnetId": "subnet-0cbfebf1601adfe4c",
                            "VpcId": "vpc-09945915a88781c3f",
                            "InterfaceType": "interface"
                        }
                    ],
                    "RootDeviceName": "/dev/xvda",
                    "RootDeviceType": "ebs",
                    "SecurityGroups": [
                        {
                            "GroupName": "launch-wizard-3",
                            "GroupId": "sg-test"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Tags": [
                        {
                            "Key": "Name",
                            "Value": "kpmg-challenge-test-vm"
                        }
                    ],
                    "VirtualizationType": "hvm",
                    "CpuOptions": {
                        "CoreCount": 1,
                        "ThreadsPerCore": 1
                    },
                    "CapacityReservationSpecification": {
                        "CapacityReservationPreference": "open"
                    },
                    "HibernationOptions": {
                        "Configured": false
                    },
                    "MetadataOptions": {
                        "State": "applied",
                        "HttpTokens": "optional",
                        "HttpPutResponseHopLimit": 1,
                        "HttpEndpoint": "enabled"
                    }
                }
            ],
            "OwnerId": "-",
            "ReservationId": "-"
        }
    ]
}
```
----
## Below command will get the private IP of the instance specifed in JSON format
```
aws ec2 describe-instances --region "<region-name>"  --instance-id "<instance-id>" --query 'Reservations[].Instances[].PrivateIpAddress' --output json
```

e.g.

**Command**


_aws ec2 describe-instances --region "us-east-1"  --instance-id "i-0d30e9085b0a4b3a3" --query 'Reservations[].Instances[].PrivateIpAddress' --output json_

**Output**
```
[
    "172.31.61.104"
]
```
