nmcli c add type ovs-bridge conn.interface ${BRIDGE_NAME} con-name ${BRIDGE_NAME}
nmcli c add type ovs-port conn.interface ${BRIDGE_NAME} master ${BRIDGE_NAME} con-name ovs-port-${BRIDGE_NAME}
nmcli c add type ovs-interface slave-type ovs-port conn.interface ${BRIDGE_NAME} master ovs-port-${BRIDGE_NAME}  con-name ovs-if-${BRIDGE_NAME}
nmcli c add type ovs-port conn.interface ${IF2} master ${BRIDGE_NAME} con-name ovs-port-${IF2}
nmcli c add type ethernet conn.interface ${IF2} master ovs-port-${IF2} con-name ovs-if-${IF2}
nmcli conn delete ${IF2}
nmcli conn mod ${BRIDGE_NAME} connection.autoconnect yes
nmcli conn mod ovs-if-${BRIDGE_NAME} connection.autoconnect yes
nmcli conn mod ovs-if-${IF2} connection.autoconnect yes
nmcli conn mod ovs-port-${IF2} connection.autoconnect yes
nmcli conn mod ovs-port-${BRIDGE_NAME} connection.autoconnect yes
nmcli conn mod ovs-if-${BRIDGE_NAME} ipv4.address ${IP_ADDRESS}
nmcli conn mod ovs-if-${BRIDGE_NAME} ipv4.method static
nmcli conn mod ovs-if-${BRIDGE_NAME} ipv4.route-metric 50

# move the default route to br-ex
BRIDGE_NAME=br-ex
nmcli conn mod ovs-if-${BRIDGE_NAME} ipv4.gateway "192.168.123.254"
nmcli conn mod ${IF1} ipv4.never-default yes
# Change DNS to 8.8.8.8
nmcli conn mod ${IF1} ipv4.ignore-auto-dns yes
nmcli conn mod ovs-if-${BRIDGE_NAME} ipv4.dns "8.8.8.8"
