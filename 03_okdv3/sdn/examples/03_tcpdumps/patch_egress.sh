#oc patch hostsubnet node17.lab.local -p '{"egressCIDRs": ["10.1.16.224/27"]}'
oc patch hostsubnet node18.lab.local -p '{"egressCIDRs": ["10.1.16.224/27"]}'
oc patch netnamespace krakend -p '{"egressIPs": ["10.1.16.225"]}'
