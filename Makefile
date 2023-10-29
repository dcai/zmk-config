all: draw-sweep draw-reviung34 draw-reviung5

draw-sweep:
	keymap parse -z config/cradio.keymap > ./assets/sweep-keymap.yaml
	keymap draw ./assets/sweep-keymap.yaml >./assets/sweep-keymap.svg

install:
	test -d venv || python3 -m venv ./venv
	. ./venv/bin/activate
	pip3 install -Ur requirements.txt

pipx-keymap:
	pipx install keymap-drawer

draw-reviung34:
	keymap parse -z config/reviung34.keymap > ./assets/reviung34-keymap.yaml
	keymap draw ./assets/reviung34-keymap.yaml >./assets/reviung34-keymap.svg

draw-reviung5:
	keymap parse -z config/reviung5.keymap > ./assets/reviung5-keymap.yaml
	keymap draw ./assets/reviung5-keymap.yaml >./assets/reviung5-keymap.svg
