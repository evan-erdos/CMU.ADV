#!/bin/bash
# cmu-adv

function usage {
	echo "usage: .cmu-adv [-chrw]"
}

function help {
	usage
	echo "options:
-b, --build    clean both targets and compile, run
-c, --clean    clean /obj directory without compiling
-h, --help     this help text
-r, --run      runs the console build
-w, --web      runs the web build"
}

function clean {
	t3make -clean -f cmu_adv_cmd.t3m
	t3make -clean -f cmu_adv_web.t3m
}

function build {
	t3make -f cmu_adv_web.t3m &&
	t3make -f cmu_adv_cmd.t3m && run
}

function run {
	frob tgt/cmu_adv_cmd.t3
}

function web {
	frob tgt/cmu_adv_web.t3
}

if [ $# -gt 0 ]; then
while [ "$1" != "" ]; do
	case $1 in
		-b | --build )  build
						exit;;
		-c | --clean )	clean;;
		-h | --help )	help
						exit;;
		-r | --run )	run;;
		-w | --web )	web;;
		* )				usage
						exit 1
	esac
	shift
done
else
	build
fi
