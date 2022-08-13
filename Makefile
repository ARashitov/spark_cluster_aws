env_create:
	conda create -n spark_cluster_aws python=3.10 -y

env_configure: env_install_dependencies env_install_precommit_hooks
	echo "Environment is configured"

env_install_precommit_hooks:
	pre-commit install && pre-commit install --hook-type commit-msg

env_install_dependencies:
	pip3 install pre-commit

env_delete:
	conda remove --name spark_cluster_aws --all -y

run_precommit:
	pre-commit run --all-files
