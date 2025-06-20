#! /bin/bash
apt update
apt upgrade -y
apt install -y btop curl apt-transport-https ca-certificates software-properties-common gpg tmux htop vim git sudo

curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y kubelet kubeadm kubectl

swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab
containerd config default > /etc/containerd/config.toml
sed -i 's|sandbox_image = "registry.k8s.io/pause:[^"]*"|sandbox_image = "registry.k8s.io/pause:3.10"|' /etc/containerd/config.toml
sed -i 's/^\(\s*SystemdCgroup\s*=\s*\)false/\1true/' /etc/containerd/config.toml
systemctl restart containerd

usermod -aG docker $USER
usermod -aG sudo $USER
echo overlay > modules
echo br_netfilter >> modules
cp modules /etc/modules

exit 0