# aws-dingo
The AWS code for DINGO

### Checklist

CloudFormation template

- [ ] Define VPC, including subnets, IGW, Sec, Route Table etc... (may separate this later)
- [ ] Create AMI
- [ ] Create EC2 Instance + ephemeral storage
- [ ] Define ASG + Launch config / launch template(?)

more to come...

### References and Resources

- [CloudFormation Resource and Property Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)
- [Cfn-init](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-init.html)
- [Serverless Application Model (SAM)](https://github.com/awslabs/serverless-application-model)
- [SAM CLI](https://github.com/awslabs/aws-sam-cli)
- [AWS Step Functions Plagiarism Demo Dotnetcore](https://github.com/aws-samples/aws-step-functions-plagiarism-demo-dotnetcore) (Shows how to integrate Step Functions with SAM)