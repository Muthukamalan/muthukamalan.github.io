lint:
	uv run pre-commit run --all-files

install:
	uv tool install pre-commit

update:
	uv run pre-commit autoupdate