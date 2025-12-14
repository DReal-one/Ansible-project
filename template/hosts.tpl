# TARGET GROUP
[Nodes]
% { for ip in servers ~}
% {ip} ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/${key_name}.pem
% { endfor ~}