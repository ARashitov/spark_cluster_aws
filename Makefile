precommit_install:
	pre-commit install && pre-commit install --hook-type commit-msg

precommit_run:
	pre-commit run --all-files
