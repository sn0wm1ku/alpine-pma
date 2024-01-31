# alpine-pma
<img width="3104" alt="Untitled" src="https://github.com/sn0wm1ku/alpine-pma/assets/132436492/678b2611-df33-48a4-897d-cbaf99d61dc5">
phpMyAdmin with AWS tools inside.
Design for connecting isolated RDS DB.

**Pre-requesties**
- `RDS` with `Bastion` (EC2) in isolated Subnet
- `SSM` permission for Bastion
- `.aws/config` and `.aws/credential` [setup](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)


## Setup

### Docker Commands
_*Pulling image*_
```
docker image pull sn0wm1ku/alpine-pma:latest
```
_*Running container*_
```
docker run --name alpine-pma --env-file .env -v ~/.aws:/root/.aws -p80:80 -d sn0wm1ku/alpine-pma
```

### Environment Variable
- `AWS_PROFILE`
    The Name of Profile to be use with Tunneling
- `RDS_TYPE`
    Instance or Cluster
    Weather the RDS is an Instance Type (RDS) or Cluster Type (RDS Aurora)
- `PMA_HOST`/`PMA_HOSTS`
    Endpoint for RDS, since tunneling, suggest setting to 127.0.0.1 
- `PMA_VERBOSE`/`PMA_VERBOSES`
    Alias for the RDS.
- `PMA_PORT`/`PMA_PORTS`
    Port for RDS.
### Mount Volume
- `~/.aws`
    Please Mount this to the `/root` folder of container.
