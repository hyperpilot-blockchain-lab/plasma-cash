format:
	black --line-length 79 -S .
	isort -rc

# YAPF
yapf-format:
	yapf -r -i -p --exclude="unit_test.py,config.py" --style .style.yapf . 

test:
	pytest unit_test.py
