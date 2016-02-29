Set up a Kubernetes Cluster on Coreos through Ansible
========================================================================

This is based on `https://github.com/thesamet/ansible-kubernetes-coreos` with few mods/fixes for our env


requirements
------------
aws setup: 

   - VPC with a tag key `KubernetesCluster` and any value key (just need to make sure you use the same for all the cluster)
   - Subnets with public face for the ELB -- need the same tag `KubernetesCluster` and key value
   - IAM policy:
      -- policy example:
      ```
      {
       "Version": "2012-10-17",
       "Statement": [
           {
               "Effect": "Allow",
               "Action": [
                   "ec2:*"
               ],
               "Resource": [
                   "*"
               ]
           },
           {
               "Effect": "Allow",
               "Action": [
                   "elasticloadbalancing:*"
               ],
               "Resource": [
                   "*"
               ]
           },
           {
               "Effect": "Allow",
               "Action": "s3:*",
               "Resource": [
                   "arn:aws:s3:::kubernetes-*"
               ]
           }
       ]
   }
   ```

   - IAM role:
         -- name: kubernetes-master-role (This name would be use in the cloudformation template -- IamInstanceProfile)
    
coreos-cluster: need a full CoreOS cluster setup with access to SSH via keys

   - check `https://s3.amazonaws.com/jpcf-template/coreos-base.json` as cloudformation template example
   - when creating, use tag key `KubernetesCluster` and same key value

coreos-bootstrap:

   ```
   $ ansible-galaxy install defunctzombie.coreos-bootstrap`
   ```

Running
-------
1. Customize `inventory`

2. Customize `vars.yaml`

3. Generate TSL: (first need to customize `kube-tls/conf/openssl.cnf`)
   ```
   $ cd kube-tls/scripts/
   $ ./generate-all.sh
   $ cd ../../
   ```

4. Run:
```
$ ansible-playbook -i ./inventory  -e @./vars.yaml provision.yaml
```

Then ssh to your master, and you should be able to start exploring:
```
$ /opt/local/bin/kubectl get nodes
```

Example
-------
Taken from `https://github.com/kubernetes/kubernetes/tree/release-1.1/examples/guestbook`

   - Run:
   ```
   $ bash kubernetes/example/go.sh
   ```

   - Make sure all the pods are running
   ```
   $ /opt/local/bin/kubectl get pods
   NAME                 READY     STATUS    RESTARTS   AGE
   frontend-d3h2h       1/1       Running   0          3m
   frontend-r0w0m       1/1       Running   0          3m
   frontend-z49di       1/1       Running   0          3m
   redis-master-nogsw   1/1       Running   0          3m
   redis-slave-592sz    1/1       Running   0          3m
   redis-slave-eos92    1/1       Running   0          3m
   ```

   - Make sure the fronend service created the ELB and get the ELB link (`LoadBalancer Ingress`)
   ```
   $ /opt/local/bin/kubectl describe service frontend
   Name:       frontend
   Namespace:     default
   Labels:        name=frontend
   Selector:      name=frontend
   Type:       LoadBalancer
   IP:         10.3.0.58
   LoadBalancer Ingress:   ab215f0f1df1511e5b39c0ee7c7529bc-932350016.us-east-1.elb.amazonaws.com
   Port:       <unnamed>   80/TCP
   NodePort:      <unnamed>   30435/TCP
   Endpoints:     10.2.72.5:80,10.2.80.3:80,10.2.80.4:80
   Session Affinity: None
   Events:
     FirstSeen LastSeen Count From        SubobjectPath  Reason         Message
     ───────── ──────── ───── ────        ─────────────  ──────         ───────
     3m     3m    1  {service-controller }         CreatingLoadBalancer Creating load balancer
     3m     3m    1  {service-controller }         CreatedLoadBalancer  Created load balancer
   ```

   - You can access the pod using the ELB address i.e `http://ab215f0f1df1511e5b39c0ee7c7529bc-932350016.us-east-1.elb.amazonaws.com/` 

   - If everything is ok you can cleanup by running
   ```
   $ bash kubernetes/example/cleanup.sh
   ```

