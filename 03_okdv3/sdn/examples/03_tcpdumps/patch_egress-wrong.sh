oc patch hostsubnet node17.lab.local -p '{"egressCIDRs": ["10.16.1.224/27"]}'
oc patch hostsubnet node18.lab.local -p '{"egressCIDRs": ["10.16.1.224/27"]}'
oc patch netnamespace krakend -p '{"egressIPs": ["10.16.1.225"]}'
