# Ansible-Proxmox

Este repositorio contiene playbooks de Ansible para automatizar la creación y configuración de contenedores LXC y máquinas virtuales (VM) en un servidor Proxmox.

## Estructura del repositorio

### Archivos principales
- **`01-create_lxc.yml`**: Playbook para crear y configurar contenedores LXC en Proxmox.
- **`01-create_vm_range.yml`**: Playbook para crear y configurar un rango de máquinas virtuales (VM) en Proxmox utilizando imágenes compatibles con Cloud-init.
- **`scripts/install_basics.sh`**: Script para instalar paquetes básicos, Docker y Kubernetes en sistemas Linux.
- **`README.md`**: Documentación del repositorio.

### Variables utilizadas
Los playbooks utilizan variables para personalizar la configuración de las VMs y LXC. Algunas de las variables clave incluyen:
- `lxc_base_id`: ID base para los contenedores LXC.
- `vm_base_id`: ID base para las máquinas virtuales.
- `total_lxc` y `total_vm`: Número total de LXC o VMs a crear.
- `memory`: Memoria asignada a las VMs o LXC.
- `cores`: Núcleos de CPU asignados.
- `disk_size`: Tamaño del disco para las VMs.
- `bridge_name`: Nombre del puente de red en Proxmox.
- `ci_user` y `ci_password`: Usuario y contraseña para Cloud-init en las VMs.

## Requisitos

1. **Proxmox VE**: Debes tener un servidor Proxmox configurado y accesible.
2. **Ansible**: Instala Ansible en tu máquina local:
   ```bash
   sudo apt update
   sudo apt install ansible -y

3. **Cloud-init**: Las imágenes utilizadas para las VMs deben ser compatibles con Cloud-init.

## Uso
Crear contenedores LXC
Ejecuta el playbook 01-create_lxc.yml para crear y configurar contenedores LXC:

```bash
ansible-playbook 01-create_lxc_range.yml -i inventory.yml
```

Crear máquinas virtuales (VM)
Ejecuta el playbook 01-create_vm_range.yml para crear un rango de VMs:

```bash
ansible-playbook 01-create_vm_range.yml -i inventory.yml
```

Subir imágenes Cloud-init
Sube una imagen compatible con Cloud-init al servidor Proxmox:

```bash
scp debian-12-genericcloud-amd64.qcow2 root@<proxmox_ip>:/var/lib/vz/template/qcow2/
```

Configurar paquetes básicos
Ejecuta el script install_basics.sh dentro de una VM o contenedor para instalar paquetes básicos, Docker y Kubernetes:

```bash
bash install_basics.sh
```

## Personalización
Edita las variables en los playbooks o en el archivo de inventario (inventory.yml) para ajustar la configuración según tus necesidades.

## Contribuciones
Si deseas contribuir a este repositorio, puedes enviar un pull request o abrir un issue para reportar problemas