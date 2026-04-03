# Security Policy

## Reporting a Vulnerability

Please **do not** open a public GitHub issue for security vulnerabilities.

Instead, report them via [GitHub's private vulnerability reporting](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing/privately-reporting-a-security-vulnerability) for this repository.

Include as much detail as possible:

- A description of the vulnerability and its potential impact
- Steps to reproduce
- Any suggested mitigations

You can expect an acknowledgment within 48 hours and a resolution timeline once the issue has been assessed.

## Dependency Security

This project uses [`cargo-deny`](https://github.com/EmbarkStudios/cargo-deny) to check dependencies against the [RustSec Advisory Database](https://rustsec.org/) on every CI run. To check locally:

```shell
make audit
```
