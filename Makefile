all:
	echo "Build keymap picture"
	keymap parse  -z config/cradio.keymap > sweep.yaml
	keymap draw sweep.yaml >./3x5-keymap.svg
	rm sweep.yaml

install-keymap:
	virtualenv venv
	pip3 install keymap-drawer --upgrade
