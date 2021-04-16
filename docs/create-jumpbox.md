# Create Jumpbox

## Manual process

> Needs work to make it proper

```bash
# Define mecha project home
$ export MECHA_HOME=...

$ git clone https://github.com/cloudfoundry/jumpbox-deployment $MECHA_HOME/jumpbox-deployment

$ mkdir -p $MECHA_HOME/deployments/jumpbox-1

$ cd $MECHA_HOME/deployments/jumpbox-1

# Deploy a jumpbox -- ./creds.yml is generated automatically
$ bosh create-env $MECHA_HOME/jumpbox-deployment/jumpbox.yml \
  --state ./state.json \
  -o $MECHA_HOME/jumpbox-deployment/aws/cpi.yml \
  --vars-store ./creds.yml \
  -v access_key_id=... \
  -v secret_access_key=... \
  -v region=us-east-1 \
  -v az=us-east-1b \
  -v default_key_name=jumpbox \
  -v default_security_groups=[jumpbox] \
  -v subnet_id=subnet-... \
  -v internal_cidr=10.0.0.0/24 \
  -v internal_gw=10.0.0.1 \
  -v internal_ip=10.0.0.5 \
  -v external_ip=... \
  --var-file private_key=...

# Currently, none of the generated credentials are necessary to persist
# (possibly except for generated SSH private key)
$ rm ./creds.yml

$ cd -
```