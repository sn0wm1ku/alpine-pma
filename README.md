# alpine-pma

## Setup
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