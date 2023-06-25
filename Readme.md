# Dab

`Dab` is a simplistic set of conventions for managing container image `tags` as 
related to git repositories. It aims at providing immediate and intuitive answers 
as to what builds are available at a simple look at the git graph.

`Dab`'s simplicity aims at setting it as a reasonable default.
Your team/project is likely to outgrow it. But it doesn't have to. You do you.

It's this:

| `git` world       | key                                  | is mutable? | can disappear?                   | `:tag` world    | example                          |
|-------------------|--------------------------------------|-------------|----------------------------------|-----------------|----------------------------------|
| commit            | short sha `e768123h`                 | false       | true  (if no branch contains it) | immutable image | `c-e768123h`                     |
| commit (mainline) | short sha `e768123h`                 | false       | false                            | immutable       | `c-e768123h`                     |
| branch            | a slug `feature-my-fanstasic-branch` | true        | true                             | mutable image   | `b-feature-my-fanstastic-branch` |
| tag               | a slug `v-2-0-0dev123-test`          | false       | true                             | immutable image | `t-v-2-0-0dev123-test `          |
| ?                 |                                      |             |                                  | mutable image   | `latest`                         |
