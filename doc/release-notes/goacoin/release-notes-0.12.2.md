GoaCoin Core version 0.12.2
========================

Release is now available from:

  <https://github.com/goacoincore/goacoin/releases>

This is a new major version release, bringing new features and other improvements.

Please report bugs using the issue tracker at github:

  <https://github.com/goacoincore/goacoin/issues>

Upgrading and downgrading
=========================

How to Upgrade
--------------

If you are running an older version, shut it down. Wait until it has completely
shut down (which might take a few minutes for older versions), then run the
installer (on Windows) or just copy over /Applications/GoaCoin-Qt (on Mac) or
goacoind/goacoin-qt (on Linux).

Downgrade warning
-----------------
### Downgrade to a version < 0.12.2

Because release 0.12.2 includes DIP0001 (2 MB block size hardfork) plus
a transaction fee reduction and a fix for masternode rank calculation algo
(which activation also depends on DIP0001) this release will not be
backwards compatible after DIP0001 lock in/activation happens.

This does not affect wallet forward or backward compatibility.

Notable changes
===============

DIP0001
-------

We outline an initial scaling mechanism for GoaCoin. After deployment and activation, GoaCoin will be able to handle double the transactions it can currently handle. Together with the faster block times, GoaCoin we will be prepared to handle eight times the traffic of Bitcoin.


Fee reduction
-------------

All transaction fees are reduced 10x (from 10K per Kb to 1K per Kb), including fees for InstantSend (from 0.001 GOA per input to 0.0001 per input)

InstantSend fix
---------------

The potential vulnerability found by Matt Robertson and Alexander Block was fixed in d7a8489f3 (#1620).

RPC changes
-----------

There are few changes in existing RPC in this release:
- There is no more `bcconfirmations` field in RPC output and `confirmations` shows blockchain only confirmations by default now. You can change this behaviour by switching new `addlockconf` param to `true`. There is a new rpc field `instantlock` which indicates whether a given transaction is locked via InstantSend. For more info and examples please see https://github.com/goacoincore/goacoin/doc/instantsend.md;
- `gobject list` and `gobject diff` accept `funding`, `delete` and `endorsed` filtering options now, in addition to `valid` and `all` currently available;
- `vin` field in `masternode` commands is renamed to `outpoint` and shows data in short format now;
- `getblocktemplate` output is extended with versionbits-related information;
- Output of wallet-related commands `validateaddress` is extended with optional `hdkeypath` and `hdchainid` fields.

There are few new RPC commands also:
- `masternodelist info` shows additional information about sentinel for each masternode in the list;
- `masternodelist pubkey` shows pubkey corresponding to masternodeprivkey for each masternode in the list;
- `gobject check` allows to check proposal data for correctness before preparing/submitting the proposal, `gobject prepare` and `gobject submit` should also perform additional validation now though;
- `setnetworkactive` allows to turn all network activity on and off;
- `dumphdinfo` displays some information about HD wallet (if available).

Command-line options
--------------------

New: `assumevalid`, `blocksonly, `reindex-chainstate`

Experimental: `usehd`, `mnemonic`, `mnemonicpassphrase`, `hdseed`

See `Help -> Command-line options` in Qt wallet or `goacoind --help` for more info.

PrivateSend improvements
------------------------

Algorithm for selecting inputs was slightly changed. This should allow user to get some mixed funds much faster.

Lots of backports, refactoring and bug fixes
--------------------------------------------

We backported some performance improvements from Bitcoin Core and aligned our codebase with their source a little bit better. We still do not have all the improvements so this work is going to be continued in next releases.

A lot of refactoring and other fixes should make code more reliable and easier to review now.

Experimental HD wallet
----------------------

This release includes experimental implementation of BIP39/BIP44 compatible HD wallet. Wallet type (HD or non-HD) is selected when wallet is created via `usehd` command-line option, default is `0` which means that a regular non-deterministic wallet is going to be used. If you decide to use HD wallet, you can also specify BIP39 mnemonic and mnemonic passphrase (see `mnemonic` and `mnemonicpassphrase` command-line options) but you can do so only on initial wallet creation and can't change these afterwards. If you don't specify them, mnemonic is going to be generated randomly and mnemonic passphrase is going to be just a blank string.

**WARNING:** The way it's currently implemented is NOT safe and is NOT recommended to use on mainnet. Wallet is created unencrypted with mnemonic stored inside, so even if you encrypt it later there will be a short period of time when mnemonic is stored in plain text. This issue will be addressed in future releases.
