# Sbaysalt Toolbox

Sbaysalt means Matlab-baysalt-toolbox

## Installation

1. Shell/Powershell/Command Prompt.

```shell
git clone https://github.com/ChristmasZCY/Sbaysalt.git
```

## Contains

### `Activate.sh` :

Activate the virtual environment.

```bash
source Activate.sh
```

### `appInfo` :

Get the information of the application.

```bash
./appInfo -h
./appInfo nginx
```

### `createEmptyFile` :

Create an empty file, with the specified size and name.

```bash
./createEmptyFile -h
./createEmptyFile 19M test.txt
```

### `download_from_cmems.sh` :

Download files from Copernicus Marine Environment Monitoring Service (CMEMS) server.

```bash
./download_from_cmems.sh
```

### `download_from_ftp.sh` :

Download files from ftp server. (Not yet completed.)

```bash
./download_from_ftp.sh
```

### `make_remote_gitrepo.sh` :

Make a remote git repository.

```bash
./make_remote_gitrepo.sh
```

### `nco_ddt.sh` :

To cycle through the files in the specified directory, extract the specified variables, and merge them into a single file.

```bash
./nco_ddt.sh
```

### `portTest` :

Test the port of the server.

```bash
./portTest 22
./portTest 22 -ip localhost
```

### `Calc_startupTime` :

Calculate the startup time of system.

```bash
./Calc_startupTime
```

### `getProcess_dd` :

Get the process information of `dd` cmd.

```bash
./getProcess_dd
```

### `ptar`

tar processbar

```bash
./ptar zxf Model.tgz
```

### `changeTime`:

Method of changing the time.

```bash
cat ./changeTime
```

### `cpuUsed` :

Get the CPU usage of the system.

```bash
./cpuUsed
```

### `addKa` :

Make 卡顿
    
```bash
cat ./addKa
```

### `loginInfo` :

Get the login information of the system.

```bash
./loginInfo
```

### `ddTestSpeed` :

Test the speed of `dd` cmd.

```bash
./ddTestSpeed
```


### `systemd-analyze ` :

系统启动性能分析

```bash
systemd-analyze plot > systemd-analyze.svg
```

### `diffDir` :

Diff two directories.

```bash
diffDir dir1 dir2
```

### `cpuUser` :

Get the CPU usage of the user.

```bash
./cpuUser
```

### `InstallDate` : 

Get the installation date of the system.

```bash
./InstallDate
```

### `changeMacFormat` : 

Change the format of the MAC address.

```bash
./changeMacFormat
```
