# demo-alicloud-project

Try out Exekube with Alibaba Cloud Container Service for Kubernetes

Uses Terraform modules from https://github.com/exekube/exekube/tree/alicloud (alicloud branch)

> :warning:
>
> This is a work in progress
>
> 😔 Alibaba Cloud ain't Google, cluster creation is really slow (20+ minutes)
>
> :warning:

## Tutorial

1. Register an account with Alibaba Cloud.
2. Enable the following APIs on Alibaba Cloud:
    - Container Service: https://cs.console.aliyun.com/
    - ROS: https://ros.console.aliyun.com/
    - RAM: https://ram.console.aliyun.com/
    - VPC: https://vpc.console.aliyun.com/
3. Get an *Access Key ID* and *Access Key Secret*: <https://www.alibabacloud.com/help/doc-detail/28955.htm>
    - Save Access Key ID to `live/dev/secrets/kube-system/alicloud/access-key`
    - Save Access Key Secret to `live/dev/secrets/kube-system/alicloud/secret-key`
4. (Optional) Run `xk aliyun configure` and enter details to use Alibaba Cloud CLI

... to be continued ...

## Known issues and limitations

- Can't store Terraform state in Alibaba Cloud
    - OSS (Alibaba Cloud object storage service, equivalent to GCS / AWS S3) has not been added as a backend to store Terraform state
    - There is a PR open to add OSS as backend: <https://github.com/hashicorp/terraform/pull/16927>
    - **SOLUTION**: A workaround is to store our Terraform state in a GCS bucket
    - We configure the GCS bucket using `TFSTATE_BUCKET` and `TFSTATE_BUCKET_KEY` env variables in `docker-compose.yaml`

- `StackValidationFailed Message: The service 'vpc' is not enabled. Please enable service firstly.`
    - You must use the Alibaba Cloud Concolse (web UI) to enable the following APIs:
        - Container Service: https://cs.console.aliyun.com/
        - ROS: https://ros.console.aliyun.com/
        - RAM: https://ram.console.aliyun.com/
        - VPC: https://vpc.console.aliyun.com/

- If you run into problems with enable VPC service, try switching to the "old console": https://www.alibabacloud.com/help/doc-detail/66173.htm
- `RiskControl, This operation is forbidden by Aliyun Risk Control system.` Possible a limitation of Free Trial, or missing security groups for VPC (?)
- Cluster creation stuck at `ALIYUN::ROS::WaitCondition` (?) Not stuck, just takes a long time
