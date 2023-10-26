draw-sweep:
	keymap parse -z config/cradio.keymap > ./assets/sweep-keymap.yaml
	keymap draw ./assets/sweep-keymap.yaml >./assets/sweep-keymap.svg

install-keymap:
	virtualenv venv
	pip3 install keymap-drawer --upgrade

pipx-keymap:
	pipx install keymap-drawer

draw-reviung34:
	keymap parse -z config/reviung34.keymap > ./assets/reviung34-keymap.yaml
	keymap draw ./assets/reviung34-keymap.yaml >./assets/reviung34-keymap.svg

draw-reviung5:
	keymap parse -z config/reviung5.keymap > ./assets/reviung5-keymap.yaml
	keymap draw ./assets/reviung5-keymap.yaml >./assets/reviung5-keymap.svg
