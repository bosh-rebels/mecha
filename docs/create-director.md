# Create Director

## Manual process

> Needs work to make it proper

```bash
# Define mecha project home
$ export MECHA_HOME=...

$ git clone https://github.com/cloudfoundry/bosh-deployment $MECHA_HOME/bosh-deployment

$ mkdir -p $MECHA_HOME/deployments/bosh-1

$ cd $MECHA_HOME/deployments/bosh-1

# Fill below variables (replace example values) and deploy the Director
bosh create-env $MECHA_HOME/bosh-deployment/bosh.yml \
  --state=state.json \
  --vars-store=creds.yml \
  -o $MECHA_HOME/bosh-deployment/aws/cpi.yml \
  -v director_name=bosh-1 \
  -v internal_cidr=10.0.0.0/24 \
  -v internal_gw=10.0.0.1 \
  -v internal_ip=10.0.0.6 \
  -v access_key_id=AKI... \
  -v secret_access_key=wfh28... \
  -v region=us-east-1 \
  -v az=us-east-1a \
  -v default_key_name=bosh \
  -v default_security_groups=[bosh] \
  --var-file private_key=~/Downloads/bosh.pem \
  -v subnet_id=subnet-ait8g34t

$ cd -
```