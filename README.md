# Redpanda Cluster Fun

I needed to experiment with different scenarios with cluster member
addition/deletion/etc. so I did what any software person does: wrote a
bunch of shell scripts.

## Prerequisites

You need:
 - `docker`
 - 16GB memory maybe?
 - a POSIX shell (tested with Bash, but
 - `awk` (tested with GNU awk)
 - common Unix utilities (`grep`, `tr`, `sort`)

> All scripts here have been checked with shellcheck and shouldn't
> have any Bash-isms.

## The Scripts

### `config`

Contains default config properties. You can either modify this or set
the appropriate environment variables to override the defaults.

### `core`

Starts a 3-node Redpanda cluster, with broker containers named:
  - `redpanda-1`
  - `redpanda-2`
  - `redpanda-3`

Kafka API and Admin API ports are locally exposed using the format
`{idx}9092` and `{idx}9644`, respectively, where `{idx}` is the
numeric suffix of the container name. For example, `redpanda-2` would
use local ports `29092` and `29644`.

### `rpk.sh`

Wraps invoking `rpk` from the Redpanda Docker image within the same
network as the Redpanda cluster. Simply pass it arguments like you'd
pass `rpk`.

### `add`

Add a new cluster member. Automatically finds a vacant spot in the
list of `redpanda-N` containers, where `N is in the range [1, 5]
inclusive`.

> `N` in this case is referred to as the "broker id"...a term that
> only has meaning _for these scripts_.

### `remove [broker id]`

Decommission and remove a broker by it's _broker id_. (See `add` for details.)

Will us `rpk` to decommission the node and wait for it to complete
before returning.

### `kill [broker id]`

As the name implies, kill it with fire. Will *not* decommission the
node in advance, so this can simulate a catastrophic failure of a
broker.

### `stop-all`

Bring the cluster down via `docker stop`.
