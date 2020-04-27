<img width=100 src="https://raw.githubusercontent.com/ThinGuy/svg/master/Ubuntu_Badge-Circle_Of_Friends.svg?sanitize=true" title="Ubuntu LTS"><img width=100 src="https://raw.githubusercontent.com/ThinGuy/svg/master/Ubuntu_Badge-Focal_Fossa.svg?sanitize=true" title="Ubuntu 20.04 LTS Focal Fossa"><img width=100 src="https://raw.githubusercontent.com/ThinGuy/svg/master/Ubuntu_Badge-Bionic_Beaver.svg?sanitize=true" title="Ubuntu 18.04 LTS Bioic Beaver"><img width=100 src="https://raw.githubusercontent.com/ThinGuy/svg/master/Ubuntu_Badge-Xenial_Xerus.svg?sanitize=true" title="Ubuntu 16.04 LTS Xenial Xerus"><img width=100 src="https://raw.githubusercontent.com/ThinGuy/svg/master/Ubuntu_Badge-Trusty_Tahr.svg?sanitize=true" title="Ubuntu 14.04 LTS Trusty Tahr">

# Open Source Security Audit (ossa)
A set of non-invasive, lightweight scripts to gather information about [open source packages](https://ubuntu.com/about/packages) that are being used on [LTS versions](https://ubuntu.com/about/release-cycle) of [Ubuntu](https://ubuntu.com/about) for the purpose of a [security](https://usn.ubuntu.com/) and [support](https://ubuntu.com/support) assessment

## Downloading the Scripts

```
git clone https://github.com/ThinGuy/ossa.git
```

## Available Scripts

* [ossa-collector](https://github.com/ThinGuy/ossa/tree/master/ossa-collector) - Gathers information about a remote machine's packages and processes, etc. 
* [ossa-generator](https://github.com/ThinGuy/ossa/tree/master/ossa-generator) - This script processes the information obtained via collector.

### Prerequisites

* Target machine(s): (physical, virtual, container) running Ubuntu 14.04 or later
	* A standard user (non-privileged) account on the machine
	* An account with ssh access

* Source Machine: (physical, virtual, container)
	* MacOS, Linux, and Windows 10 with "Windows Subsystem for Linux" (WSL) all work
		* Windows users can make use of powershell, but that is an exercise left to the user


## Running the scripts

* See README.md in each directory for documentation for notes on how to run each script and a description about the information that is collected.

