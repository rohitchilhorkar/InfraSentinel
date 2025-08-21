Case 1: You’re fine with Kubernetes creating LBs on-demand

You don’t need to include an ALB or NLB in Terraform.

When you deploy a Kubernetes Service of type LoadBalancer, AWS will provision one automatically.

If you install the AWS Load Balancer Controller (can be done via kubectl or Helm), then whenever you define an Ingress, it will spin up an ALB automatically in your public subnets.

In this flow, Terraform stops at infra, and Kubernetes (via controllers) handles the LB creation.

Case 2: You want to manage LBs as infra in Terraform

You can explicitly provision ALBs (or NLBs) in Terraform using the aws_lb resource.

But then you’d need to wire your Kubernetes workloads to that LB manually (via Target Groups, ingress annotations, etc.).

This makes sense if you want tight Terraform control over every LB, but most EKS setups don’t do this.
