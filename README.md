Set up a Kubernetes Cluster on Coreos through Ansible
========================================================================

This is based on `https://github.com/thesamet/ansible-kubernetes-coreos` with few mods/fixes for our env


requirements
------------
coreos-cluster: need a full CoreOS cluster setup with access to SSH via keys

check `https://s3.amazonaws.com/jpcf-template/coreos-base.json` as cloudformation template example

coreos-bootstrap:

```
$ ansible-galaxy install defunctzombie.coreos-bootstrap`
```

Running
-------
1. Customize `inventory`

2. Customize `vars.yaml`

3. Generate TSL: (first need to customize kube-tls/conf/openssl.cnf)
   ```
   $ cd kube-tls/scripts/
   $ ./generate-all.sh
   $ cd ../../
   ```

4. Run:
```
$ ansible-playbook -i ./inventory  -e @./vars.yaml provision.yaml
```

5. Then ssh to your master, and you should be able to start exploring:
```
$ /opt/local/bin/kubectl get nodes
```

Example
-------
Taken from `https://github.com/kubernetes/kubernetes/tree/release-1.1/examples/guestbook`

Run:
```
$ bash kubernetes/example/go.sh
```

