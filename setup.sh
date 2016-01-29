echo "start backup code..."
back_dir=hybrid-cloud-backup-`date +%Y-%m-%d-%H-%M`
mkdir ${back_dir}
cd ${back_dir}
cp -rf /usr/lib64/python2.6/site-packages/cinder ./
cp -rf /usr/lib64/python2.6/site-packages/nova ./
cp -rf /usr/lib64/python2.6/site-packages/cinderclient ./
cp -rf /usr/lib64/python2.6/site-packages/novaclient ./
cp -rf /usr/lib64/python2.6/site-packages/neutron ./
cp -rf /usr/lib64/python2.6/site-packages/glance ./
cd ..

cd hybrid-cloud
echo "backup success."
echo "Install patches..."
cp -rf ./hybrid-cloud/nova /usr/lib64/python2.6/site-packages/
cp -rf ./hybrid-cloud/novaclient /usr/lib64/python2.6/site-packages/
cp -rf ./hybrid-cloud/cinder /usr/lib64/python2.6/site-packages/
cp -rf ./hybrid-cloud/cinderclient /usr/lib64/python2.6/site-packages/
cp -rf ./hybrid-cloud/neutron /usr/lib64/python2.6/site-packages/
cp -rf ./hybrid-cloud/glance /usr/lib64/python2.6/site-packages/

echo "Install patches success."
echo "restart service..."
cps host-template-instance-operate --action stop --service nova nova-api
sleep 1s
cps host-template-instance-operate --action start --service nova nova-api

cps host-template-instance-operate --action stop --service nova nova-compute
sleep 1s
cps host-template-instance-operate --action start --service nova nova-compute

cps host-template-instance-operate --action stop --service cinder cinder-api
sleep 1s
cps host-template-instance-operate --action start --service cinder cinder-api

cps host-template-instance-operate --action stop --service cinder cinder-volume
sleep 1s
cps host-template-instance-operate --action start --service cinder cinder-volume

cps host-template-instance-operate --action stop --service neutron neutron-server
sleep 1s
cps host-template-instance-operate --action start --service neutron neutron-server

cps host-template-instance-operate --action stop --service neutron neutron-l3-agent
sleep 1s
cps host-template-instance-operate --action start --service neutron neutron-l3-agent

cps host-template-instance-operate --action stop --service glance glance
sleep 1s
cps host-template-instance-operate --action start --service glance glance