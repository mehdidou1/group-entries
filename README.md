# Group-Entries

[![Pharo P14](https://img.shields.io/badge/Pharo-P14-2c98f0.svg)](https://github.com/pharo-completion/group-entries)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/pharo-completion/group-entries/blob/master/LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/pharo-completion/group-entries/pulls)
[![Status: Active](https://img.shields.io/badge/status-active-success.svg)](https://github.com/pharo-completion/group-entries)

Group Entries is a Pharo extension that clusters raw completion entries into meaningful groups, making results easier to browse and understand. Entries that don’t fit any group remain as standalone completion candidates, ensuring nothing is lost.

---

# Example:

<img width="915" height="650" alt="GroupEntries" src="https://github.com/user-attachments/assets/a4bd0082-cf22-4851-bfac-216f8e042856" />


---

```smalltalk
Metacello new
  githubUser: 'pharo-completion' project: 'group-entries' commitish: 'main' path: 'src';
  baseline: 'GroupEntries';
  load.
```
