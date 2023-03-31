# .bash_profile

# varaibles for color scheme
RED_FG=`tput setaf 1`
WHITE_BG=`tput setab 7`
GREEN_FG=`tput setaf 2`
RESET=`tput sgr0`

echo "${RED_FG}${WHITE_BG}.bashprofile loading...${RESET}"
#echo $'\e[1;33m'.bashprofile loading...$'\e[0m'

# User specific environment and startup programs
echo "${RED_FG}${WHITE_BG}modules loading...${RESET}"

module load python/3.9.1
module load gcc/9.3.0
module load icc
module load mkl
module load mpi-oneapi
module load openmpi

echo "${GREEN_FG}${WHITE_BG}modules loaded!!${RESET}"
echo "${RED_FG}${WHITE_BG}.bashrc loading...${RESET}"

# Get the aliases and functions (reads .bashrc)
if [ -f ~/.bashrc ]; then
	        . ~/.bashrc
fi

echo "${GREEN_FG}${WHITE_BG}.bashrc loaded!!${RESET}"
