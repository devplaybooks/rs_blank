# Rust Blank

Starting Point for Rust projects. Feel free to adapt as needed.

One will notice the lack of any Rust code in this template. That is intentional.
This is a collection of supporting files that I find useful beyond what is
provided by [cargo init](https://doc.rust-lang.org/cargo/commands/cargo-init.html).
Rather than try to replace what it does, I just wanted a way to add the things 
that I find useful.

This template is designed to be
[cruel to be kind in the right measure](https://www.youtube.com/watch?v=b0l3QWUXVho).

You can see an example of it in use at [devplaybooks/rust_blank_example](https://github.com/devplaybooks/rust_blank_example).

## How to use it. 

* Use the template. (Note that your first build will fail because there is no code yet.)
* Check out your new repo locally. 
* Navigate into the repo
* Run [cargo init](https://doc.rust-lang.org/cargo/commands/cargo-init.html)
  * If you want a library instead of an executable, run `cargo init --lib`

## What's in the box?

* GPL 3.0 License
* .rustfmt.toml file
* GitHub Actions

### [GNU General Public License Version 3](https://www.gnu.org/licenses/gpl-3.0.en.html)

I start out with this one because it's the least flexible, and [adjust accordingly](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository)
to my needs. 

### My version of Robbepop's [.rustfmt.toml file](https://gist.github.com/Robbepop/f88d896f859712384039813fab939172).

It allows you to customize how the [rstfmt cargo command](https://github.com/rust-lang/rustfmt)
does its job. In my case, that means changing the max width of a file from 80
characters to 100:

```
# Ideal width of each line.
# Default: 80
max_width = 100
```

### David Tolnay's [Rust Toolchain GitHub Action](https://github.com/dtolnay/rust-toolchain)

I've been a big fan of [svartalf's](https://github.com/svartalf) [actions-rs libraries](https://github.com/actions-rs),
but it doesn't seem to be maintained, and I'm getting [warnings](https://github.blog/changelog/2022-09-22-github-actions-all-actions-will-begin-running-on-node16-instead-of-node12/)
now from GitHub, so I'm switching. It's surprisingly simple and flexible.

This workflow contains a cron schedule to run [every 1st day of the month](https://crontab.guru/#40_1_1_*_*). 
Note that [GitHub says](https://docs.github.com/en/actions/managing-workflow-runs/disabling-and-enabling-a-workflow#article-contents)
that it will disable scheduled workflows on forked repos or if there has been no
activity in 60 days.

If you're not familiar with [GitHub Actions](https://github.com/features/actions),
I recommend that you check them out.

[.github/workflows/ci.yaml](/.github/workflows/ci.yaml) contains the following jobs:

**test**

Tests the code against Rust's [stable](https://github.com/rust-lang/rust/blob/master/RELEASES.md),
beta, and nightly [channels](https://rust-lang.github.io/rustup/concepts/channels.html),
as well as the 1.56.0 release of Rust. 

**clippy**

I like my [Clippy lints](https://doc.rust-lang.org/clippy/) to be dialed up to 11,
so it's configured at the pedantic level. Feel free to dial it down as you see fit.

Note that if you don't add `#![warn(clippy::pedantic)]` at the beginning of your
crate, Clippy will pass locally, but fail when you push. For example:

```rust
#![warn(clippy::pedantic)]

fn main() {
    println!("Hello, world!");
}
```

**fmt**

Fails the build if the developer didn't run
[rustfmt](https://github.com/rust-lang/rustfmt) against the build.

**miri**

I had never heard of [Miri](https://github.com/rust-lang/miri) before I saw it
in [this example](https://github.com/dtolnay/thiserror/blob/master/.github/workflows/ci.yml),
but it looks interesting, so why not?

Miri is a heavy test, so it may be wise to remove it.

**outdated**

Runs the [outdated cargo subcommand](https://github.com/kbknapp/cargo-outdated)
against the repo. Fails the build if you have any outdated dependencies in your
project. If you keep the cron schedule, it will check every month to see if any
of your dependencies are outdated. 
