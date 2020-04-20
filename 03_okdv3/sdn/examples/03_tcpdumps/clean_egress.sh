oc patch hostsubnet node17.lab.local -p '{"egressCIDRs": []}'
oc patch hostsubnet node18.lab.local -p '{"egressCIDRs": []}'
oc patch netnamespace krakend -p '{"egressIPs": []}'
