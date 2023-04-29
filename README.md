
# Equilibria service node easy setup guide



## Installation

### Pull this script from github
`git clone https://github.com/GreggyGB/Node-Quick-Start.git Equilibria`

### Go into newly created folder

`cd Equilibria`

### Run install script

`bash equilibria.sh install`

### To start service node

`bash equilibria.sh start`

### To start the 2nd service node
`bash equilibria2.sh install`
from Equilibria folder

### To start the 3rd service node
`bash equilibria3.sh install`
from Equilibria folder

I would recommend synchronising one by one on a lower specs machines.

If you come across any issues, please visit node operators chats.

## Additional commands:

### To check service status:

`bash equilibria.sh status`

### To check how it is working:

`bash equilibria.sh log`

### To generate staking transaction:

`bash equilibria.sh prepare_sn`

### To print service node key:

`bash equilibria.sh print_sn_key`

### To upgrade node to latest version:

`bash equilibria.sh update`
 then
`bash equilibria.sh fork_update`

