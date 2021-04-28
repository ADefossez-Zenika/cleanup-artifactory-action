# Cleanup Artifactory Action

> Maintainers: Delivery Experience - ADEO

This action will help you cleanup your JFrog Artifactory repository by deleting artifacts matching a specific pattern

## Rationale

Thanks to CI/CD you often build your artifact (Maven package, Docker image...) and deploy it to your JFrog Artifactory repository.
Or you use feature branches and deploy to a "development environment" to test your changes on a live system.
However all these artifacts add up over time, and take up more and more space on your instance.

With this action you can clean up old artifacts using a few rules: for example if you use the branch name as a prefix to name your artifacts, you can delete them all when you delete the corresponding branch.

## Usage

```yaml
jobs:
  cleanup:
    # ...
    steps:
      # ...
      - name: Cleanup artifacts
        uses: adeo/cleanup-artifactory-action@v1
        with:
          # Example: https://company.jfrog.io/artifactory if you are using JFrog Cloud
          artifactoryUrl: "https://your.artifactory.url"
          # You can store this in GitHub secrets or retrieve it from a secret store, eg. Hashicorp Vault
          apiKey: "${{ secrets.JFROG_API_KEY }}"
          repository: "docker-local"
          path: "my-folder/my-image"
          # The pattern to delete, you can use "stars (*)" globs
          pattern: "dependabot-pip-responses-*"
          # The "dryRun" argument is optional and defaults to "true".
          # You MUST specify it to "false" for the action to delete anything.
          # This is to avoid any mistake and wrongly deleting artifacts.
          # Please check the logs when running in dry run mode
          dryRun: "false"
```

## Other examples

See more complete workflow implementation in directory `/examples`:
  * [`secrets-from-github`](examples/secrets-from-github.yml): Delete JFrog artifact on branches deletion with JFrog token in GitHub secrets
  * [`secrets-from-vault`](examples/secrets-from-vault.yml): Delete JFrog artifact on branches deletion with JFrog token in Hashicorp Vault
