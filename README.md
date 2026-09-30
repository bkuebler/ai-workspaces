# AI Workspaces

AI Workspaces is a bootstrap repository for setup an environment for coding
tools like claude code, opencode, pi. It avoids the mono repository approach
where coding agents get all required information about all small pieces of an
platform / organization which is then added into one repository. This repo
will help to keep existing small repositories for every software asset, config
and so on, but give the tool the ability to search required additional domain
information across multiple repositories more structured.

## Create a new workspace

```bash
uvx copier copy git@github.com:bkuebler/ai-workspaces.git mynew-workspace
cd mynew-workspace
git init && git add -A && git commit -m "Initial workspace"
gh repo create MYORG/mynew-workspace --private --source . --push
./bootstrap.sh
```

## Update workspace to a new ai workspaces version

```bash
uvx copier update   # workspace must have no uncommited changes
```

