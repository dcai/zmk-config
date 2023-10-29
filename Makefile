all: draw-cradio draw-reviung34 draw-reviung5

install:
	test -d venv || python3 -m venv ./venv
	. ./venv/bin/activate
	pip3 install -Ur requirements.txt

pipx-keymap:
	pipx install keymap-drawer

draw-reviung34:
	@./build.sh reviung34

draw-reviung5:
	@./build.sh reviung5

draw-cradio:
	@./build.sh cradio

